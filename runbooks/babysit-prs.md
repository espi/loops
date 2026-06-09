# Runbook: babysit your PRs

A recurring loop that tends open PRs — fixes failing CI and addresses review
comments — so they trend toward mergeable without you babysitting them.

## Session-scoped (`/loop`) — while your machine is on

In a Claude Code session on the branch with the PR:

```
/loop babysit all my PRs. Auto-fix build issues, and when comments come in, use a worktree agent to fix them.
```

`/loop` self-paces (1 min–1 hr) and runs cron under the hood, but **only while
the session is open and idle** — close the terminal and it stops. Recurring
tasks expire after 7 days. Stop early with `Esc`.

Customize the default behavior by dropping a copy of `templates/loop/loop.md`
at `.claude/loop.md` in the target repo.

## Laptop-closed — Claude Code on the web

For PR-tending that survives your laptop closing, use **Claude Code on the web /
Routines** instead of session-scoped `/loop`:

- The cloud auto-fix-PR feature subscribes to GitHub PR webhooks and pushes
  fixes for failed checks and review comments (requires the Claude GitHub App).
- Enable via the web CI bar, `/autofix-pr` from the terminal, or mobile.

## Guardrails

- Let it fix **build/CI and unambiguous review comments**; for anything
  architecturally significant, it should leave a note and ask, not guess.
- Scope it to **your** PRs / the current branch.
- It pushes to the working branch only — never main.
