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

> **Prerequisite:** a Routine clones the repo's **default branch** (`main`) on
> every run, so the `update-knowledge` skill and `knowledge/` must be merged to
> `main` before the Routine has anything to run.

### Create it (one-time, ~60 seconds)

Routines can't be created from inside a Claude Code *web* session (the
`/schedule` command is disabled there). Use one of:

- **Web/Desktop:** go to [claude.ai/code/routines](https://claude.ai/code/routines)
  → **New routine**, and fill in the fields below.
- **CLI (local session only):**
  ```
  /schedule weekly on Monday at 8am, run the /update-knowledge skill for the loops repo and open a PR with any changes
  ```

### Routine settings

| Field | Value |
|---|---|
| **Name** | Weekly loops knowledge refresh |
| **Repository** | `espi/loops` |
| **Trigger** | Schedule → Weekly (e.g. Monday 08:00 local) |
| **Environment / network** | Needs web research. **Trusted** (default) lets `WebSearch` work but blocks `WebFetch` to arbitrary domains; set **Full** (or **Custom** allowing `code.claude.com`, `platform.claude.com`, `github.com`, `simonwillison.net`, `anthropic.com`) so it can read primary docs. |
| **Branch pushes** | Leave default (`claude/`-prefixed only) — this forces a PR instead of touching `main`. |
| **Connectors** | None required; remove extras. The PR is opened as your GitHub identity. |

### Prompt (paste verbatim)

Routines run autonomously with no approval prompts, so the prompt must be
self-contained — but it should point at the skill file rather than embed a
frozen copy of its steps. **This bit us once already**: an earlier version of
this prompt spelled out the procedure inline, the skill later gained two new
steps (re-checking the standing re-verify backlog, archiving resolved
caveats), and the Routine kept firing the stale embedded steps because a
Routine's prompt is a snapshot pasted in at creation time, not a live pointer
to `SKILL.md`. Point at the file, don't paraphrase it:

```
Run the /update-knowledge skill for this repository (the loops control plane).
Read .claude/skills/update-knowledge/SKILL.md fresh from the cloned repo and
follow its procedure exactly, in full, including every numbered step — do not
rely on a remembered or prior summary of its steps, since the skill is a
living document and may have changed since you last ran it. Before starting
new research, check whether a prior update-knowledge PR is already open and
unmerged, per the skill's step 1. Never merge to the default branch.
```

If you already have a Routine set up with the old embedded-steps prompt,
replace it with the version above (`/schedule update` from an interactive CLI
session, or edit it at claude.ai/code/routines) so future runs pick up skill
changes automatically instead of needing the Routine edited every time.

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
