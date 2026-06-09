# Guardrails

The one rule of this repo: **never run an uncapped loop.** Every loop carries
all three hard stops. A cost *alert* is not *enforcement* — Anthropic's billing
layer has soft alerts and budget thresholds but **does not auto-disable**, so
the ceiling has to live in your loop harness.

## The three hard stops

1. **Max iteration count** — bound the number of turns. Anthropic's Agent SDK
   ships this as `max_turns`; `/ralph-loop` as `--max-iterations`; bash ralph as
   a counter. Default cap: **20**.
2. **No-progress / stall detection** — bail when the loop stops advancing
   (no git diff, repeated identical actions, unchanged test state) for **3**
   consecutive iterations; document blockers instead of looping.
3. **Token / dollar budget ceiling** — a hard enforcement stop. Agent SDK ships
   `max_budget_usd`. In a bash loop, wire a real cost meter and check it
   *before* the next paid call.

Plus, always: **verification inside the loop** — one deterministic check
(test/lint/typecheck) the agent runs itself, declaring done only on pass.

## Why this matters (the receipts)

- Uber capped engineers at **$1,500/month per tool** after burning its annual AI
  budget in ~4 months.
- A multi-agent system reportedly **looped 11 days and ran up $47K**.
- Every turn re-bills the full accumulated context; a 20-step loop can cost
  ~10x a naive per-step estimate.

See `guardrails/checklist.md` for the preflight, and `budget.env` for the
default thresholds the skills read.
