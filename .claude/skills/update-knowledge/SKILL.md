---
name: update-knowledge
description: >-
  Refresh the loops knowledge base. Runs a fan-out research pass on the agentic-
  loops ecosystem (new techniques, tool/version changes, key-voice updates,
  guardrail and cost developments), diffs findings against knowledge/, and
  proposes updates as a PR. Use when the user wants to "update the knowledge
  base", "check for new loop techniques", or on a scheduled Routine.
disable-model-invocation: false
---

# update-knowledge

Keep `knowledge/` current. This is the self-maintenance loop for this repo.
Designed to run on a cloud Routine (see `runbooks/staying-current.md`) or on
demand.

## Procedure

### 1. Establish the baseline
Read `knowledge/00-primer.md`, `knowledge/sources.md`, and the latest entry in
`knowledge/CHANGELOG.md`. Note the date of the last pass — you only care about
what changed since then.

**Before starting new research, check whether a prior `update-knowledge` PR is
already open and unmerged** (via the GitHub MCP tools, or `gh pr list` if
available — search for open PRs touching `knowledge/`). An open PR from a
previous pass means the merged-file baseline you just read is stale relative
to work already in flight. If one exists:
- Prefer resuming/extending that PR's branch over opening a new one, or
- If you do start a new pass anyway (e.g. it's materially overdue), expect a
  merge conflict when that PR eventually lands, and say so explicitly in your
  own PR description rather than being surprised by it later.
This step exists because a pass once ran a full 14-day research window
unaware a 7-day PR was already open, causing exactly that conflict — see the
2026-07-20 CHANGELOG entry for the full story.

### 2. Re-check the standing re-verify backlog
`sources.md`'s "Known caveats / things to re-verify" section is a **live
backlog**, not a historical record. Before fanning out new research:

- Read every open item in that section.
- For each one, see if this pass's research (or a human, earlier in the
  conversation) resolves it. If so, fold the resolution into `00-primer.md`
  / `sources.md` and move the item to
  [`archive/resolved-caveats.md`](../../../knowledge/archive/resolved-caveats.md)
  with a one-line note on how and when it resolved (or that it was checked
  and determined not worth tracking further).
- Carry every still-open item forward unchanged — do not let one silently
  age out. An item that's been open for many passes with no resolution is
  still worth a line in the PR, not a reason to drop it.
- The PR you open (step 7) must list **every currently-open item**, not just
  ones that are new this pass, so a human sees the standing backlog each
  time until it's actually resolved.

### 3. Fan-out research
Launch parallel research agents (Task tool, `general-purpose`) across these
angles. Each must use WebSearch/WebFetch and return claims with source URL +
confidence (High/Medium/Low):

1. **Tooling & versions** — Claude Code `/loop`, `/goal`, Routines, Skills,
   subagents/agent-teams, Agent SDK guardrails. New flags, version bumps,
   deprecations. Prioritize official docs (code.claude.com, platform.claude.com).
2. **Ecosystem & techniques** — new loop patterns, orchestration frameworks
   (Gas Town and successors), ralph derivatives, `/goal`-style validators in
   other tools.
3. **Key voices** — new primary statements from Steinberger, Cherny, Yegge,
   Huntley, Osmani, and notable practitioners.
4. **Guardrails & cost** — new budget/stall tooling, fresh cost-overrun
   incidents, billing-control features, Gartner/industry data.
5. **Verification & skills** — advances in self-verification, review-in-the-loop
   tools (roborev and peers), the skills-as-durable-asset thesis.

### 4. Verify before writing
Treat search snippets skeptically. Only promote a claim to **High** if a primary
source was read directly or it appears verbatim across independent sources.
Anything you cannot verify against a primary source: mark **Low** and add it to
the "things to re-verify" section of `sources.md` rather than the primer.

### 5. Diff and draft
Compare findings to the current knowledge base. For each genuinely new or
changed fact: update the relevant section of `00-primer.md`, add/adjust the
entry in `sources.md` with its confidence, and write a dated `CHANGELOG.md`
entry (newest first, above the marker line) summarizing what changed and why.
Do not churn wording for its own sake — only substantive changes. Preserve
existing corrections/caveats.

### 6. Prune — archive, don't accumulate
The knowledge base's whole value is being *current*, not exhaustive. Before
opening the PR, check whether anything in `sources.md` or the primer is now
stale, superseded by a newer fact, or was a dead-end investigation that never
went anywhere — and move it to `knowledge/archive/` rather than deleting it or
leaving it in the live files:

- Resolved caveats go to `archive/resolved-caveats.md` (per step 2).
- A fact superseded by a newer version (e.g., an old version number, a
  renamed release, a corrected attribution) should have the old text removed
  from the live file, not left alongside the correction — the archive, or the
  CHANGELOG's existing dated entry, is where the "what it used to say" record
  lives, not a lingering parenthetical in the primer.
- Don't prune anything still open or still true — pruning is for resolved,
  superseded, or confirmed-non-useful material only. When unsure, leave it
  and flag it in the PR rather than guessing.

### 7. Open a PR (do not push to main)
Create a branch `knowledge/update-YYYY-MM-DD`, commit the changes with a clear
message, and open a PR summarizing: what's new, what changed, what was
deprecated, what was archived and why, and — per step 2 — **every currently-
open re-verify item**, not only ones new this pass. The human reviews and
merges. Never merge to main automatically.

If there is nothing substantive to change, append no CHANGELOG entry, make no
commit, and report "no material changes since <last date>." Still re-check the
standing backlog (step 2) even on a no-op pass — a caveat can resolve even
when nothing else changed.

## Guardrails for this skill
- This is itself a loop: it has a natural stop (one research pass → one PR or a
  no-op). Do not re-run yourself in a tight loop; scheduling is the Routine's job.
- Keep the research bounded — ~5 parallel agents, one pass. Don't fan out
  recursively.
