---
name: new-loop
description: >-
  Scaffold a new, fully guarded agentic coding loop for a target task. Use when
  the user wants to "build a loop", "set up a loop", "run an agent until X", or
  automate a repeated coding task. Picks the right pattern (ralph / /goal /
  /loop), writes the files into loops/<slug>/, and bakes in the three hard stops
  plus a verification step.
argument-hint: "<task description>; done = <verifiable success check>"
---

# new-loop

Scaffold a production-ready loop for a task. Your job is to turn a one-line
intent into runnable, guarded loop files — never an uncapped loop.

## Inputs

The user gives a task and, ideally, a success check after `done =`. If the
success check is missing, **ask for it** — a loop with no deterministic stop
condition is the one mistake you must not ship. The check must be a command
that returns clear pass/fail (e.g. `pytest test/users`, `npm test`,
`tsc --noEmit`, a linter).

## Step 1 — Choose the pattern

| Pattern | Use when | Mechanism |
|---|---|---|
| **`/goal`** (default) | Iterate-to-completion on a well-scoped task with a provable success condition. | `/goal` with a separate validator model (defaults to Haiku). Requires Claude Code v2.1.139+. |
| **ralph** (`/ralph-loop` or bash) | Long autonomous build where each iteration should reset context to anchor files. | Official `ralph-wiggum` plugin, or `templates/ralph/run.sh`. |
| **`/loop`** | Recurring maintenance on an interval (babysit PRs, poll a deploy). | Bundled `/loop` skill (v2.1.72+); cron-backed, session-scoped; recurring tasks expire after 7 days. |

Default to `/goal` for "do this task once, correctly." Use ralph for
multi-hour/overnight builds. Use `/loop` only for recurring work attended
within a session — it is session-scoped (does not run with the laptop closed)
and recurring tasks expire after 7 days. For unattended / laptop-closed
scheduling, point the user at a cloud **Routine** instead (create with
`/schedule`, alias `/routines`).

## Step 2 — Scaffold

Create `loops/<slug>/` (slug derived from the task) containing:

- `PROMPT.md` — the task framed as a loop prompt: the goal, the anchor files to
  reload each iteration, the explicit deliverables, and the success check the
  agent must run before declaring done. Base it on `templates/ralph/PROMPT.md`.
- `run.sh` (ralph only) — copy of `templates/ralph/run.sh`, wired with this
  task's `MAX_ITERATIONS`, `MAX_BUDGET_USD`, and verification command.
- `RUN.md` — exact invocation for the chosen pattern, plus the stop condition,
  and a note on how to monitor cost.

## Step 3 — Bake in the three hard stops (always)

1. **Max iterations** — set a concrete cap (default 20; raise deliberately).
2. **No-progress detection** — instruct the loop to bail if N consecutive
   iterations produce no git diff / no test-state change (default N=3), and
   document blockers instead of looping forever.
3. **Budget ceiling** — set `MAX_BUDGET_USD` (ralph/SDK) or remind the user of
   the session budget. State the expected cost order-of-magnitude.

Pull the exact defaults from `guardrails/budget.env`. Reference
`guardrails/checklist.md` and confirm every box is satisfied before finishing.

## Step 4 — Report

Tell the user: the pattern chosen and why, the success check, the three caps as
set, the exact command to start the loop, and how to stop it. Do not start the
loop yourself unless asked.

## Guardrails for you

- Never scaffold a loop without a deterministic success check and all three caps.
- The success check goes *inside* the loop; the agent declares done only when it
  passes — never on self-assessment.
- Keep scaffolded loops under `loops/` (gitignored work dir) so this control
  plane stays clean.
