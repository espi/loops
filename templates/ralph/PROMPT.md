<!--
  Ralph anchor prompt template.
  This file is the FIXED prompt re-fed to the agent on every iteration. The
  prompt stays constant; the codebase, tests, git history, and PROGRESS.md
  change around it — that external state is what turns repetition into
  iteration. Keep this file small and stable. Edit the bracketed parts.
-->

# Goal

[One paragraph: what "done" looks like, stated as a verifiable end state.]

# Anchor files (re-read these every iteration before doing anything)

- `PROGRESS.md` — what's done, what's next, known blockers (you maintain this).
- `IMPLEMENTATION_PLAN.md` — the plan. If it doesn't exist yet, create it first
  and STOP (planning iteration only — do not implement on the same pass).
- [list the key spec/source files that anchor the task]

# Each iteration

1. Re-read the anchor files. Do NOT rely on memory of previous iterations.
2. Pick the single next smallest unit of work from the plan.
3. Implement it.
4. Run the success check (below). Use the result as backpressure.
5. Update `PROGRESS.md`: what you did, the check result, what's next.
6. Commit with a clear message (small, frequent commits).

# Success check (the loop's stop condition)

Run exactly this and treat its exit code as truth:

```
[e.g. pytest test/users -q   ||   npm test   ||   tsc --noEmit && npm run lint]
```

You are DONE only when this check passes AND every deliverable below is met.
When done, write `<promise>COMPLETE</promise>` and stop.

# Deliverables (all must be true)

- [ ] [explicit, checkable deliverable]
- [ ] [explicit, checkable deliverable]
- [ ] Success check passes
- [ ] No new lint/type errors

# Stop / escape hatch

If you make NO progress for 3 consecutive iterations (no diff, check state
unchanged), STOP: write the blockers to `PROGRESS.md` under "BLOCKED" and
suggest alternatives instead of looping. Never loop forever.
