# `/goal` recipes

`/goal` (Claude Code v2.1.139+) sets a completion condition and keeps working
across turns until a **separate validator model (defaults to Haiku)** confirms
it. The validator **does not call tools** — it only judges what the agent has
surfaced in the conversation. So conditions must be **provable from the agent's
own output**, not from hidden state.

## Rules for a good condition

- Make it **checkable from surfaced output**: have the agent run the check and
  print the result, then phrase the condition around that.
- Make it **specific and binary** — no "make it good".
- Keep it **reachable** — the evaluator clears a goal it judges *impossible*
  (recorded as a failed entry), and a run that stops making progress (no tool
  use for several turns) pauses with the goal still set; but a condition that is
  merely unreachable in practice can burn many turns before either trips, so
  bound it (next bullet).
- **Bound it**: include a turn or time clause in the condition itself, e.g.
  `… or stop after 20 turns`. Claude reports progress against the clause and
  the evaluator judges it from the conversation — so it's a stop condition the
  agent narrates, not an enforced cap. On headless runs, add real external
  caps too: `claude -p "/goal …" --max-turns N --max-budget-usd X` (both
  print-mode flags).
- Max condition length: 4,000 characters.

## Recipes

**Tests + lint green**
```
/goal all tests in test/auth pass and `npm run lint` reports zero errors, and you have shown the passing output — or stop after 20 turns
```

**Typecheck clean across the package**
```
/goal `tsc --noEmit` prints no errors and you have pasted the clean output — or stop after 20 turns
```

**Migration complete**
```
/goal every call site of the old `getUser()` API has been migrated to `fetchUser()`, `rg "getUser\("` returns no results, and the test suite passes — or stop after 30 turns
```

**Changelog / docs coverage**
```
/goal CHANGELOG.md has an entry for every PR merged this week, and you have listed the PRs and matched each to its entry — or stop after 15 turns
```

## Operating it

- Status: `/goal`  ·  Stop: `/goal clear` (aliases: stop, off, reset, none,
  cancel; `/clear` also removes the active goal)
- Interrupt a headless (`claude -p`) run: `Ctrl+C`; in an interactive session,
  stop with `/goal clear`
- Headless: `claude -p "/goal CHANGELOG.md has an entry for every PR merged this week"`
- Requires the trust dialog accepted; unavailable if `disableAllHooks` /
  `allowManagedHooksOnly` is set (the evaluator is part of the hooks system).

## When NOT to use `/goal`

Reach for ralph (`templates/ralph/`) instead when the task is long-running and
each iteration should reset context to anchor files. Reach for `/loop` when the
work is recurring/scheduled rather than iterate-to-completion.
