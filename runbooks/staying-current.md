# Runbook: staying current

How this repo keeps itself up to date. Two maintenance loops, each a skill that
proposes changes as a PR; schedules decide when.

## The two maintenance loops (and why not five)

Maintenance splits into two genuinely different jobs, so it's two schedules —
not one broad job, and not one-per-research-angle:

| | `update-knowledge` (weekly) | `artifact-audit` (monthly) |
|---|---|---|
| **Question** | Is the knowledge base current with the world? | Do our own skills / templates / guardrails / runbooks still match that world? |
| **Direction** | Outward research | Inward consistency |
| **Edits** | `knowledge/` | the practice artifacts (never `knowledge/`) |
| **Cadence** | Weekly — the ecosystem moves fast | Monthly — artifacts drift slower |

**Why the weekly research isn't split into five per-angle schedules.** Its five
research angles (tooling, ecosystem, voices, guardrails/cost, verification) look
broad, but they produce **one coherent artifact**: they're deduped and
cross-referenced against each other, share one backlog carry-forward, one
CHANGELOG entry, one review. Splitting them into five schedules would mean five
PRs all editing `primer.md` / `sources.md` / `CHANGELOG.md` in the same week →
merge conflicts between your own PRs (the exact failure the step-1 open-PR check
was added to prevent), 5× the review load, and loss of cross-angle synthesis.
Chunking optimizes the cheap part (research, already parallel *within* one run)
and pessimizes the expensive part (reconciling into one clean KB). So: **keep
each job single; if the weekly delta ever feels too big, go twice-weekly — not
angle-split.** The two jobs above are separate because they're *different tasks*
with different cadences, not because the work was chunked for size.

## On demand

From a Claude Code session in this repo:

```
/update-knowledge     # refresh the knowledge base against the world
/artifact-audit       # check our own skills/templates/guardrails for drift
```

`update-knowledge` runs a fan-out research pass, diffs findings against
`knowledge/`, and — if anything material changed — opens a PR on a
`claude/knowledge-update-YYYY-MM-DD` branch. `artifact-audit` audits the repo's
own runnable artifacts against the knowledge base and opens a PR on a
`claude/artifact-audit-YYYY-MM-DD` branch with proposed fixes. Either reports a
no-op if nothing changed.

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

## Scheduled — the monthly artifact audit

A **second** cloud Routine runs `artifact-audit` monthly. It reads the knowledge
base as the source of truth and checks the repo's own skills / templates /
guardrails / runbooks for drift (a renamed flag, a changed default, a stale
version note), opening a PR with proposed fixes. Set it up the same way as the
weekly, with these differences:

| Field | Value |
|---|---|
| **Name** | Monthly loops artifact audit |
| **Trigger** | Schedule → there is no Monthly preset (presets are hourly / daily / weekdays / weekly): pick the closest preset (Weekly), then run `/schedule update` from a local CLI session to set a monthly cron (e.g. 1st of the month, 08:00 local) |
| **Everything else** | Same as the weekly (repo `espi/loops`; env with `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION=12`; **Full/Custom** network for primary-doc checks; `claude/`-only branch pushes; overage off). See "Budget & caps" above. |

Prompt (paste verbatim — points at the skill file, same anti-staleness reason as
the weekly):

```
Run the /artifact-audit skill for this repository (the loops control plane).
Read .claude/skills/artifact-audit/SKILL.md fresh from the cloned repo and
follow its procedure exactly, in full, including every numbered step — do not
rely on a remembered summary, since the skill is a living document. Before
starting, check whether a prior artifact-audit PR is already open, and yield to
any open update-knowledge PR on a file it is mid-editing. Never merge to the
default branch.
```

Why monthly, not weekly: the practice artifacts drift far slower than the
ecosystem the weekly tracks, and this audit *depends on* the knowledge base
being current — so it runs after several weekly refreshes have landed. If a
major tool change lands mid-month (a renamed command, a deprecated flag), just
run `/artifact-audit` on demand rather than waiting.

## Reviewing an update PR

- Check that new High-confidence claims actually cite a primary source.
- Anything marked Low / "to re-verify" stays out of the primer until confirmed.
- Merge moves the knowledge base forward; the `CHANGELOG.md` entry is the record.
- For an **`artifact-audit` PR**: read its leading `## Artifact drift` section —
  confirm each *Fixed* item cites a High-confidence KB entry or primary source,
  and give the *Flagged for you* items (hard stops / mission / permissions / the
  self-edit gate) a real decision rather than a rubber stamp.
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

`update-knowledge` and `artifact-audit` are both scheduled one-shots with a
natural stop: one pass → one PR (or a no-op). Neither re-runs itself; the
Routine owns the cadence, and neither merges to main automatically.
`artifact-audit` additionally has **no auto-apply** — every change it proposes is
human-reviewed (the `self-edit:` fast-path is `update-knowledge`-only).

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
