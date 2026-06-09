# Runbook: overnight / long autonomous build

For multi-hour builds where each iteration should reset context to anchor files
— the ralph pattern. Use this when a task is large but decomposable and has a
hard, test-driven definition of done.

## 1. Scaffold

From this repo: `/new-loop <task>; done = <check>` — it creates
`loops/<slug>/` with a `PROMPT.md`, `run.sh`, and `RUN.md`, caps wired in. Or
copy `templates/ralph/PROMPT.md` and `templates/ralph/run.sh` by hand.

## 2. Write a real plan first

Ralph works because each iteration reloads anchor files instead of growing
context. Make the **first** iteration a planning-only pass that writes
`IMPLEMENTATION_PLAN.md` and stops — no implementation on the same pass. Then
the build iterations work the plan one small unit at a time.

## 3. Set the caps deliberately

Edit the CONFIG block in `run.sh`:
- `MAX_ITERATIONS` — enough to finish, with headroom (start 30–50 for a big task).
- `MAX_BUDGET_USD` — a real ceiling; wire `cost_so_far()` to your meter.
- `STALL_LIMIT` — default 3 no-progress passes, then it documents blockers and exits.
- `SUCCESS_CHECK` — the exact test/lint command that defines done.

## 4. Run it where it can run unattended

- **Headless local/sandbox:** `bash loops/<slug>/run.sh`
- **Cloud (laptop closed):** Claude Code on the web with `--remote`, or the
  in-session `/ralph-loop` plugin. Cloud VMs are ephemeral and isolated; state
  must be committed to git to survive.

## 5. Make state durable

Commit small and often (the template instructs the agent to). Keep progress in
`PROGRESS.md` on disk, not in context — so a crash/restart resumes cleanly.
This is the lesson Gas Town productized: work state in git, not in an agent's
context window.

## 6. Review in the morning

Don't merge blind. Skim the diff and the commit trail; run the success check
yourself. Consider wiring **roborev** for continuous per-commit review during
the run (see `knowledge/00-primer.md` §5).
