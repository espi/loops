<!--
  Page checklist — the loop's scope and its natural stop condition.
  You don't have to fill this by hand: run PREFLIGHT.md once and the session
  discovers routes (from the router, nav, sitemap, e2e tests, or a link-crawl)
  and writes this file — then you eyeball it before launching. The loop processes
  each row once (plus re-verify), so a complete, finite list bounds the run.
  Status starts `todo`; the loop updates it.
-->

# Pages to audit

Base URL: `http://localhost:3000`
Viewports: `1440x900` (desktop), `390x844` (mobile)
Regression suite: `npm test`

## Test accounts

| Account | Role | Login | Notes / seeded state |
|---------|------|-------|----------------------|
| qa_admin    | admin   | qa_admin@test.local / [pw]   | full access; disposable |
| qa_member   | member  | qa_member@test.local / [pw]  | standard user; disposable |
| qa_new      | new/empty | qa_new@test.local / [pw]   | fresh account — exercises empty states |

> Use disposable accounts on a NON-PROD environment. The loop will click
> destructive actions. Do not point it at data you care about.

## Routes

| # | Route | Accounts | Preconditions | Status |
|---|-------|----------|---------------|--------|
| 1 | `/`              | qa_member, qa_new | — | todo |
| 2 | `/dashboard`     | qa_admin, qa_member, qa_new | — | todo |
| 3 | `/settings`      | qa_member | — | todo |
| 4 | `/settings/billing` | qa_admin | seeded plan | todo |
| 5 | `/[your route]`  | [account] | [setup] | todo |
<!-- add every page; the more complete this is, the better the coverage and the
     cleaner the stop condition -->
