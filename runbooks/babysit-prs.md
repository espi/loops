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
tasks expire after 7 days. Stop a self-paced loop early with `Esc` while it
waits; a fixed-interval loop (`/loop 30m …`) is cancelled by asking Claude
(`Esc` and `Ctrl+C` don't stop it).

Customize the default behavior by dropping a copy of `templates/loop/loop.md`
at `.claude/loop.md` in the target repo.

## Laptop-closed — Claude Code on the web

For PR-tending that survives your laptop closing, use **Claude Code on the web /
cloud scheduled tasks** (formerly Routines) instead of session-scoped `/loop`:

- The cloud auto-fix-PR feature subscribes to GitHub PR activity and pushes
  fixes for failed checks and review comments (requires the Claude GitHub App).
- Turn it on from the PR's **⋮** menu in the session's **Changes** card at
  claude.ai/code, with `/autofix-pr` from the terminal while on the PR's branch,
  from the mobile app, or by pasting the PR URL into any session and asking.
- It can't react to merge conflicts (GitHub emits no webhook for them) — open
  the session and ask for a rebase.

## Guardrails

- Let it fix **build/CI and unambiguous review comments**; for anything
  architecturally significant, it should leave a note and ask, not guess.
- Scope it to **your** PRs / the current branch.
- It pushes to the working branch only — never main.
- Auto-fix replies to review threads **as your GitHub account** (labeled as
  Claude Code). If the repo runs comment-triggered automation (Atlantis,
  `issue_comment` Actions), those replies can trigger it — review that before
  enabling, and skip auto-fix where a PR comment can deploy infrastructure.
