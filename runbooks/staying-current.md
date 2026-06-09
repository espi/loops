# Runbook: staying current

How this repo keeps itself up to date. The `update-knowledge` skill does the
research and proposes changes; a schedule decides when.

## On demand

From a Claude Code session in this repo:

```
/update-knowledge
```

It runs a fan-out research pass, diffs findings against `knowledge/`, and — if
anything material changed — opens a PR on a `knowledge/update-YYYY-MM-DD` branch
for you to review and merge. If nothing changed, it reports a no-op.

## Scheduled (recommended) — cloud Routine

To make it self-maintaining with your laptop closed, schedule it as a **cloud
Routine** (Claude Code on the web). Routines run on Anthropic's cloud, need no
open session, and support intervals down to ~1 hour — use weekly here.

1. Open this repo in Claude Code on the web (claude.ai/code).
2. Create a Routine that runs `/update-knowledge` weekly.
3. Set the Routine's network policy to allow web research (Trusted/Full as your
   policy requires) — it needs WebSearch/WebFetch.
4. It will open a PR each week when there's something new; review and merge.

> Why a Routine and not `/loop`? `/loop` is session-scoped — it stops when the
> terminal closes. Routines persist in the cloud. See `knowledge/00-primer.md` §4.

## Reviewing an update PR

- Check that new High-confidence claims actually cite a primary source.
- Anything marked Low / "to re-verify" stays out of the primer until confirmed.
- Merge moves the knowledge base forward; the `CHANGELOG.md` entry is the record.

## Self-guardrails

`update-knowledge` is itself a loop with a natural stop: one pass → one PR (or a
no-op). It does not re-run itself; the Routine owns the cadence. It never merges
to main automatically.
