---
name: artifact-audit
description: >-
  Audit this repo's own practice artifacts (skills, templates, guardrails,
  runbooks, docs) for drift against current tool behaviour, and propose fixes as
  a PR. The inward-facing complement to update-knowledge: that skill keeps the
  knowledge base current with the world; this one keeps the repo's runnable
  content matching that world. Use monthly on a Routine, or after a major tool
  change may have invalidated a template/skill/guardrail.
disable-model-invocation: false
---

# artifact-audit

Keep the repo's **runnable artifacts** correct as the tools drift. Two
maintenance jobs, deliberately separate (see `runbooks/staying-current.md` for
why):

- `update-knowledge` (weekly) — *is the knowledge base current with the world?*
  Outward-facing research → edits `knowledge/`.
- `artifact-audit` (this skill, monthly) — *do our own skills / templates /
  guardrails / runbooks still match that world?* Inward-facing consistency →
  edits the practice artifacts.

**Scope: the practice artifacts, NOT the knowledge base.** Do not edit
`knowledge/` here — read it as your source of truth. This skill also has **no
auto-apply / `self-edit:` privilege** (that fast-path is reserved for
`update-knowledge`'s own file and is CI-fenced); everything here is an ordinary
human-reviewed PR edit.

## Procedure

### 1. Establish baseline & scope
Read `CLAUDE.md`, `README.md`, every `.claude/skills/*/SKILL.md`, `templates/**`,
`guardrails/**`, and `runbooks/**`. Read the current `knowledge/00-primer.md`
and `knowledge/sources.md` — these are your **source of truth** for how the
tools currently behave.

Check whether a prior `artifact-audit` PR is already open and unmerged (GitHub
MCP tools, or `gh pr list`); if so, extend its branch rather than fork — same
anti-conflict rule as `update-knowledge` step 1. Also **yield to an open
`update-knowledge` PR** on any file it is mid-editing (notably
`.claude/skills/update-knowledge/SKILL.md`): don't both edit the same file in
flight.

### 2. Audit for drift (bounded fan-out)
Launch ~3–4 parallel agents (`general-purpose`), each auditing one slice against
the KB (and a primary source where the KB entry is Medium/stale). Each returns
findings as: file · the stale/incorrect content · the evidence (KB entry or
primary URL + confidence) · a proposed fix · severity.

1. **Skills** — do `.claude/skills/*/SKILL.md` reference tool behaviour, flags,
   commands, or version notes the KB now contradicts (a renamed command, a
   changed default, a corrected fact — e.g. `/schedule` is a Routine alias, not
   a fourth loop type)?
2. **Templates** — do `templates/**` still run? Check the ralph `run.sh`, the
   `/goal` recipes, the `/loop` prompt, and the ui-audit set for dead flags,
   deprecated syntax, or stale model names.
3. **Guardrails** — do `guardrails/**` + `budget.env` reflect current
   enforcement (Agent SDK params, new gateway options, changed caps)? **Flag,
   don't silently rewrite**, anything touching a hard stop.
4. **Runbooks & docs** — do `runbooks/**`, `README.md`, `CLAUDE.md` reference
   current commands / model names / versions / the real Routine mechanics?

### 3. Verify before proposing
A proposed fix must be backed by a **High**-confidence KB entry or a primary
source read this pass. Medium/Low evidence → **flag as possible drift for a
human to confirm**, don't rewrite. Don't propagate a claim that sits on the KB's
own re-verify list into an artifact as if it were settled.

### 4. Draft fixes (propose, never auto-merge)
Apply confirmed fixes to the artifacts and stage them as ordinary commits. For
anything touching the **three hard stops**, the repo **mission**, **permissions**,
`budget.env`, `CLAUDE.md`, or the `update-knowledge` **self-edit gate**: prefer
**flagging over rewriting** — surface it as an explicit human decision rather
than quietly changing a control. Never use a `self-edit:` commit here.

### 5. Open a PR (do not push to main)
Create a branch `claude/artifact-audit-YYYY-MM-DD`, commit, and open a PR that
**leads** with an `## Artifact drift` section:
- **Fixed** — file · what was stale · the evidence (KB entry / primary source).
- **Flagged for you** — possible drift not confident enough to fix, or a change
  to a hard stop / mission / permissions / the self-edit gate left for a human.

Then the diff. The human reviews and merges; never merge to main. If nothing
drifted: make no commit and report "no artifact drift since <last audit>."

## Guardrails for this skill
A scheduled **one-shot** (one trigger → one audit pass → one PR → exit), not a
`while`-loop. Same envelope as `update-knowledge`:

- **Iteration** — one trigger, one pass, no self-re-invocation; the native
  `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION` cap bounds the ~4-agent fan-out.
- **Budget** — the subscription / daily-run cap is the ceiling, real only with
  metered overage off (see `runbooks/staying-current.md` → "Budget & caps").
- **Stall** — N/A for a one-shot; the no-op exit is the termination.
- **No auto-apply.** Unlike `update-knowledge` step 7, nothing here is
  auto-applied — every change is human-reviewed. It never edits `knowledge/`
  (read-only source of truth) and prefers flagging over rewriting any hard stop,
  the mission, permissions, or the self-edit gate.
- Bounded fan-out (~4 agents), one pass, no recursion; scheduling is the
  Routine's job (monthly).
