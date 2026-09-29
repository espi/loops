#!/usr/bin/env bash
#
# Ralph loop runner — a bash while-loop with ALL THREE hard stops baked in.
# Feeds a fixed PROMPT.md to the agent each iteration; the agent advances by
# reading on-disk state (PROGRESS.md, tests, git). Copy this into your
# loops/<slug>/ dir and edit the CONFIG block.
#
# Design rule: the meter must not live inside the thing it meters. Every stop
# below is enforced here, in bash state the agent can't write:
#   - the iteration counter is a shell variable, not a file in the worktree;
#   - spend is read from Claude Code's own JSON result (`total_cost_usd`), not
#     from anything the agent reports;
#   - each call is ALSO capped from outside (--max-turns, --max-budget-usd, a
#     wall-clock timeout), because a counter that only ticks between calls
#     can't stop a call that never returns. Claude Code < v2.1.281 had exactly
#     that bug — a turn that retried indefinitely, ignoring --max-turns — so
#     this script refuses to run on older versions.
#
# The official `ralph-wiggum` plugin (/ralph-loop --max-iterations N) is fine
# for supervised, in-session use, but don't make it the only cap on an
# unattended run: its iteration count lives in .claude/ralph-loop.local.md in
# the agent's own worktree, and `max_iterations: 0` there means "no limit".
# Use this script for unattended/headless runs.
#
set -euo pipefail

# ---- CONFIG (edit me) ------------------------------------------------------
# NOTE: models that take more turns per unit of work (e.g. Fable 5.1-class
# long-horizon models) trip iteration/stall caps tuned on older models earlier.
# An early stop on such a model is a re-tuning signal, not proof of failure
# (see knowledge/00-primer.md §4, Fable 5.1 breaking changes).
PROMPT_FILE="PROMPT.md"
MAX_ITERATIONS=20                 # hard stop #1: iteration cap (whole loop)
MAX_BUDGET_USD=10                 # hard stop #3: dollar ceiling (whole loop)
STALL_LIMIT=3                     # hard stop #2: bail after N no-progress passes
MAX_TURNS_PER_ITER=50             # per-call turn cap (claude -p --max-turns)
ITER_TIMEOUT_SEC=1800             # per-call wall-clock cap
MIN_CLAUDE_VERSION="2.1.281"      # first version where --max-turns always holds
COMPLETION_MARKER="<promise>COMPLETE</promise>"
SUCCESS_CHECK="${SUCCESS_CHECK:-false}"   # e.g. "pytest -q" / "npm test"
# Paths the agent must not modify (space-separated). If any change, the loop
# stops: a success check the agent can edit, or a prompt it can rewrite, is not
# a check. Add your test dir, e.g. PROTECTED_PATHS="PROMPT.md run.sh tests/".
PROTECTED_PATHS="${PROTECTED_PATHS:-$PROMPT_FILE $0}"
# Agent command. Deny-by-default for unattended runs (guardrails/README.md →
# Containment): --permission-prompts none (v2.1.259+) auto-denies anything that
# would prompt, so allowlist exactly the commands the loop needs, e.g.
#   --allowedTools "Bash(npm test:*)" "Bash(git add:*)" "Bash(git commit:*)"
# --dangerously-skip-permissions is the blunt alternative, only inside a
# disposable VM/container (it also refuses to run as root).
AGENT_CMD=(claude -p --permission-mode acceptEdits --permission-prompts none)
# ---------------------------------------------------------------------------

# die [exit-code] message...
die() { local rc=1; [[ "$1" =~ ^[0-9]+$ ]] && { rc=$1; shift; }; echo "STOP: $*" >&2; exit "$rc"; }

# --- preflight: refuse to run without the external per-call caps ---
ver="$(claude --version 2>/dev/null | awk '{print $1}')" || true
[[ -n "$ver" ]] || die "cannot read 'claude --version'"
if ! printf '%s\n%s\n' "$MIN_CLAUDE_VERSION" "$ver" | sort -V -C; then
  die "Claude Code $ver < $MIN_CLAUDE_VERSION (--max-turns could be ignored before v2.1.281); upgrade first"
fi
if command -v timeout >/dev/null; then TIMEOUT_CMD=(timeout)
elif command -v gtimeout >/dev/null; then TIMEOUT_CMD=(gtimeout)
else die "no 'timeout' command (macOS: brew install coreutils for gtimeout)"; fi
if command -v jq >/dev/null; then
  json_get() { jq -r --arg k "$1" '.[$k] // empty'; }
elif command -v python3 >/dev/null; then
  json_get() { python3 -c 'import json,sys; v=json.load(sys.stdin).get(sys.argv[1]); print("" if v is None else v)' "$1"; }
else die "need jq or python3 to read Claude Code's JSON result"; fi

# Fingerprint of the protected paths' current contents (missing files count).
protected_fp() {
  local p
  for p in $PROTECTED_PATHS; do
    if [[ -e "$p" ]]; then find "$p" -type f; else echo "MISSING:$p"; fi
  done | LC_ALL=C sort | while IFS= read -r f; do
    if [[ "$f" == MISSING:* ]]; then echo "$f"; else printf '%s ' "$f"; git hash-object "$f"; fi
  done | git hash-object --stdin
}
# Fingerprint of the work itself: the whole worktree (tracked, modified and
# untracked files), hashed through a throwaway index so the real one is never
# touched. Empty commits don't change it, so they don't count as progress.
work_fp() {
  local idx; idx="$(mktemp)"
  cp "$(git rev-parse --git-path index)" "$idx" 2>/dev/null || rm -f "$idx"
  GIT_INDEX_FILE="$idx" git add -A . >/dev/null 2>&1 || true
  GIT_INDEX_FILE="$idx" git write-tree
  rm -f "$idx"
}

iter=0
stall=0
spent=0
protected_start="$(protected_fp)"
last_work="$(work_fp)"

while :; do
  iter=$((iter + 1))

  # --- hard stop #1: iteration cap ---
  if (( iter > MAX_ITERATIONS )); then die 2 "hit MAX_ITERATIONS=$MAX_ITERATIONS"; fi

  # --- hard stop #3: budget ceiling (enforced BEFORE the next paid call) ---
  remaining="$(awk -v m="$MAX_BUDGET_USD" -v s="$spent" 'BEGIN{printf "%.4f", m - s}')"
  if awk -v r="$remaining" 'BEGIN{exit !(r <= 0)}'; then
    die 3 "budget ceiling reached (\$$spent >= \$$MAX_BUDGET_USD)"
  fi

  echo "=== iteration $iter (spent \$$spent, \$$remaining left) ==="
  rc=0
  json="$("${TIMEOUT_CMD[@]}" "$ITER_TIMEOUT_SEC" "${AGENT_CMD[@]}" \
            --max-turns "$MAX_TURNS_PER_ITER" --max-budget-usd "$remaining" \
            --output-format json < "$PROMPT_FILE")" || rc=$?
  if (( rc == 124 )); then
    die 6 "iteration $iter hit the ${ITER_TIMEOUT_SEC}s timeout; its spend is unknown, so stopping rather than guessing"
  fi

  # Spend comes from Claude Code's result, not from anything the agent says.
  cost="$(json_get total_cost_usd <<<"$json" 2>/dev/null || true)"
  [[ "$cost" =~ ^[0-9.eE+-]+$ ]] || die 6 "iteration $iter (exit $rc) returned no readable total_cost_usd; stopping"
  spent="$(awk -v s="$spent" -v c="$cost" 'BEGIN{printf "%.4f", s + c}')"
  output="$(json_get result <<<"$json" 2>/dev/null || true)"
  echo "$output"
  printf -- '--- iteration %s: %s, $%.4f, exit %s ---\n' \
    "$iter" "$(json_get subtype <<<"$json" 2>/dev/null || true)" "$cost" "$rc"

  # --- instrument integrity: the agent must not edit its own checks ---
  if [[ "$(protected_fp)" != "$protected_start" ]]; then
    die 5 "protected paths changed ($PROTECTED_PATHS) — the agent edited its own prompt, harness or tests"
  fi

  # --- completion: agent declares done AND the success check passes ---
  if grep -qF "$COMPLETION_MARKER" <<<"$output"; then
    if eval "$SUCCESS_CHECK"; then
      echo "DONE: completion marker + success check passed at iteration $iter (\$$spent)"; exit 0
    else
      echo "Agent claimed done but success check failed — continuing."
    fi
  fi

  # --- hard stop #2: no-progress detection (work unchanged) ---
  # Limit: this sees *change*, not *progress* — an agent churning files it
  # doesn't need will reset it. The iteration and dollar caps still bound that.
  work="$(work_fp)"
  if [[ "$work" == "$last_work" ]]; then
    stall=$((stall + 1))
    echo "no-progress pass ($stall/$STALL_LIMIT)"
    if (( stall >= STALL_LIMIT )); then
      die 4 "no progress for $STALL_LIMIT iterations — see PROGRESS.md blockers"
    fi
  else
    stall=0
    last_work="$work"
  fi
done
