# Runbook: staying current

How this repo keeps itself up to date. The `update-knowledge` skill does the
research and proposes changes; a schedule decides when.

## On demand

From a Claude Code session in this repo:

```
/update-knowledge
```

It runs a fan-out research pass, diffs findings against `knowledge/`, and — if
anything material changed — opens a PR on a `claude/knowledge-update-YYYY-MM-DD`
branch for you to review and merge. If nothing changed, it reports a no-op.

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
| **Branch pushes** | Leave default (`claude/`-prefixed only) — this forces a PR instead of touching `main`. The skill opens its PR from a `claude/knowledge-update-*` branch, so it stays inside this restriction; **do not** enable "Allow unrestricted branch pushes" (that would remove the floor). |
| **Env vars** | `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION=12` (hard-caps the ~5-agent fan-out against runaway recursion); optionally `CLAUDE_CODE_MAX_WEB_SEARCHES_PER_SESSION=100`. |
| **Connectors** | None required; remove extras. The PR is opened as your GitHub identity. |

### Budget & caps

`update-knowledge` is a scheduled **one-shot** (one trigger → one pass → one PR
→ exit), so its "three hard stops" are structural, not a running counter — but
they only hold if the Routine is configured to let them:

- **Iteration:** the weekly schedule bounds how often it fires; the skill never
  re-invokes itself; `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION` (above) hard-caps
  the fan-out. Keep the schedule **weekly**, not hourly.
- **Budget:** the account subscription usage limit + the per-account daily
  routine-run cap *reject* runs when exhausted — a real ceiling **only if
  metered overage / usage credits is OFF** for the account (otherwise spend
  silently spills onto metered billing instead of stopping). Keep overage off,
  or set a spend alert, so this routine can't quietly run up cost. A true
  *per-run dollar* ceiling isn't available for cloud Routines — that needs the
  Agent SDK's `max_budget_usd`; the account-limit + subagent-cap + one-pass
  structure is the realistic envelope here.
- **Stall:** N/A for a one-shot — it terminates on the no-op path when nothing
  material changed.

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
- **Read the "Routine self-improvements" section first** (it leads the PR body).
  If it lists any *Applied (auto-gated)* self-edit, open that `self-edit:`
  commit in full and confirm the change is non-semantic, in-scope (only the
  `update-knowledge` `SKILL.md`), and *not* justified by a web source — the
  same things `self-edit-guard` checks mechanically, but with your eyes on the
  actual diff. Treat any change to that `SKILL.md` **not** in a labelled
  `self-edit:` commit, or a red `self-edit-guard` check, as a stop-and-look.
  Each applied edit is its own commit with a `git revert` written down — drop
  it wholesale if you don't want it, without unpicking the knowledge changes.

## Self-guardrails

`update-knowledge` is itself a loop with a natural stop: one pass → one PR (or a
no-op). It does not re-run itself; the Routine owns the cadence. It never merges
to main automatically.

It may also **improve its own skill file** inside the PR it opens — but only
through the fenced gate in `.claude/skills/update-knowledge/SKILL.md` step 7
(default-deny; one ≤10-line non-semantic repo-internal fix per pass, confined
to that file, never web-sourced, never touching the guardrails/verification/
frontmatter/gate). Scope, protected regions, and the cap are machine-enforced
by `.github/workflows/self-edit-guard.yml`. To make that a *hard* merge gate
rather than a red X you have to notice, add `self-edit-guard` as a **required
status check** in `main`'s branch-protection rules.

> **Branch prefix — reconciled.** Step 8 of the skill opens the PR from a
> `claude/knowledge-update-YYYY-MM-DD` branch, which sits inside the Routine's
> default `claude/`-only push restriction — so the "human merges every PR"
> floor holds without enabling unrestricted pushes. Keep it that way: if you
> ever rename the skill's branch, keep the `claude/` prefix, or the routine
> will lose the ability to push (or you'll be tempted to disable the
> restriction, which removes the floor).
