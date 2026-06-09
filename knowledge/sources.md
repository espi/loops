# Sources

Curated, deduplicated source list for the loops knowledge base. Confidence
reflects how the claim was verified: **High** = primary source read directly or
identical verbatim across multiple independent sources; **Medium** = consistent
across several secondary sources but primary not directly confirmed; **Low** =
single source / unverified provenance.

Verified as of 2026-06-09 (pass 2). Re-check before relying on version numbers or dates.

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
  Note: Steinberger joined OpenAI in February 2026 (https://steipete.me/posts/2026/openclaw);
  the loops/skills advocacy predates that role.
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
- Steve Yegge — Gas City (Apr 24, 2026): Gas Town rewritten as composable Go SDK
  by Julian Knutsen and Chris Sells. Removes hardcoded roles, adds declarative
  packs, Dolt-backed audit trail, convergence loop. MIT licensed. — **Medium**
  (GitHub README read directly; Medium post paywalled; X post 403).
  https://github.com/gastownhall/gascity ·
  https://steve-yegge.medium.com/welcome-to-gas-city-57f564bb3607

## Key voices — additional (new this pass)

- Boris Cherny on Fable 5 (June 9, 2026): "biggest step up since Opus 4.5...
  better self-verification, longer running sessions, higher trust & autonomy." —
  **Medium** (X post search snippet; primary 403).
  https://x.com/bcherny/status/2064402671898075579
- Boris Cherny at Sequoia AI Ascent (~May 2026): "every night I have a few
  thousand agents running"; 150 PRs in one day from phone; cron loops babysit
  PRs and fix CI automatically — **Medium** (secondary summary tweet; primary
  event video not directly accessed).
  https://x.com/hanakoxbt/status/2059670998535008702
- Addy Osmani — "Agent Harness Engineering" (Apr 19, 2026): "The model is one
  input into a running agent. The rest is the harness... It's not a model
  problem. It's a configuration problem." — **Medium** (search summary).
  https://addyosmani.com/blog/agent-harness-engineering/

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
  caps baked in (16 concurrent, 1,000 agents/workflow, token budget). Trigger
  keyword `"ultracode"` (v2.1.157+; `"workflow"` still accepted). `/deep-research`
  bundled workflow uses adversarial cross-checking across subagents. **High** (docs).
  https://code.claude.com/docs/en/workflows · https://code.claude.com/docs/en/whats-new/2026-w22
- `/usage` spend breakdown by skill/subagent/plugin/MCP. **High** (docs).
  https://code.claude.com/docs/en/whats-new
- `--safe-mode` flag (v2.1.169): disables all customizations (skills, hooks,
  plugins, CLAUDE.md, MCP) for troubleshooting. Also `CLAUDE_CODE_SAFE_MODE` env
  var. `disableBundledSkills` / `CLAUDE_CODE_DISABLE_BUNDLED_SKILLS` hides bundled
  skills and built-in slash commands. **High** (changelog).
  https://code.claude.com/docs/en/changelog
- `--thinking disabled` flag (v2.1.166); `fallbackModel` now accepts up to 3
  models tried in order. **High** (changelog). https://code.claude.com/docs/en/changelog
- **Claude Fable 5** (v2.1.170, June 9 2026): new flagship Mythos-class model.
  $10/M input, $50/M output tokens. Available on Pro/Max/Team/Enterprise.
  Anthropic describes it as the best coding model by wide margin; Cherny:
  "better self-verification, longer running sessions, higher trust & autonomy."
  **High** (primary Anthropic announcement).
  https://www.anthropic.com/news/claude-fable-5-mythos-5

## Verification & skills

- Building Effective Agents (evaluator-optimizer, workflows vs agents) — **Medium**.
  https://www.anthropic.com/research/building-effective-agents
- Agent Skills overview — **High**.
  https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview ·
  https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills
- **Agent Skills open standard** (Dec 18, 2025): Anthropic open-sourced the spec,
  donated governance to Agentic AI Foundation (Linux Foundation). Adopters include
  Codex CLI, GitHub Copilot, Cursor, VS Code, Gemini CLI. Custom commands
  (`.claude/commands/`) merged into skills. `run: subagent` frontmatter added.
  **Medium** (primary Anthropic blog 403; multiple secondary sources consistent).
  https://siliconangle.com/2025/12/18/anthropic-makes-agent-skills-open-standard/
  https://code.claude.com/docs/en/skills (primary docs — High)
- roborev (continuous per-commit review, Dan Kornas) — latest v0.57.1 (Jun 9
  2026). Now ships installable `$roborev-review` Agent Skill (`roborev skills
  install`); `--panel N` fans commit review to N independent reviewer subagents;
  `roborev refine` loop iterates fix→re-review until clear or `--max-iterations`
  hit. **High** (GitHub README and releases read directly).
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
- Anthropic billing split (eff. Jun 15 2026): programmatic entry points (Agent
  SDK, `claude -p`, GH Actions) → separate metered credit pool at API list
  prices. Credits: Pro $20/mo, Max 5× $100/mo, Max 20× $200/mo, Team/Enterprise
  $100–$200/seat. Interactive Claude Code stays on subscription. — **High**
  (primary Anthropic Help Center article confirmed; previously Medium).
  https://support.claude.com/en/articles/15036540-use-the-claude-agent-sdk-with-your-claude-plan ·
  https://www.axios.com/2026/05/14/anthropic-claude-price-openai-tokens
- GitHub Copilot token-based billing (eff. Jun 1, 2026): costs jumping from $29
  to $750/mo for heavy agentic use patterns in reported cases. — **High** (GitHub
  official blog + TechCrunch).
  https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/ ·
  https://techcrunch.com/2026/05/30/what-a-joke-github-copilots-new-token-based-billing-spurs-consternation-among-devs/
- Goldman Sachs "Decoding the Agentic Economy" (May 8, 2026): projects 24× token
  demand increase by 2030 as agentic workflows dominate. — **High** (Goldman
  Sachs primary; cited by Tom's Hardware and others).
  https://www.goldmansachs.com/insights/articles/ai-agents-forecast-to-boost-tech-cash-flow-as-usage-soars
- TechCrunch runaway cost roundup (June 5, 2026): $6,000 overnight run, $2,847
  four-hour runaway, $4,200 long-weekend refactor — self-reported anecdotes. —
  **Medium** (TechCrunch primary; individual figures self-reported).
  https://techcrunch.com/2026/06/05/the-token-bill-comes-due-inside-the-industry-scramble-to-manage-ais-runaway-costs/
- Anthropic Rate Limits API (Apr 25, 2026): programmatic read access to org/
  workspace rate limits; enables gateways and spend-alert integrations. — **High**
  (primary Anthropic docs read directly).
  https://platform.claude.com/docs/en/manage-claude/rate-limits-api
- Anthropic Claude Code Analytics Admin API (Mar 2026): per-user estimated costs,
  productivity metrics (sessions, lines, commits, PRs, tool usage), multi-model
  cost breakdowns. — **High** (primary Anthropic docs).
  https://docs.anthropic.com/en/api/claude-code-analytics-api
- Gartner governance press release (May 26, 2026): "Applying uniform governance
  across AI agents will lead to enterprise AI agent failure." Adds: 40% of
  enterprises will demote/decommission production agents by end of 2027 due to
  governance gaps post-deployment; guardian agents projected at 10–15% of agentic
  AI market by 2030; "FinOps for agentic AI" on Hype Cycle. — **High** (Gartner
  newsroom canonical URL; primary 403 on direct fetch, confirmed by multiple
  independent secondary sources).
  https://www.gartner.com/en/newsroom/press-releases/2026-05-26-gartner-says-applying-uniform-governance-across-ai-agents-will-lead-to-enterprise-ai-agent-failure

## Ecosystem (newer than the seed)

- Geoffrey Huntley — **Loom**: full Rust monorepo (30+ crates), LLM proxy
  architecture, thread/conversation persistence, OAuth, Svelte web UI. Public
  on GitHub but proprietary license ("do not use unless you are Geoffrey
  Huntley"); no public releases. Demonstrated at AI Engineer Melbourne (Jun 3–4
  2026): "Everything Is a Factory" keynote. — **High** for architecture (README
  read directly); **Medium** for talk details (conference summary, 403 on blog).
  https://github.com/ghuntley/loom ·
  https://webdirections.org/blog/everything-is-a-factory-geoff-huntley-at-ai-engineer-melbourne-2026/
- "Loop Engineering" — term popularized by Addy Osmani, crediting Steinberger +
  Cherny — **Medium** (primary Substack 403'd; concept is derivative of KB).
  https://addyo.substack.com/p/loop-engineering
- **OpenAI Codex CLI `/goal`** (0.128.0 Apr 30, 2026; GA May 21): same validator-
  model pattern as Claude Code's `/goal` — small fast model answers "has the goal
  been met?" after each step. Cross-industry adoption confirms the pattern. —
  **Medium** (multiple secondary sources; primary Codex changelog 403).
  https://github.com/openai/codex/releases

## Known caveats / things to re-verify

- The slogan "the costliest thing in AI coding is managing the agent loop" is a
  community paraphrase, not a sourced Cherny quote.
- The "5 tips for running agents autonomously" is real in substance but not
  published by Cherny as a numbered list — secondary packaging.
- The `/goal` "Codex invented it, Claude copied in 11 days" timeline rests on a
  single secondary source. (Codex released Apr 30; Claude Code had it Apr–May 2026;
  exact gap not confirmed from primary sources.)
- `$47K / 11-day loop` and overnight-billing figures are self-reported anecdotes.
- **`$500M in one month`** uncapped-usage incident — unnamed company, no primary
  disclosure. Treat the figure as unverified; the failure mode is the takeaway.
- ~~**June 15 2026 billing split**~~ — **Confirmed High** this pass (primary Help
  Center article found). Removed from re-verify.
- **Agent Skills open standard** — Anthropic engineering blog 403'd; SiliconAngle
  and secondary sources confirm Dec 18 2025 date and Linux Foundation governance.
  Re-verify once primary blog is accessible.
- **Gas City** (github.com/gastownhall/gascity) — GitHub README confirmed, Medium
  post paywalled. Re-check the "Gastown pack" migration claim against docs.
- Steinberger / Osmani "Loop Engineering" verbatim — primary X/Substack URLs
  403'd; quotes are snippet-sourced.
- **Cherny "Fable is the biggest step up since Opus 4.5"** — X post summary from
  search snippet; primary X post 403'd. Verify before quoting verbatim.
