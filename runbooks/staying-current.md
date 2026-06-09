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
self-contained:

```
Run the /update-knowledge skill for this repository (the loops control plane), following its procedure exactly:

1. Read knowledge/00-primer.md, knowledge/sources.md, and the latest knowledge/CHANGELOG.md entry to establish the baseline date. You only care about what changed since then.
2. Fan out about 5 parallel research agents (ONE pass, no recursion) across: Claude Code tooling & versions; ecosystem & orchestration techniques; key voices; guardrails & cost; verification & skills. Each returns claims with source URL + confidence.
3. Only promote a claim to High confidence if a primary source was read directly or it appears verbatim across independent sources. Put anything you cannot verify into the "to re-verify" list in sources.md, not the primer.
4. Diff findings against the knowledge base. For genuinely new or changed facts, update 00-primer.md and sources.md, and prepend a dated entry to CHANGELOG.md (newest first, above the marker line). Do not churn wording for its own sake.
5. If there are material changes: commit them to a new claude/knowledge-update-<YYYY-MM-DD> branch and open a pull request summarizing what is new, changed, deprecated, and what needs human verification. Do NOT merge.
6. If nothing material changed since the baseline date: make no commit and end the run, reporting "no material changes since <date>".

Never merge to the default branch.
```

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
