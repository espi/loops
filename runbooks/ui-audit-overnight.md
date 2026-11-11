# Runbook: overnight UI audit loop

Drive every page with test accounts, auto-fix deterministic UI bugs (re-verified
live), and fix-and-document subjective UX issues in a reviewable lane — overnight,
on your Mac, against your running app. Template: `templates/ui-audit/`.

## Is this a good loop? (the honest split)

- **Yes — deterministic bugs.** Console errors, failed network requests, 404s,
  broken links/CTAs, axe a11y violations, layout breakage, visual regressions all
  have a machine-checkable pass/fail. Detect → fix → **re-verify the same check** →
  commit. A real verification loop.
- **Subjective UX — now grounded in `docs/`.** "Incorrect CTA," "not
  discoverable," "dead end" normally have no objective oracle — auto-fixing them
  unattended is the classic anti-pattern (`guardrails/checklist.md`). The preflight
  fixes this: it distills your `docs/` into `STANDARDS.md`, giving the loop a real
  oracle. UX issues then split into a **`ux(standard)`** lane (violates a cited doc
  rule — grounded, auto-fixed) and a **`ux(judgment)`** lane (no doc backing —
  fixed but flagged `needs-human`, and the one place you can switch to report-only).

## Prerequisites

- App running locally (e.g. `http://localhost:3000`).
- A **browser-driving MCP** (Playwright / chrome-devtools) connected to your
  Claude Code session — this is the verification oracle. Confirm it can read
  console + network + DOM and run axe.
- **Disposable test accounts on a non-prod environment**, seeded. The loop clicks
  destructive things.
- Clean git tree; create the work branch: `git switch -c claude/ui-fixes-$(date +%F)`.
- Optional: baseline screenshots in `baseline/` for visual diffing; `roborev init`
  for per-commit review while context is fresh.

## Set up

1. Copy `templates/ui-audit/` into your project as `./ui-audit/`.
2. **Run the preflight once** (a single reviewed pass — *not* the loop): in your
   project's session, `claude -p "$(cat ui-audit/PREFLIGHT.md)"` (or paste it). It
   discovers routes → writes `PAGES.md`, and distills `docs/` → `STANDARDS.md`.
3. **Eyeball the output before launching:** skim `PAGES.md` for missing/`TODO:`
   routes and the test-account mapping; skim `STANDARDS.md` to confirm the rules
   match your intent and the "Not covered by docs" gaps look right. This review
   gate is what makes the overnight run trustworthy — don't skip it.
4. Edit the `[bracketed]` parts of `PROMPT.md` (base URL, viewports, test command,
   branch date). `FINDINGS.md` is already in place.

## Run it

This must run **on your Mac** (the app is on localhost; a cloud Routine can't see
it) and **in the session that has the browser MCP**. That session is
**session-scoped** — if the laptop sleeps, it stops. So keep it awake.

**Recommended — headless via `templates/ralph/run.sh`** (all three stops
enforced outside the agent's reach; needs Claude Code v2.1.281+). An overnight
run is exactly the case where the stops must not depend on the agent:

1. Confirm your browser MCP works in non-interactive mode — it does if it's
   configured at user or project scope (`claude mcp list` shows it). Quick test:
   `claude -p --max-turns 3 "use the browser MCP to open <BASE_URL> and report the page title"`.
2. Copy `templates/ralph/run.sh` next to `ui-audit/` and set its CONFIG:
   `PROMPT_FILE="ui-audit/PROMPT.md"`, `MAX_ITERATIONS` ≈ `pages × accounts × 1.5`,
   `MAX_BUDGET_USD` to the number you won't exceed, `SUCCESS_CHECK` to your
   regression suite (e.g. `"npm test"`).
3. Protect the loop's own checks, so the agent can't edit what grades it:
   `PROTECTED_PATHS="ui-audit/PROMPT.md ui-audit/STANDARDS.md run.sh tests/"`.
   (`PAGES.md`, `FINDINGS.md`, `PROGRESS.md` are the agent's to update.)
4. Allowlist exactly what the audit needs — the default is deny-by-default:
   `AGENT_CMD=(claude -p --permission-mode acceptEdits --permission-prompts none --allowedTools "mcp__<browser>__*" "Bash(npm test:*)" "Bash(git add:*)" "Bash(git commit:*)")`.
5. Run it awake: `caffeinate -ids bash run.sh`.

**Fallback — in your interactive session**, only if the browser MCP can't run
headless, and only while you can check on it:

```bash
caffeinate -ids &
# inside the Claude Code session:
/ralph-loop "$(cat ui-audit/PROMPT.md)" --completion-promise "COMPLETE" --max-iterations 40
```

> Treat this as supervised, not unattended. The plugin's iteration count lives
> in `.claude/ralph-loop.local.md` inside the agent's worktree (and
> `max_iterations: 0` means unlimited), the stall rule is an instruction the
> agent grades itself on, and nothing enforces a dollar ceiling. Cancel with
> `/cancel-ralph`.

## The three hard stops (mapped, headless run)

1. **Max iterations** — `MAX_ITERATIONS` in `run.sh`, plus per-call
   `--max-turns` and a wall-clock timeout (and a finite `PAGES.md` bounds the work).
2. **No-progress** — `run.sh` stops after 3 iterations with no worktree change.
   The prompt's own "stop after 3 no-progress iterations" rule is a second
   layer, not the stop.
3. **Budget ceiling** — `MAX_BUDGET_USD`, metered from each call's
   `total_cost_usd` and passed down as each call's `--max-budget-usd`.

## Morning review

1. `git log --oneline` — three lanes, increasing scrutiny:
   - `fix(ui):` — objective, re-verified live, suite green. Accept the pile.
   - `ux(standard):` — doc-backed; each cites its rule in `FINDINGS.md`. Spot-check
     the citations, keep what's right.
   - `ux(judgment):` — no doc backing, flagged `needs-human`. **Review these first**;
     `git revert` any you disagree with (isolated one-per-commit for exactly this).
2. Read `PROGRESS.md` "BLOCKED" + every `FINDINGS.md` `needs-human` entry.
3. If a `ux(judgment)` change you keep reflects a real rule, add it to your `docs/`
   so next run's preflight promotes it to the grounded `ux(standard)` lane.
4. Run the suite yourself, then open a PR / merge what you keep. Nothing auto-merged.
