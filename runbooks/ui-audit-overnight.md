# Runbook: overnight UI audit loop

Drive every page with test accounts, auto-fix deterministic UI bugs (re-verified
live), and fix-and-document subjective UX issues in a reviewable lane — overnight,
on your Mac, against your running app. Template: `templates/ui-audit/`.

## Is this a good loop? (the honest split)

- **Yes — deterministic bugs.** Console errors, failed network requests, 404s,
  broken links/CTAs, axe a11y violations, layout breakage, visual regressions all
  have a machine-checkable pass/fail. Detect → fix → **re-verify the same check** →
  commit. A real verification loop.
- **Subjective UX — now grounded in `docs/`.** "Incorrect CTA," "not
  discoverable," "dead end" normally have no objective oracle — auto-fixing them
  unattended is the classic anti-pattern (`guardrails/checklist.md`). The preflight
  fixes this: it distills your `docs/` into `STANDARDS.md`, giving the loop a real
  oracle. UX issues then split into a **`ux(standard)`** lane (violates a cited doc
  rule — grounded, auto-fixed) and a **`ux(judgment)`** lane (no doc backing —
  fixed but flagged `needs-human`, and the one place you can switch to report-only).

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
2. **Run the preflight once** (a single reviewed pass — *not* the loop): in your
   project's session, `claude -p "$(cat ui-audit/PREFLIGHT.md)"` (or paste it). It
   discovers routes → writes `PAGES.md`, and distills `docs/` → `STANDARDS.md`.
3. **Eyeball the output before launching:** skim `PAGES.md` for missing/`TODO:`
   routes and the test-account mapping; skim `STANDARDS.md` to confirm the rules
   match your intent and the "Not covered by docs" gaps look right. This review
   gate is what makes the overnight run trustworthy — don't skip it.
4. Edit the `[bracketed]` parts of `PROMPT.md` (base URL, viewports, test command,
   branch date). `FINDINGS.md` is already in place.

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

1. `git log --oneline` — three lanes, increasing scrutiny:
   - `fix(ui):` — objective, re-verified live, suite green. Accept the pile.
   - `ux(standard):` — doc-backed; each cites its rule in `FINDINGS.md`. Spot-check
     the citations, keep what's right.
   - `ux(judgment):` — no doc backing, flagged `needs-human`. **Review these first**;
     `git revert` any you disagree with (isolated one-per-commit for exactly this).
2. Read `PROGRESS.md` "BLOCKED" + every `FINDINGS.md` `needs-human` entry.
3. If a `ux(judgment)` change you keep reflects a real rule, add it to your `docs/`
   so next run's preflight promotes it to the grounded `ux(standard)` lane.
4. Run the suite yourself, then open a PR / merge what you keep. Nothing auto-merged.
