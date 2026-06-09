# CLAUDE.md — conventions for this repo

This repo (`loops`) is the **control plane** for agentic coding loops. It holds
tooling, templates, guardrails, and a knowledge base — not project work. When
you operate here, follow these conventions.

## What this repo is for

- Authoring and storing **reusable loop skills** (`.claude/skills/`).
- Holding **runnable templates** for the ralph, `/goal`, and `/loop` patterns.
- Keeping a **living knowledge base** (`knowledge/`) about loop techniques.
- Providing **guardrail defaults** and **runbooks**.

Loops are *run from here against other repositories*. Do not add application /
project code here.

## Non-negotiable: guardrails

Every loop this repo produces or documents MUST carry all three hard stops:

1. **Max iteration count** (`--max-iterations`, `max_turns`, or a bash counter).
2. **No-progress / stall detection** (bail if N iterations make no change).
3. **Token or dollar budget ceiling** (`max_budget_usd` or an external meter).

A cost *alert* is not *enforcement* — Anthropic's billing layer has soft alerts
but does not auto-disable. The ceiling must live in the loop harness. Never
commit or recommend an uncapped loop. See `guardrails/`.

## Verification is part of the loop, not an afterthought

Every loop needs a single deterministic success check (a test command, a
linter, a typecheck) that returns clear pass/fail, run *inside* the loop. The
agent only declares "done" when the check passes — never on its own
self-assessment of correctness.

## Knowledge base discipline

- `knowledge/00-primer.md` is the canonical briefing.
- `knowledge/sources.md` is the curated link list; every claim carries a source
  and a confidence level.
- `knowledge/CHANGELOG.md` records dated updates. The `update-knowledge` skill
  appends here.
- When you add a claim, cite a primary source and mark confidence
  (High / Medium / Low). Flag anything you could not verify against a primary
  source.

## Tooling version notes (verify against live docs before relying on these)

- `/loop` is a bundled skill, Claude Code **v2.1.72+**; cron under the hood;
  session-scoped (does not run with the laptop closed); recurring tasks expire
  after 7 days.
- `/goal` requires **v2.1.139+**; a separate validator model (defaults to
  Haiku) judges the stop condition; implemented as a session-scoped Stop hook;
  the validator does not call tools, so conditions must be provable from what
  the agent surfaces.
- **Routines** = cloud scheduling that survives with the laptop closed (min
  interval ~1 hour). Use these for the `update-knowledge` loop.
