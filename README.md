# loops

The control plane for my loop tooling — the single place I keep everything
needed to run **agentic coding loops** against my project work, and to stay
current as the techniques evolve.

A *loop* is a small program that prompts a coding agent, reads what it
produced, decides whether the goal is met, and re-prompts until a verifiable
stop condition fires. You stop being the thing inside the loop typing prompts
and become the author of the loop; the model becomes a subroutine. See
[`knowledge/00-primer.md`](knowledge/00-primer.md) for the full briefing.

This repo is a **toolbox / control plane**, not a workspace. Loops run *from*
here against other repos. It stays clean and reusable.

## What's here

| Path | What it is |
|------|------------|
| [`knowledge/`](knowledge/) | Living knowledge base — primer, curated sources, changelog. Kept current by the `update-knowledge` skill. |
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
`knowledge/`. Schedule it as a cloud Routine so it self-maintains — see
[`runbooks/staying-current.md`](runbooks/staying-current.md).
