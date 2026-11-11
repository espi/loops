# Preflight checklist

Run through this before starting any loop. The `loop-guardrails` skill automates
it. Don't start until every box is checked.

## Stop conditions
- [ ] **Iteration cap** set (`max_turns` / `--max-turns` / bash counter), on
      **Claude Code v2.1.281+** (earlier versions could ignore `--max-turns`).
- [ ] **Each call is capped from outside**, not just the loop: per-call
      `--max-turns`, `--max-budget-usd` and a wall-clock `timeout` — a counter
      that only ticks between calls can't stop a call that never returns.
- [ ] **No-progress detection** in place — bails after N passes with no
      worktree change and records blockers (default N=3).
- [ ] **Budget ceiling** set as a *hard enforcement* stop (not just an alert).
- [ ] **Stops live outside the agent's reach** — no counter, budget or success
      check reads a file the agent can edit. On an unattended run, `/ralph-loop
      --max-iterations` is not enough on its own (its count is in a worktree
      file); prompt, harness and tests are fingerprinted or read-only.

## Containment (required companion to the stop conditions)
- [ ] **Network egress scoped** to the domains the loop needs, not full access
      (`sandbox.network.strictAllowlist` denies the rest without prompting).
- [ ] **No long-lived credentials reachable** — SSH keys, cloud creds and the
      home directory isolated from the loop.
- [ ] **Unattended runs deny by default** — `--permission-prompts none` on
      headless hosts (v2.1.259+).
- [ ] **Isolation is a container/VM**, not a flag. `--restricted` is a
      permission gate, not a sandbox.
- [ ] If the loop **clones or reviews untrusted repos**, you've read the
      containment section of `guardrails/README.md` — attacks like GitSpawn fire
      *before* any stop condition or verification step runs.

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
