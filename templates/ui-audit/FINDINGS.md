<!--
  UX findings log — the "report" half of the audit. The loop appends a block per
  subjective issue (discoverability, dead-ends, CTAs, copy, empty/error states).
  This is your morning review queue. Rename to FINDINGS.md in your project.
-->

# UX findings

Each entry pairs an observation with the change the loop made, tagged by lane so
you can triage fast on review:
- **`ux(standard)`** — fixed to conform to a rule in `STANDARDS.md` (cites the doc).
  Grounded; usually safe to keep.
- **`ux(judgment)`** — no documented standard backs it; flagged `needs-human`.
  Scrutinize these first.

<!-- Template for each entry:

## [page] — [issue type: discoverability | dead-end | cta | copy | empty-state | error-state]
- **Lane:** ux(standard) | ux(judgment)
- **Rule + source:** <rule> [docs: <file>#<section>]   (standard lane only)
- **Account / viewport:** qa_member / mobile
- **Severity:** high | medium | low
- **Observation:** what's wrong and why it hurts the user
- **Screenshot:** ./shots/<file>.png (before) / <file>-after.png
- **Change made:** what was edited
- **Commit:** ux(standard|judgment): <subject>
- **Needs human?:** yes/no — if yes, what decision is open

-->
