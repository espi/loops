<!--
  One-shot PREFLIGHT — run ONCE before the overnight loop, then eyeball the output.
  This is NOT the loop. It's a single pass that (1) discovers every page to audit
  and (2) distills your docs/ into the UX rules the loop will enforce. Run it in
  your project's Claude Code session, e.g. paste this or:
      claude -p "$(cat ui-audit/PREFLIGHT.md)"
  Keeping discovery separate gives you a review gate before anything runs unattended.
-->

# Preflight: discover pages + distill UX standards

Do these two tasks once, then stop. Make no app changes.

## Task 1 — Write `ui-audit/PAGES.md`

Enumerate every user-facing page/route in this project. Sources to check, in order:
- the router config / file-based route directory (e.g. `app/`, `pages/`, route tables)
- navigation components, menus, and any sitemap
- existing e2e/integration tests for route coverage
- as a fallback, crawl in-app links from the entry route using the browser MCP

For each route, fill a row in `ui-audit/PAGES.md` using the structure in
`PAGES.example.md`: route, the test account(s)/role needed to reach it, any
precondition/seeded state, and `status: todo`. Also fill the header (base URL,
viewports, regression-suite command) by inferring from the project; leave a
`TODO:` marker on anything you cannot determine so a human fills it.

Group routes sensibly and flag any that need special setup. Be complete — this
list is the loop's scope and its stop condition.

## Task 2 — Write `ui-audit/STANDARDS.md`

Read the project's `docs/` folder (design system, UX guidelines, content/voice
guide, component usage, IA/navigation principles, accessibility standards, empty-
and error-state conventions). Distill them into a **concise, enumerated checklist
of enforceable rules** — the standard the loop will hold each page to.

For each rule:
- State it as a checkable assertion (e.g. "Primary CTA label names the destination
  or action; no generic 'Click here'").
- **Cite the source** doc + section it comes from.
- Group by category: navigation/discoverability, CTAs, copy/voice, components/design
  system, empty states, error states, accessibility.

Only include rules that are actually grounded in `docs/`. If the docs are silent on
something, do NOT invent a rule — note the gap under a "## Not covered by docs"
section so the loop knows those areas are judgment calls, not standards.

## Then stop

Report a summary: how many pages discovered, how many standards distilled, and any
`TODO:`/gaps a human should resolve before the overnight run. Do not start auditing.
