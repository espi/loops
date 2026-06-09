# Runbook: overnight UI audit loop

Drive every page with test accounts, auto-fix deterministic UI bugs (re-verified
live), and fix-and-document subjective UX issues in a reviewable lane — overnight,
on your Mac, against your running app. Template: `templates/ui-audit/`.

## Is this a good loop? (the honest split)

- **Yes — deterministic bugs.** Console errors, failed network requests, 404s,
  broken links/CTAs, axe a11y violations, layout breakage, visual regressions all
  have a machine-checkable pass/fail. Detect → fix → **re-verify the same check** →
  commit. A real verification loop.
- **Caution — subjective UX.** "Incorrect CTA," "not discoverable," "dead end by
  judgment" have no objective oracle. Auto-fixing them unattended is the classic
  loop anti-pattern (see `guardrails/checklist.md`). This runbook still fixes them,
  but isolates the changes so they're trivial to review/revert.

## Prerequisites

- App running locally (e.g. `http://localhost:3000`).
- A **browser-driving MCP** (Playwright / chrome-devtools) connected to your
  Claude Code session — this is the verification oracle. Confirm it can read
  console + network + DOM and run axe.
- **Disposable test accounts on a non-prod environment**, seeded. The loop clicks
  destructive things.
- Clean git tree; create the work branch: `git switch -c claude/ui-fixes-$(date +%F)`.
- Optional: baseline screenshots in `baseline/` for visual diffing; `roborev init`
  for per-commit review while context is fresh.

## Set up

1. Copy `templates/ui-audit/` into your project as `./ui-audit/`.
2. Rename `PAGES.example.md` → `PAGES.md` and fill in **every** route, the test
   account(s) per route, preconditions, your base URL, viewports, and the
   regression-suite command. This list is the loop's scope AND its stop condition.
3. Rename `FINDINGS.md` (keep the template header). Edit the `[bracketed]` parts
   of `PROMPT.md` (base URL, viewports, test command, branch date).

## Run it

This must run **on your Mac** (the app is on localhost; a cloud Routine can't see
it) and **in the session that has the browser MCP**. That session is
**session-scoped** — if the laptop sleeps, it stops. So keep it awake.

**Recommended — in your existing interactive session (has the MCP), capped:**

```bash
# keep the Mac awake for the whole run
caffeinate -ids &

# then, inside your Claude Code session, run the ralph-wiggum plugin:
/ralph-loop "$(cat ui-audit/PROMPT.md)" --completion-promise "COMPLETE" --max-iterations 40
```

> `--max-iterations` is the real cap — it defaults to *unlimited*, so always set
> it. Size it to your page count: roughly `pages × accounts × ~1.5` for fix
> headroom. Cancel anytime with `/cancel-ralph`.

## The three hard stops (mapped)

1. **Max iterations** — `--max-iterations 40` (and a finite `PAGES.md` bounds the work).
2. **No-progress** — the prompt stops after 3 iterations with no commit/status change.
3. **Budget ceiling** — overnight is the blow-out scenario. Before bed, note your
   spend; set a number you won't exceed and check `/usage` in the morning. For a
   *hard* dollar kill-switch, run headless via `templates/ralph/run.sh` instead
   (wire its `cost_so_far` meter) — but confirm your browser MCP is available to
   non-interactive `claude -p` first; if it isn't, stay in the interactive session.

## Morning review

1. `git log --oneline` — two lanes: `fix(ui):` (objective, re-verified) and
   `ux(judgment):` (opinionated, review).
2. Accept the `fix(ui):` pile; it was verified live + kept the suite green.
3. Scrutinize each `ux(judgment):` against `FINDINGS.md`; `git revert` any you
   disagree with — they're isolated one-per-commit for exactly this.
4. Read `PROGRESS.md` "BLOCKED" + `FINDINGS.md` `needs-human` items.
5. Run the suite yourself, then open a PR / merge what you keep. Nothing auto-merged.
