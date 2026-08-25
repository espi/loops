#!/usr/bin/env bash
#
# Ralph loop runner — a bash while-loop with ALL THREE hard stops baked in.
# Feeds a fixed PROMPT.md to the agent each iteration; the agent advances by
# reading on-disk state (PROGRESS.md, tests, git). Copy this into your
# loops/<slug>/ dir and edit the CONFIG block.
#
# Prefer the official `ralph-wiggum` plugin (/ralph-loop ... --max-iterations N
# --completion-promise COMPLETE) when you want the loop in-session. Use this
# bash version for fully unattended/headless runs.
#
set -euo pipefail

# ---- CONFIG (edit me) ------------------------------------------------------
PROMPT_FILE="PROMPT.md"
MAX_ITERATIONS=20                 # hard stop #1: iteration cap
MAX_BUDGET_USD=10                 # hard stop #3: dollar ceiling (enforced below)
STALL_LIMIT=3                     # hard stop #2: bail after N no-progress passes
COMPLETION_MARKER="<promise>COMPLETE</promise>"
SUCCESS_CHECK="${SUCCESS_CHECK:-false}"   # e.g. "pytest -q" / "npm test"
# Agent command. --dangerously-skip-permissions only for sandboxed/headless use.
AGENT_CMD=(claude -p --dangerously-skip-permissions)
# ---------------------------------------------------------------------------

iter=0
stall=0
last_head="$(git rev-parse HEAD 2>/dev/null || echo none)"

cost_so_far() {
  # Hook your real cost meter here (e.g. parse total_cost_usd from
  # `claude -p --output-format json` output, read your gateway's spend API, or
  # an SDK max_budget_usd run). Returns a dollar figure. Default 0 = meter not
  # wired. (There is no `claude cost` subcommand; /cost is in-session only.)
  echo "${LOOP_COST_USD:-0}"
}

while :; do
  iter=$((iter + 1))

  # --- hard stop #1: iteration cap ---
  if (( iter > MAX_ITERATIONS )); then
    echo "STOP: hit MAX_ITERATIONS=$MAX_ITERATIONS"; exit 2
  fi

  # --- hard stop #3: budget ceiling (enforced BEFORE the next paid call) ---
  spent="$(cost_so_far)"
  if awk "BEGIN{exit !($spent >= $MAX_BUDGET_USD)}"; then
    echo "STOP: budget ceiling reached (\$$spent >= \$$MAX_BUDGET_USD)"; exit 3
  fi

  echo "=== iteration $iter (spent \$$spent) ==="
  output="$(cat "$PROMPT_FILE" | "${AGENT_CMD[@]}" || true)"
  echo "$output"

  # --- completion: agent declares done AND the success check passes ---
  if grep -qF "$COMPLETION_MARKER" <<<"$output"; then
    if eval "$SUCCESS_CHECK"; then
      echo "DONE: completion marker + success check passed at iteration $iter"; exit 0
    else
      echo "Agent claimed done but success check failed — continuing."
    fi
  fi

  # --- hard stop #2: no-progress detection (git HEAD unchanged) ---
  head="$(git rev-parse HEAD 2>/dev/null || echo none)"
  if [[ "$head" == "$last_head" ]]; then
    stall=$((stall + 1))
    echo "no-progress pass ($stall/$STALL_LIMIT)"
    if (( stall >= STALL_LIMIT )); then
      echo "STOP: no progress for $STALL_LIMIT iterations — see PROGRESS.md blockers"; exit 4
    fi
  else
    stall=0
    last_head="$head"
  fi
done
