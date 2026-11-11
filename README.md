# loops

The practice hub for **agentic coding loops**. A loop is a small program that prompts a coding agent, reads what it produced, checks whether the goal is met, and re-prompts until a verifiable stop fires. This repo is a toolbox: loops run *from* here against other repos.

## If you are an agent arriving here

You can act from this page. Read further only for the reason named.

1. **The one rule: never run an uncapped loop.** Every loop carries all three hard stops, enforced from outside the agent:
   - a maximum iteration count, plus a cap on each call;
   - no-progress detection: stop when N iterations change nothing;
   - a token or dollar ceiling in the harness. An alert is not a ceiling, and no stop may read state the agent can write.
2. **One deterministic success check** (a test, a linter, a typecheck) runs inside the loop. "Done" means the check passed, never the agent's own view.
3. **Pick the pattern.**
   - Work a task to completion, unattended: the ralph loop, [`templates/ralph/`](templates/ralph/).
   - Work inside one session until a stated condition holds: [`templates/goal/`](templates/goal/).
   - Repeat a maintenance prompt on a schedule: [`templates/loop/`](templates/loop/).
   - An overnight UI audit: [`templates/ui-audit/`](templates/ui-audit/).
4. **Scaffold, do not re-derive.** In a Claude Code session here: `/new-loop <task>; done = <check>` writes the files with the stops in place. `/loop-guardrails <path>` audits an existing loop.
5. **Before the first unattended run**, go through [`guardrails/checklist.md`](guardrails/checklist.md) and set [`guardrails/budget.env`](guardrails/budget.env). Test each ceiling at a low value and see it stop.
6. **Record that you used this.** In your own project, write one dated line: which template, which commit of this repo, what you changed. Nothing here can see you otherwise.

Read [`knowledge/00-primer.md`](knowledge/00-primer.md) only when you need the reasoning, or a harness other than Claude Code. Read [`CLAUDE.md`](CLAUDE.md) only when you are changing this repo.

Running an engine for a project and a person, not a coding loop? That practice lives in `espi/engine-practice`. This repo stays the home for loops that build code and for the three hard stops.

## What is here

| Path | What it is |
|------|------------|
| [`templates/`](templates/) | Runnable starters. |
| [`guardrails/`](guardrails/) | The three hard stops as defaults and a preflight checklist; [`BUDGETS.md`](guardrails/BUDGETS.md) for this repo's own files. |
| [`.claude/skills/`](.claude/skills/) | `new-loop`, `loop-guardrails`, and the two maintenance skills. |
| [`runbooks/`](runbooks/) | Step-by-step playbooks; start with [`first-loop.md`](runbooks/first-loop.md). |
| [`knowledge/`](knowledge/) | The primer (what to do and why), the sources (one line per claim), a one-line-per-pass changelog. |

## How it stays current

Two scheduled skills, each opening one pull request a human merges:

- [`update-knowledge`](.claude/skills/update-knowledge/SKILL.md), weekly: research, then changes to `knowledge/`.
- [`artifact-audit`](.claude/skills/artifact-audit/SKILL.md), monthly: checks the templates, guardrails and runbooks against the knowledge.

Three rules keep them readable:

- every file they write has a budget in words, checked in CI; at a cap a new entry deletes an old one;
- neither opens a pull request while its last one is open;
- a pull request body leads with the decisions needed and stays under 600 words.

Setup and the reasons for two schedules: [`runbooks/staying-current.md`](runbooks/staying-current.md).
