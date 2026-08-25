# Preflight checklist

Run through this before starting any loop. The `loop-guardrails` skill automates
it. Don't start until every box is checked.

## Stop conditions
- [ ] **Iteration cap** set (`max_turns` / `--max-iterations` / bash counter).
- [ ] **No-progress detection** in place — bails after N no-diff passes and
      records blockers (default N=3).
- [ ] **Budget ceiling** set as a *hard enforcement* stop (not just an alert).

## Correctness
- [ ] **Deterministic success check** exists (test/lint/typecheck) returning
      clear pass/fail.
- [ ] The check runs **inside** the loop; the agent declares done only on pass,
      never on self-assessment.
- [ ] Completion condition is **provable from the agent's surfaced output**
      (required for `/goal`'s tool-less validator).

## Fit
- [ ] Task is **well-defined and checkable** — not requiring human judgment,
      design decisions, one-shot ops, or production debugging (loop anti-patterns).
- [ ] The loop runs against a **branch**, not directly on main.
- [ ] You know the **expected cost order-of-magnitude** and where to watch it.

## Operational
- [ ] You know the **stop command** (`Esc` for `/loop`, `/goal clear` for
      `/goal` — `Ctrl+C` only stops a non-interactive `claude -p` goal —
      `/cancel-ralph`, or kill the bash process).
- [ ] For laptop-closed runs: using a **cloud Routine / Claude Code on the web**,
      not session-scoped `/loop`.
- [ ] Permissions scope is intentional (`--dangerously-skip-permissions` only in
      a sandbox / headless / cloud VM). Note: on Bedrock / Vertex AI / Foundry
      deployments, auto mode is **on by default** since v2.1.207 — set
      `disableAutoMode` if that isn't intended.
