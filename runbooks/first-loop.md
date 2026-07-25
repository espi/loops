# Runbook: your first loop (~15 minutes)

The lowest-risk path to a working, guarded loop. Run this against a real but
small task in one of your project repos.

## 1. Pick a task with a checkable "done"

Choose something self-contained where success is a command's exit code. Good
first tasks: add an endpoint with tests, fix a failing test suite, migrate a
deprecated API call. "Done" = `tests pass` (+ a short checklist).

If you can't write the success check as a command, the task isn't ready for a
loop yet — pick another.

## 2. Start with `/goal`, not raw bash

In a Claude Code session in the **target** repo:

```
/goal all tests in test/<area> pass and `npm run lint` is clean, and you have shown the passing output
```

`/goal` keeps the agent working until a fresh Haiku validator confirms the
condition. Because the validator can't run tools, make the agent **print the
passing output** so the condition is provable from what it surfaces.

## 3. Always pair it with caps

`/goal` is bounded by its condition, but confirm the condition is reachable, and
keep an eye on cost. For longer autonomous runs, switch to the ralph pattern
which has explicit caps:

```
/ralph-loop "<task with explicit, testable deliverables>" --completion-promise "COMPLETE" --max-iterations 20
```

or the fully-headless `templates/ralph/run.sh` (caps in its CONFIG block).

## 4. Watch the first runs

The first few runs are where cost surprises happen. Watch the meter; stop with
`Esc` (`/loop`), `Ctrl+C` (`/goal`), or `/cancel-ralph`.

## 5. Capture what you learned

If you re-typed the same instructions, turn them into a skill
(`.claude/skills/<name>/SKILL.md`) so next time is free. That's the durable
asset — see `knowledge/00-primer.md` §4 (Skills).

## Common beginner mistakes

- Vague completion criteria ("make it good") — be specific and binary.
- No iteration cap — never run uncapped.
- Pointing a loop at work that needs human judgment / design decisions.
- Trusting the model's self-assessment instead of a real check.
