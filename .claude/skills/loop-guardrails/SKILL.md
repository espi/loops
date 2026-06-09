---
name: loop-guardrails
description: >-
  Audit a loop (a script, a /goal or /ralph-loop invocation, or an Agent SDK
  config) for the three mandatory hard stops and a verification step, then add
  whatever is missing. Use when the user wants to "make this loop safe", "check
  my loop", "add guardrails", or before running anything autonomously.
argument-hint: "<path to loop file or the loop command>"
---

# loop-guardrails

Audit a loop for safety and fix gaps. The standard is `guardrails/checklist.md`.

## What you check

For the given loop (file path, command, or config), verify all of:

1. **Max iteration count.** Is there a hard cap on iterations/turns?
   - bash ralph → a counter that breaks the `while` loop
   - `/ralph-loop` → `--max-iterations N`
   - Agent SDK → `max_turns` / `maxTurns`
   - `/goal` → bounded by the validator, but confirm the condition is actually
     reachable and provable from the agent's surfaced output
   If missing, add it. Default cap: 20.

2. **No-progress / stall detection.** Does the loop bail when it stops making
   progress (no git diff, repeated identical tool calls, unchanged test state)
   for N iterations? If missing, add a check (default N=3) that documents
   blockers and exits rather than looping.

3. **Token/dollar budget ceiling.** Is there a *hard enforcement* stop, not just
   an alert? bash → an external cost meter or token-based iteration ceiling;
   Agent SDK → `max_budget_usd`. A cost alert is NOT enough — Anthropic billing
   has soft alerts but won't auto-disable. If missing, add a ceiling.

4. **Verification inside the loop.** Is there a single deterministic success
   check (test/lint/typecheck) the agent runs *itself*, declaring done only on
   pass? If the loop trusts the model's self-assessment of correctness, fix it.

5. **Right tool for the job.** Loops are for well-defined, checkable work. Flag
   if the task needs human judgment / design decisions / one-shot ops / prod
   debugging — those are anti-patterns for autonomous loops.

## Output

Report a checklist: ✅ present / ❌ missing for each of the five, with the exact
line or flag that satisfies it. For each ❌, apply the fix (edit the file or
rewrite the command) and show the diff. End with the corrected, runnable loop
and a one-line cost expectation.

Pull default thresholds from `guardrails/budget.env`.
