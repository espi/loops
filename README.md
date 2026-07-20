# loops

The central, living practice hub for **agentic coding loops** — loop
engineering as a discipline. It exists so that the current state of the
practice (patterns, guardrails, verification discipline, and what's changed
in the ecosystem lately) is captured accurately and concretely enough that
any AI agent or engineer landing here, cold, can pick it up and *practice the
methodology* immediately — not just read about it.

A *loop* is a small program that prompts a coding agent, reads what it
produced, decides whether the goal is met, and re-prompts until a verifiable
stop condition fires. You stop being the thing inside the loop typing prompts
and become the author of the loop; the model becomes a subroutine. See
[`knowledge/00-primer.md`](knowledge/00-primer.md) for the full briefing.

This repo is a **toolbox / control plane**, not a workspace. Loops run *from*
here against other repos — that separation is what keeps it clean and
reusable, for you or for an agent picking it up next.

**If you're an agent arriving here with no other context**: read
[`CLAUDE.md`](CLAUDE.md) first for the repo's conventions, then
[`knowledge/00-primer.md`](knowledge/00-primer.md) for the state of the
practice. Skills in [`.claude/skills/`](.claude/skills/) are directly
invocable and templates in [`templates/`](templates/) are directly runnable —
you don't need to reconstruct the methodology from first principles, it's
written down and kept current.

## What's here

| Path | What it is |
|------|------------|
| [`knowledge/`](knowledge/) | Living knowledge base — primer, curated sources, changelog, and an `archive/` for resolved/superseded material. Kept current by the `update-knowledge` skill. |
| [`.claude/skills/`](.claude/skills/) | Reusable, invocable skills: `new-loop`, `loop-guardrails`, `update-knowledge`. |
| [`templates/`](templates/) | Runnable starters — ralph bash loop, `/goal` recipes, `/loop` maintenance prompt. |
| [`guardrails/`](guardrails/) | The three hard stops: budget/iteration defaults + a preflight checklist. |
| [`runbooks/`](runbooks/) | Step-by-step playbooks for common loops. |

## Quickstart

**Build your first loop** (≈15 min): follow [`runbooks/first-loop.md`](runbooks/first-loop.md).

**Scaffold a loop for a task** — from a Claude Code session in this repo:

```
/new-loop add pagination to the /users endpoint; done = tests in test/users pass and lint is clean
```

It picks the right pattern (ralph / `/goal` / `/loop`), writes the files, and
bakes in guardrails.

**Audit an existing loop for safety:**

```
/loop-guardrails templates/ralph/run.sh
```

## The one rule

**Never run an uncapped loop.** Every loop gets all three hard stops — a max
iteration count, no-progress detection, and a token/dollar budget ceiling. The
billing layer will *not* save you (soft alerts only). See
[`guardrails/`](guardrails/).

## Staying current

The [`update-knowledge`](.claude/skills/update-knowledge/SKILL.md) skill runs a
fan-out research pass on the loops ecosystem and opens a PR proposing changes to
`knowledge/`. It also carries forward every open item on the standing
re-verify backlog and archives what's since resolved, so the live knowledge
base stays both current *and* lean rather than accumulating indefinitely.
Schedule it as a cloud Routine so it self-maintains — see
[`runbooks/staying-current.md`](runbooks/staying-current.md).
