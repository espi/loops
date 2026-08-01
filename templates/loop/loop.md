<!--
  /loop maintenance-prompt template.
  Drop a customized copy at .claude/loop.md (project) or ~/.claude/loop.md
  (personal) in the TARGET repo to define what bare `/loop` does there.
  Or invoke directly: `/loop 15m <prompt>` for a fixed cadence, or
  `/loop <prompt>` to let Claude self-pace (1 min–1 hr).

  Reminder: /loop is SESSION-SCOPED — it only fires while Claude Code is running
  and idle, and stops when the terminal closes. For laptop-closed scheduling use
  a cloud Routine instead. Recurring tasks auto-expire after 7 days.
-->

# Loop maintenance prompt

Each iteration, in priority order, do the first thing that applies:

1. **Continue unfinished work** on the current branch toward its stated goal.
2. **Tend the current branch's PR**: address review comments, fix failed CI,
   resolve merge conflicts. If a fix is ambiguous, leave a note and move on —
   do not guess on anything architecturally significant.
3. **Verify**: run the project's test/lint/typecheck and fix what you broke.
4. If nothing is pending, do a small cleanup pass (dead code, stale TODOs) and
   otherwise wait.

Stop conditions: stop when the PR is merged, when blocked on a human decision
(say so clearly), or when there is genuinely nothing to do. Never make the same
no-op change repeatedly.

## Canonical starter invocations

```
/loop babysit all my PRs. Auto-fix build issues, and when comments come in, use a worktree agent to fix them.
/loop 30m run the test suite on this branch and fix any failures, then stop when green.
/loop 15m /review 1234
```
