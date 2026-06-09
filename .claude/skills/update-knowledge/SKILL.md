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

### 2. Fan-out research
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

### 3. Verify before writing
Treat search snippets skeptically. Only promote a claim to **High** if a primary
source was read directly or it appears verbatim across independent sources.
Anything you cannot verify against a primary source: mark **Low** and add it to
the "things to re-verify" section of `sources.md` rather than the primer.

### 4. Diff and draft
Compare findings to the current knowledge base. For each genuinely new or
changed fact: update the relevant section of `00-primer.md`, add/adjust the
entry in `sources.md` with its confidence, and write a dated `CHANGELOG.md`
entry (newest first, above the marker line) summarizing what changed and why.
Do not churn wording for its own sake — only substantive changes. Preserve
existing corrections/caveats.

### 5. Open a PR (do not push to main)
Create a branch `knowledge/update-YYYY-MM-DD`, commit the changes with a clear
message, and open a PR summarizing: what's new, what changed, what was
deprecated, and any claims that need a human to verify. The human reviews and
merges. Never merge to main automatically.

If there is nothing substantive to change, append no CHANGELOG entry, make no
commit, and report "no material changes since <last date>."

## Guardrails for this skill
- This is itself a loop: it has a natural stop (one research pass → one PR or a
  no-op). Do not re-run yourself in a tight loop; scheduling is the Routine's job.
- Keep the research bounded — ~5 parallel agents, one pass. Don't fan out
  recursively.
