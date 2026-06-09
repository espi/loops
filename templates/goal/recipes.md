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
- Keep it **reachable** — an impossible condition loops until you stop it.
- Max condition length: ~4,000 characters.

## Recipes

**Tests + lint green**
```
/goal all tests in test/auth pass and `npm run lint` reports zero errors, and you have shown the passing output
```

**Typecheck clean across the package**
```
/goal `tsc --noEmit` prints no errors and you have pasted the clean output
```

**Migration complete**
```
/goal every call site of the old `getUser()` API has been migrated to `fetchUser()`, `rg "getUser\("` returns no results, and the test suite passes
```

**Changelog / docs coverage**
```
/goal CHANGELOG.md has an entry for every PR merged this week, and you have listed the PRs and matched each to its entry
```

## Operating it

- Status: `/goal`  ·  Stop: `/goal clear` (aliases: stop, off, reset, cancel)
- Interrupt a run: `Ctrl+C`
- Headless: `claude -p "/goal CHANGELOG.md has an entry for every PR merged this week"`
- Requires the trust dialog accepted; unavailable if `disableAllHooks` /
  `allowManagedHooksOnly` is set (the evaluator is part of the hooks system).

## When NOT to use `/goal`

Reach for ralph (`templates/ralph/`) instead when the task is long-running and
each iteration should reset context to anchor files. Reach for `/loop` when the
work is recurring/scheduled rather than iterate-to-completion.
