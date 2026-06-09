# Sources

Curated, deduplicated source list for the loops knowledge base. Confidence
reflects how the claim was verified: **High** = primary source read directly or
identical verbatim across multiple independent sources; **Medium** = consistent
across several secondary sources but primary not directly confirmed; **Low** =
single source / unverified provenance.

Verified as of 2026-06-09. Re-check before relying on version numbers or dates.

## Foundations & lineage

- ReAct paper — arXiv:2210.03629 (Princeton + Google, Oct 2022). **High**.
  https://arxiv.org/abs/2210.03629 ·
  https://research.google/blog/react-synergizing-reasoning-and-acting-in-language-models/
- AutoGPT (Mar 2023, Toran Bruce Richards) — **High**.
  https://en.wikipedia.org/wiki/AutoGPT ·
  failure modes: https://github.com/vectara/awesome-agent-failures/blob/main/docs/case-studies/autogpt-planning-failures.md
- Ralph loop — Geoffrey Huntley (Jul 2025). Origin **Medium** (blog not directly
  fetchable), mechanism **High** (READMEs read).
  https://ghuntley.com/ralph/ ·
  https://github.com/ghuntley/how-to-ralph-wiggum ·
  CURSED: https://ghuntley.com/cursed/
- `/goal` in Codex (Apr 30 2026) — **High**.
  https://simonwillison.net/2026/Apr/30/codex-goals/

## Key voices

- Steinberger "design loops that prompt your agents" — **High** (verbatim).
  https://x.com/steipete/status/2063697162748260627 · blog https://steipete.me/
- Boris Cherny "my job is to write loops" — **High**.
  https://workos.com/blog/boris-cherny-claude-code-acquired-interview-takeaways ·
  talk https://www.youtube.com/watch?v=RkQQ7WEor7w
- Cherny "259 PRs in 30 days, every line written by Claude Code" (Dec 27 2025) —
  **High**. https://simonwillison.net/2025/Dec/27/boris-cherny/
- Cherny "tens of thousands of agents" (Fortune, Jun 2026) — **High**.
  https://fortune.com/2026/06/08/anthropics-boris-cherny-creator-of-claude-code-says-there-are-days-he-manages-tens-of-thousands-of-ai-agents-at-once/
- Steve Yegge — Gas Town (Jan 2026) — **High** (README read).
  https://github.com/steveyegge/gastown ·
  https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04

## Claude Code mechanics (official docs — High)

- `/loop` & scheduled tasks: https://code.claude.com/docs/en/scheduled-tasks
- `/goal`: https://code.claude.com/docs/en/goal
- Claude Code on the web: https://code.claude.com/docs/en/claude-code-on-the-web
- Routines (cloud schedule, laptop-closed; **research preview**): https://code.claude.com/docs/en/routines
- Agent teams: https://code.claude.com/docs/en/agent-teams
- Subagents: https://code.claude.com/docs/en/sub-agents
- Skills: https://code.claude.com/docs/en/skills
- Agent SDK loop & guardrails (`max_turns`, `max_budget_usd`): https://code.claude.com/docs/en/agent-sdk/agent-loop
- Official `ralph-wiggum` plugin: https://github.com/anthropics/claude-code/blob/main/plugins/ralph-wiggum/README.md
  — `--max-iterations` **defaults to unlimited**; `--completion-promise` is exact-string match. **High**.
- **Dynamic Workflows** (`/workflows`, research preview) — native orchestration,
  caps baked in (16 concurrent, 1,000 agents/workflow, token budget). **High** (docs).
  https://code.claude.com/docs/en/workflows · https://code.claude.com/docs/en/whats-new/2026-w22
- `/usage` spend breakdown by skill/subagent/plugin/MCP. **High** (docs).
  https://code.claude.com/docs/en/whats-new

## Verification & skills

- Building Effective Agents (evaluator-optimizer, workflows vs agents) — **Medium**.
  https://www.anthropic.com/research/building-effective-agents
- Agent Skills overview — **High**.
  https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview ·
  https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills
- roborev (continuous per-commit review, Dan Kornas) — **High** (README read).
  https://github.com/roborev-dev/roborev · https://www.roborev.io/

## Guardrails & cost

- Anthropic Agent SDK guardrail params — **High**.
  https://code.claude.com/docs/en/agent-sdk/agent-loop
- AgentGuard (budget/loop/timeout guards) — **High** (README read).
  https://github.com/bmdhodl/agent47
- Uber $1,500/mo per-tool cap, annual budget gone in ~4 months — **High** (multi-outlet).
  https://techcrunch.com/2026/06/02/uber-caps-employee-ai-spending-after-blowing-through-budget-in-four-months/
- Gartner ">40% of agentic AI projects canceled by 2027" — **High** (press release).
  https://www.gartner.com/en/newsroom/press-releases/2025-06-25-gartner-predicts-over-40-percent-of-agentic-ai-projects-will-be-canceled-by-end-of-2027
- Anthropic billing split (eff. ~Jun 15 2026): programmatic entry points (Agent
  SDK, `claude -p`, GH Actions) → separate metered credit pool at API list
  prices — **Medium** (secondary, incl. Axios; no primary Anthropic notice read).
  https://www.axios.com/2026/05/14/anthropic-claude-price-openai-tokens ·
  https://codersera.com/blog/anthropic-june-2026-billing-change-claude-code/

## Ecosystem (newer than the seed)

- Geoffrey Huntley — **Loom** ("factory" orchestrator of ralph loops). Repo is
  experimental/proprietary and described more modestly than the talk framing —
  **Medium/Low** (gap between marketing and README).
  https://github.com/ghuntley/loom · talk: AI Engineer Melbourne, Jun 3–4 2026.
- "Loop Engineering" — term popularized by Addy Osmani, crediting Steinberger +
  Cherny — **Medium** (primary Substack 403'd; concept is derivative of KB).
  https://addyo.substack.com/p/loop-engineering

## Known caveats / things to re-verify

- The slogan "the costliest thing in AI coding is managing the agent loop" is a
  community paraphrase, not a sourced Cherny quote.
- The "5 tips for running agents autonomously" is real in substance but not
  published by Cherny as a numbered list — secondary packaging.
- The `/goal` "Codex invented it, Claude copied in 11 days" timeline rests on a
  single secondary source.
- `$47K / 11-day loop` and overnight-billing figures are self-reported anecdotes.
- **`$500M in one month`** uncapped-usage incident — unnamed company, no primary
  disclosure. Treat the figure as unverified; the failure mode is the takeaway.
- **June 15 2026 billing split** — confirm against a primary Anthropic notice
  (changelog / email / help-center) before relying on the exact terms or date.
- **Huntley's Loom** as an "orchestrator of ralph loops" — self-described in
  talk/tweets; the public README is more modest. Re-check as it matures.
- Steinberger / Osmani "Loop Engineering" verbatim — primary X/Substack URLs
  403'd; quotes are snippet-sourced.
