<!--
  Overnight UI audit loop — anchor prompt.
  Self-contained: re-fed each iteration. The agent advances by reading on-disk
  state (PAGES.md, FINDINGS.md, PROGRESS.md) and the live app via the browser MCP.
  Copy this dir into your PROJECT repo (e.g. ./ui-audit/), fill PAGES.md, and run
  per runbooks/ui-audit-overnight.md. Edit the [bracketed] parts.
-->

# Goal

Audit every page in `PAGES.md`, signed in as each listed test account, and drive
the app toward a clean UI: **auto-fix deterministic bugs** and re-verify them,
and **fix + document** subjective UX issues in a separate, reviewable lane. Done
when every page × account in `PAGES.md` passes its checks and the regression
suite is green.

You work ONLY on the branch `claude/ui-fixes-[DATE]`. Never touch `main`.

# Anchor files (re-read every iteration before doing anything)

- `PAGES.md` — the checklist: routes, the test account(s) for each, preconditions,
  and a status column you update (`todo` / `pass` / `fixed` / `blocked`).
- `STANDARDS.md` — the enforceable UX rules distilled from `docs/`, each citing its
  source. This is your **oracle for UX decisions** — you judge against it, not taste.
- `FINDINGS.md` — the UX report you append to (issues + what you changed + rule cited).
- `PROGRESS.md` — running log: what you did last iteration, check results, blockers.

Do NOT rely on memory of previous iterations. The files on disk are the source of truth.

# Before the first iteration (bootstrap)

If `PAGES.md` or `STANDARDS.md` is missing or empty, run `PREFLIGHT.md` first
(discover routes → `PAGES.md`; distill `docs/` → `STANDARDS.md`), then proceed.
Prefer running PREFLIGHT as a separate reviewed pass before launching this loop.

# Per-iteration procedure

1. Re-read the anchor files. Pick the **next** `todo` page × account from `PAGES.md`.
2. Using the browser MCP: open the app at `[BASE_URL e.g. http://localhost:3000]`,
   log in as that test account, navigate to the page, and exercise its primary
   interactions (click the main CTAs, open menus, submit forms with valid input).
3. Run the **deterministic checks** (the verification oracle). A page fails if any of:
   - **Console**: any uncaught error or error-level log during load or interaction.
   - **Network**: any request returns ≥ 400, fails, or hangs; any missing asset.
   - **Links / navigation**: any link or CTA leads to a 404, an error route, or a
     no-op (a primary action that goes nowhere = a dead end).
   - **Accessibility**: run axe-core; any critical/serious violation (also catches
     missing labels, focus order, contrast — discoverability signals).
   - **Interactive**: primary buttons trigger a visible effect; forms accept valid
     input and show success/validation; no control is inert.
   - **Layout**: no horizontal overflow, no overlapping or zero-size click targets
     at viewports `[e.g. 1440px and 390px]`.
   - **Visual** (if baselines exist): screenshot diff vs `baseline/` over threshold.

4. **For each deterministic failure — fix it (objective lane):**
   - Make the smallest code change that resolves it.
   - **Re-run the SAME check** and confirm it now passes. A fix is not done until
     re-verified live.
   - Run the regression suite: `[e.g. npm test]`. If it fails, **revert your fix**,
     log the conflict in `PROGRESS.md`, and mark the page `blocked` — do not ship a
     fix that breaks the suite.
   - Commit atomically: `fix(ui): <page> — <what>`. One bug per commit.

5. **For each UX issue (discoverability, dead-end, weak/incorrect CTA, confusing
   copy/empty/error states) — judge it against `STANDARDS.md`:**

   a. **It violates a documented standard** → standard lane. The standard is your
      oracle, so this is a grounded fix:
      - Implement the change so the page conforms to the cited rule.
      - Append to `FINDINGS.md`: page, the **rule + its doc citation**, severity,
        screenshot, what changed.
      - Re-run the regression suite; revert + log if it breaks.
      - Commit separately: `ux(standard): <page> — <rule> [docs: <ref>]`.

   b. **No documented standard covers it** (pure judgment) → judgment lane. There
      is no oracle here, so this is the lowest-confidence, most-revertible change:
      - Implement the fix (per the auto-fix mandate), keeping it minimal.
      - Append to `FINDINGS.md` flagged `needs-human`: page, observation, severity,
        screenshot, your reasoning, and what you changed.
      - Re-run the regression suite; revert + log if it breaks.
      - Commit separately: `ux(judgment): <page> — <what> (no doc backing, review)`.

   Keep all commits small and one-issue-each so they review/revert individually.
   (To make lane (b) report-only instead of auto-fix, change "Implement the fix"
   to "make NO code change" — this is the one safe place to do that.)

6. Update `PAGES.md` status and `PROGRESS.md`. Move to the next page.

# Success check (stop condition)

You are DONE only when:
- Every page × account in `PAGES.md` is `pass`, `fixed`, or `blocked` (none `todo`), AND
- The regression suite `[npm test]` is green, AND
- Every committed fix was re-verified live.

When all of that holds, write `<promise>COMPLETE</promise>` and stop.

# Hard stops / escape hatch

- **No-progress**: if 3 consecutive iterations produce no commit and no status
  change, STOP — write the blockers to `PROGRESS.md` under "BLOCKED" and end.
- Never loop forever, never expand scope beyond `PAGES.md`, never merge to `main`.
- Never let a UX opinion leak into the objective `fix(ui):` lane — objective
  commits are only for re-verified deterministic bugs. UX changes go in
  `ux(standard):` (doc-backed) or `ux(judgment):` (flagged, no backing).
- Cost: this runs unattended. Stay efficient; one page per iteration; stop at the
  caps set in the launch invocation (see runbooks/ui-audit-overnight.md).
