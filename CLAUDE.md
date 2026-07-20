# CLAUDE.md — conventions for this repo

This repo (`loops`) exists to be the **central, up-to-date practice hub** for
agentic coding loops — loop engineering as a discipline. The point isn't to
describe the methodology; it's to keep it accurate enough, and packaged
concretely enough (skills, templates, guardrails), that any AI agent or
engineer arriving here — cold, with no other context — can pick it up and
*practice it correctly* immediately. It is a **control plane**: tooling,
templates, guardrails, and a knowledge base — not project work. Loops are
*run from here* against other repositories. When you operate here, follow
these conventions.

## What this repo is for

- Authoring and storing **reusable loop skills** (`.claude/skills/`) that any
  agent can invoke directly — the practice, not a description of it.
- Holding **runnable templates** for the ralph, `/goal`, and `/loop` patterns,
  so starting a new loop is scaffolding, not re-deriving the pattern.
- Keeping a **living knowledge base** (`knowledge/`) that stays current as the
  ecosystem moves — see "Knowledge base discipline" below. A knowledge base
  that goes stale stops being able to serve this repo's purpose.
- Providing **guardrail defaults** and **runbooks** that turn the
  non-negotiables below into things you can run, not just remember.

If you're an agent landing in this repo with no other context: read this file,
then `knowledge/00-primer.md` for the state of the practice, then look at
`.claude/skills/` and `templates/` for what's directly runnable. Do not add
application / project code here — that's what makes this repo reusable across
every project you point a loop at.

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
- `sources.md`'s "Known caveats / things to re-verify" section is a **live
  backlog**, not an archive — every `update-knowledge` pass must carry every
  open item forward and surface it in the PR, until it's actually resolved.
- Resolved caveats, superseded facts, and confirmed-non-useful research move
  to `knowledge/archive/` rather than lingering in the live files or getting
  silently deleted — see `knowledge/archive/resolved-caveats.md`. Keeping the
  live knowledge base lean is as important as keeping it current: an agent
  landing here should find the *current* state of the practice, not have to
  wade through a growing pile of resolved history to find it.

## Tooling version notes (verify against live docs before relying on these)

- `/loop` is a bundled skill, Claude Code **v2.1.72+**; cron under the hood;
  session-scoped (does not run with the laptop closed); recurring tasks expire
  after 7 days.
- `/goal` requires **v2.1.139+**; a separate validator model (defaults to
  Haiku) judges the stop condition; implemented as a session-scoped Stop hook;
  the validator does not call tools, so conditions must be provable from what
  the agent surfaces.
- **Routines** = cloud scheduling that survives with the laptop closed (min
  interval ~1 hour). Create one from the CLI with **`/schedule`** (alias
  `/routines`) — supports schedule, API, and GitHub-event triggers. Use these
  for the `update-knowledge` loop.
