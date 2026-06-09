<!--
  Overnight UI audit loop — anchor prompt.
  Self-contained: re-fed each iteration. The agent advances by reading on-disk
  state (PAGES.md, FINDINGS.md, PROGRESS.md) and the live app via the browser MCP.
  Copy this dir into your PROJECT repo (e.g. ./ui-audit/), fill PAGES.md, and run
  per RUN.md / runbooks/ui-audit-overnight.md. Edit the [bracketed] parts.
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
- `FINDINGS.md` — the UX report you append to (subjective issues + what you changed).
- `PROGRESS.md` — running log: what you did last iteration, check results, blockers.

Do NOT rely on memory of previous iterations. The files on disk are the source of truth.

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

5. **For each subjective UX issue (discoverability, dead-end, weak/incorrect CTA,
   confusing copy/empty/error states) — judgment lane:**
   - Append to `FINDINGS.md`: page, issue type, severity, a screenshot path, your
     reasoning, and the proposed change.
   - Implement the fix, but commit it SEPARATELY and clearly labeled:
     `ux(judgment): <page> — <what> (review)`. Keep these commits small and
     one-issue-each so they can be accepted or reverted individually in the morning.
   - Re-run the regression suite after each; revert + log if it breaks.

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
- If a fix needs a product/design decision you can't verify objectively, do NOT
  guess in the objective lane — log it to `FINDINGS.md` as `needs-human` and move on.
- Cost: this runs unattended. Stay efficient; one page per iteration; stop at the
  caps set in RUN.md.
