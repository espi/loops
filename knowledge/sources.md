# Sources

Curated, deduplicated source list for the loops knowledge base. Confidence
reflects how the claim was verified: **High** = primary source read directly or
identical verbatim across multiple independent sources; **Medium** = consistent
across several secondary sources but primary not directly confirmed; **Low** =
single source / unverified provenance.

Verified as of 2026-07-06. Re-check before relying on version numbers or dates.

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
- `/goal` in Codex (Apr 30 2026; GA May 21 2026) — **High** (Codex shipping the
  same validator-model stop-condition pattern is cross-industry confirmation that
  the "fresh model judges done" fix is the durable answer to AutoGPT's open loop).
  https://simonwillison.net/2026/Apr/30/codex-goals/ ·
  https://github.com/openai/codex/releases

## Key voices

- Steinberger "design loops that prompt your agents" — **High** (verbatim).
  https://x.com/steipete/status/2063697162748260627 · blog https://steipete.me/
  Note: Steinberger joined OpenAI in February 2026; the loops/skills advocacy
  predates that role. — **Medium** (secondary).
- Boris Cherny "my job is to write loops" — **High**.
  https://workos.com/blog/boris-cherny-claude-code-acquired-interview-takeaways ·
  talk https://www.youtube.com/watch?v=RkQQ7WEor7w
- Cherny "259 PRs in 30 days, every line written by Claude Code" (Dec 27 2025) —
  **High**. https://simonwillison.net/2025/Dec/27/boris-cherny/
- Cherny "tens of thousands of agents" (Fortune, Jun 2026) — **High**.
  https://fortune.com/2026/06/08/anthropics-boris-cherny-creator-of-claude-code-says-there-are-days-he-manages-tens-of-thousands-of-ai-agents-at-once/
- Cherny "I haven't written a line of code by hand in... eight months now"
  (Fortune, Jun 11, 2026) — **High** (multiple outlets, consistent).
  https://fortune.com/2026/06/11/anthropic-claude-boris-cherny-doesnt-write-code-by-hand-anymore/
- Cherny "I'm not doing the prompting — I create the routines that do the
  prompting" (Jun 2026, interview) — **Medium** (secondary citations; primary
  interview URL not directly fetched). https://cobusgreyling.substack.com/p/loop-engineering
- Osmani "Trust, But Verify" — "verification, not generation, is the next
  development bottleneck" (Substack, Jun 9, 2026) — **Medium** (confirmed in
  search; primary Substack 403'd). https://addyo.substack.com/p/the-trust-but-verify-pattern-for
- Osmani "Agentic Code Review" (Substack + addyosmani.com, June 16, 2026):
  four-dataset analysis — AI adoption quadruples code volume but ~12% productivity
  gain; defect rates 9%→54%; review times +441%; zero-review merges +31%;
  *"the hard part of engineering moved from writing code to deciding whether to
  trust it."* — **Medium** (primary URLs 403'd; date confirmed by multiple search
  indexes; quotes consistent across aggregators).
  https://addyo.substack.com/p/agentic-code-review · https://addyosmani.com/blog/agentic-code-review/
  Announcement: https://x.com/addyosmani/status/2066595308629594363
- Steve Yegge — Gas Town (Jan 2026) — **High** (README read).
  https://github.com/steveyegge/gastown ·
  https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04
- Steve Yegge — Gas City (Apr 25, 2026): Gas Town rewritten as SDK; MEOW stack,
  composable "packs." — **Medium** (search-confirmed; Medium 403'd to fetch).
  https://x.com/Steve_Yegge/status/2047582408799584394
- Steve Yegge — "The Flat Curve Society" (Medium, ~June 19, 2026): model
  capability plateau, AI adoption culture; *"supervised agentic flows"* as the
  key enterprise shift. Peripheral to loop patterns but relevant macro context.
  — **Medium** (date confirmed "3 days ago" from Jun 22 in two independent
  search sets; Medium 403'd; quotes from search extracts).
  https://steve-yegge.medium.com/the-flat-curve-society-36c8b01eb33b ·
  https://x.com/Steve_Yegge/status/2067816148775956952
- Boris Cherny at Meta @Scale (June 22, 2026): "Two years ago, we wrote source
  code by hand. We started to transition so agents write the code. And now
  we're transitioning to the point where agents are prompting agents that then
  write the code." Loops are "as big a step as source code → agents." Production
  example: architecture and deduplication agents running as permanent background
  loops submitting PRs. — **High** (TechCrunch direct conference reporting).
  https://techcrunch.com/2026/06/22/the-ai-world-is-getting-loopy/
- Osmani "Loop Engineering" (O'Reilly Radar + Substack, June 22, 2026): formal
  definition of loop engineering for a mainstream audience; five moves of a
  loop turn: discovery / handoff / verification / persistence / scheduling. —
  **High** (primary sources directly accessible).
  https://oreillyradar.substack.com/p/loop-engineering ·
  https://addyo.substack.com/p/loop-engineering
- The Register, "loop engineering, latest AI buzzword, still needs humans in
  the loop" (June 24, 2026): editorial critique; notes automated graders can
  confirm link resolution but not framing correctness. — **High** (professional
  journalism). Peripheral to primer but useful counter-context.
  https://www.theregister.com/ai-and-ml/2026/06/24/loop-engineering-latest-ai-buzzword-still-needs-humans-in-the-loop/5261735

## Claude Code mechanics (official docs — High)

- `/loop` & scheduled tasks: https://code.claude.com/docs/en/scheduled-tasks
- `/goal`: https://code.claude.com/docs/en/goal
- Claude Code on the web: https://code.claude.com/docs/en/claude-code-on-the-web
- Routines (cloud schedule, laptop-closed; **research preview**): https://code.claude.com/docs/en/routines
- Agent teams: https://code.claude.com/docs/en/agent-teams
- Subagents: https://code.claude.com/docs/en/sub-agents
- Skills: https://code.claude.com/docs/en/skills
- Agent SDK loop & guardrails (`max_turns`, `max_budget_usd`): https://code.claude.com/docs/en/agent-sdk/agent-loop
- Agent SDK billing change (eff. Jun 15, 2026) — **High** (noted on Agent SDK
  overview page). https://code.claude.com/docs/en/agent-sdk/overview
- Official `ralph-wiggum` plugin: https://github.com/anthropics/claude-code/blob/main/plugins/ralph-wiggum/README.md
  — `--max-iterations` **defaults to unlimited**; `--completion-promise` is exact-string match. **High**.
- **Dynamic Workflows** (trigger: `ultracode`; research preview) — native orchestration,
  caps baked in (16 concurrent, 1,000 agents/workflow, token budget). Trigger
  keyword renamed from `workflow` → `ultracode` in v2.1.160 (Jun 2, 2026). **High** (docs).
  https://code.claude.com/docs/en/workflows · https://code.claude.com/docs/en/whats-new/2026-w22
- `/usage` spend breakdown by skill/subagent/plugin/MCP. **High** (docs).
  https://code.claude.com/docs/en/whats-new
- **Claude Code changelog** (primary; v2.1.170–201, Jun 9–Jul 3, 2026) — **High**.
  https://code.claude.com/docs/en/changelog ·
  https://github.com/anthropics/claude-code/releases
  Key loop-relevant changes: v2.1.172 — 5-level nested sub-agents; v2.1.174 —
  usage attribution breakdown in VS Code Account dialog; v2.1.176 — hook `if`
  path-pattern fix; v2.1.178 (Jun 15) — agent teams implicit, `Tool(param:value)`
  permission syntax, nested skills load from subdirs; v2.1.181 (Jun 17) —
  foreground subagents also capped at 5 levels, `/config key=value`,
  `CLAUDE_CLIENT_PRESENCE_FILE`; v2.1.183 (Jun 19) — auto mode blocks destructive
  git/IaC commands, `attribution.sessionUrl`; v2.1.185 (Jun 20) — stream-stall
  threshold raised to 20s; v2.1.191 (Jun 24) — `/rewind` command, ~37% CPU
  reduction in streaming via coalescing, MCP OAuth headless improvement, sandbox
  network host memory; v2.1.193 (Jun 25) — `autoMode.classifyAllShell`
  setting, denial reasons in transcript/UI, bash `!`-autocomplete,
  `claude_code.assistant_response` OpenTelemetry event; v2.1.195 (Jun 26) —
  hook matcher fix for hyphenated MCP names (now exact-match),
  `CLAUDE_CODE_DISABLE_MOUSE_CLICKS`, voice dictation fixes; **v2.1.197 (Jun
  30)** — Claude Sonnet 5 becomes Claude Code's default model (native 1M
  context, promo pricing $2/$10 per MTok through Aug 31, 2026); **v2.1.198
  (Jul 1)** — subagents background-by-default, background agents auto-commit/
  push and open a draft PR on finishing worktree work, Explore agent inherits
  session model capped at Opus (was fixed Haiku), `/agents` wizard removed,
  Claude in Chrome reaches GA, `/dataviz` skill added; **v2.1.199 (Jul 2)** —
  subagents cut off by rate limits/errors return partial work instead of
  silently misreporting success, stacked slash-skills load up to 5 leading
  skills, `CLAUDE_CODE_RETRY_WATCHDOG` raises default retries to 300 and
  removes the 15-retry cap on `CLAUDE_CODE_MAX_RETRIES`; **v2.1.200 (Jul 3)**
  — `AskUserQuestion` no longer auto-continues by default, default permission
  mode renamed "Manual"; **v2.1.201 (Jul 3)** — Sonnet 5 sessions drop the
  mid-conversation system role for harness reminders.
- **Dynamic Workflows Pro-plan GA** (~Jul 2, 2026) — reported off-by-default on
  Pro (enable via `/config`), on-by-default for Max/Team, off-by-default for
  Enterprise (admin-enabled). **Medium** — consistent across techtimes.com,
  ainave.com, InfoQ secondaries; no primary changelog line identified, docs page
  itself undated for this rollout. Re-verify against a primary source.
  https://www.techtimes.com/articles/319532/20260702/
- **Claude Code Artifacts** (beta, June 18, 2026) — interactive single-page
  HTML artifacts ≤16 MiB generated from session work; Team/Enterprise only.
  **High** (official Anthropic blog).
  https://claude.com/blog/artifacts-in-claude-code
- **Permission tool-name globs** (deny/ask rules, documented Jun 2026) —
  `mcp__*` in a deny rule blocks all MCP tools; allow rules accept globs only
  after a literal `mcp__<server>__` prefix; unanchored allow globs rejected with
  a warning. **High** (official permissions docs).
  https://code.claude.com/docs/en/permissions
- **`--safe-mode`** / `CLAUDE_CODE_SAFE_MODE=1` (v2.1.169+) — **High** (changelog).
  Disables all customizations for debugging (auth and model still work).
- **`fallbackModel` setting** (v2.1.166+) — chains up to 3 fallback models on
  overload/error. **Medium** (secondary sources; changelog not directly read for
  this entry). https://www.digitalapplied.com/blog/claude-code-safe-mode-fallback-models-production-resilience-guide
- **Claude Fable 5** (`claude-fable-5`) — launched Jun 9, 2026 (v2.1.170). 1M
  context, 128k output, $10/$50 per MTok I/O. Suspended globally Jun 12–13
  following US government export-control directive; **back on the platform** as
  of the week of June 22, 2026 (suspension was short-lived). Claude Mythos 5
  (`claude-mythos-5`) — limited availability via Project Glasswing since Jun 9;
  same pricing/context. Claude Opus 4.1 deprecated, retiring August 5, 2026.
  — **High** (platform.claude.com/docs/en/about-claude/models/ read directly Jun
  22; launch and suspension confirmed via primary Anthropic sources; suspension
  URL confirmed by user).
  https://platform.claude.com/docs/en/about-claude/models/ ·
  https://platform.claude.com/docs/en/about-claude/models/introducing-claude-fable-5-and-claude-mythos-5 ·
  https://www.anthropic.com/news/fable-mythos-access
- **`security-guidance` plugin** (Anthropic, Week 22, May 29, 2026) — 3-tier
  review-in-the-loop: fast pattern scan per edit, model review per turn, deeper
  agentic review on commit/push. **High** (official Week 22 docs).
  https://code.claude.com/docs/en/whats-new/2026-w22

## Verification & skills

- Building Effective Agents (evaluator-optimizer, workflows vs agents) — **Medium**.
  https://www.anthropic.com/research/building-effective-agents
- Agent Skills overview — **High**.
  https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview ·
  https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills
- **Agent Skills open standard** (Dec 18, 2025): Anthropic open-sourced the spec,
  governance donated to the Agentic AI Foundation (Linux Foundation); adopters
  include Codex CLI, GitHub Copilot, Cursor, VS Code — a skill built for Claude
  Code is portable across platforms. Custom commands (`.claude/commands/`) merged
  into skills; `run: subagent` frontmatter added. — **Medium** (primary Anthropic
  blog 403'd; multiple secondaries consistent; primary docs High).
  https://siliconangle.com/2025/12/18/anthropic-makes-agent-skills-open-standard/ ·
  https://code.claude.com/docs/en/skills
- roborev (continuous per-commit review, **Wes McKinney** (@wesmckinn)) — **High**
  (GitHub releases read directly).
  v0.57.1 (Jun 9, 2026): Windows archive fixes, daemon route, TUI performance.
  v0.58.0 (Jun 11, 2026): Kata integration, branch filtering for hooks, queue
  pause/resume, **aggregate review cost tracking**, generated public daemon client.
  Now ships an installable `$roborev-review` Agent Skill (`roborev skills install`)
  with a `--panel N` flag that fans a commit review to N independent reviewer
  subagents whose verdicts are synthesized before surfacing.
  v0.61.0 (Jun 30, 2026): export support for completed reviews, a "lookahead"
  review type for detecting time-series bias, Factory Droid hook/skill support,
  per-analysis agent configuration, configurable post-commit hook timeouts.
  v0.61.1 (Jul 3, 2026): incremental review export cursors, published docs
  Markdown sources, expanded refine docs for Agent Hook automation.
  v0.61.2 (Jul 4, 2026): wall-clock elapsed-time display in TUI queue panels,
  trimmed prompt text from metadata-only job listings.
  https://github.com/roborev-dev/roborev/releases · https://www.roborev.io/
- Addy Osmani "Agentic Autonomy Levels" (Substack, Jul 3, 2026) — follow-on to
  "Agentic Code Review": autonomy granted to an agent should be earned by
  accumulated verification evidence, not asserted by a task label; names
  "autonomy as status" as an anti-pattern. — **Medium** (search-snippet
  corroborated; primary Substack fetch blocked/paywall-adjacent).
  https://addyo.substack.com/p/agentic-autonomy-levels

- **Snyk ToxicSkills** (June 23, 2026): Audit of 3,984+ public Agent Skills
  (ClaWHub marketplace) — prompt injection vulnerabilities in **36%** of skills;
  **13.4%** contain critical-level issues (malware distribution, exposed secrets,
  prompt injection attacks). Treat public skills as untrusted dependencies.
  **High** (Snyk primary report).
  https://snyk.io/blog/toxicskills-malicious-ai-agent-skills-clawhub/
- **Praxen** (open-source, June 24, 2026): AI agent behavior verification tool
  using role-based authorization model; assigns agents authorized roles and
  verifies controls hold them to spec. Maturity unassessed — too new for primer.
  **High** (Help Net Security + open-source repo).
  https://www.helpnetsecurity.com/2026/06/24/praxen-open-source-ai-agent-behavior-verification/

## Guardrails & cost

- **Anthropic Claude Enterprise spend controls** (Jul 2, 2026): model-level
  entitlements, spend-threshold alerts at 75%/90% of an org's limit, per-user/
  per-group cost analytics dashboard, Admin API endpoints for scripting
  cost-control workflows (auto-flagging users near limits, reviewing increase
  requests). First Anthropic-native building block toward a product-level
  budget ceiling, complementing the harness-level ceiling in primer §6. —
  **Medium-High** (Anthropic's own blog corroborated by two independent
  secondaries; primary blog direct-fetch 403'd).
  https://claude.com/blog/giving-admins-more-visibility-and-control-over-claude-usage-and-spend ·
  https://www.techtimes.com/articles/319687/20260704/claude-enterprise-spend-controls-arrive-agentic-ai-bills-blow-past-budgets.htm ·
  https://campustechnology.com/articles/2026/07/02/anthropic-expands-enterprise-deployment-options-for-claude-desktop.aspx
- **Gartner: $234B enterprise app spend "at risk" from agentic AI by 2030**
  (Jul 1, 2026 press release) — ~20% of enterprise application SaaS spend
  exposed to "agentic arbitrage" as agents complete cross-system tasks without
  a human touching the underlying app. — **Medium** (title/date confirmed via
  search; primary Gartner newsroom page 403'd).
  https://www.gartner.com/en/newsroom/press-releases/2026-07-01-gartner-says-us-dollars-234-billion-in-enterprise-application-software-spend-is-at-risk-from-agentic-artificial-intelligence
- Anthropic Agent SDK guardrail params — **High**.
  https://code.claude.com/docs/en/agent-sdk/agent-loop
- AgentGuard (budget/loop/timeout guards) — **High** (README read).
  https://github.com/bmdhodl/agent47
- Uber $1,500/mo per-tool cap, annual budget gone in ~4 months — **High** (multi-outlet).
  https://techcrunch.com/2026/06/02/uber-caps-employee-ai-spending-after-blowing-through-budget-in-four-months/
- Gartner ">40% of agentic AI projects canceled by 2027" — **High** (press release).
  https://www.gartner.com/en/newsroom/press-releases/2025-06-25-gartner-predicts-over-40-percent-of-agentic-ai-projects-will-be-canceled-by-end-of-2027
- Anthropic billing split (announced May 13, 2026; **paused June 15, 2026** on
  the effective date): programmatic entry points (Agent SDK, `claude -p`, GH
  Actions) were to move to a separate metered credit pool at API list prices;
  Anthropic reversed course on Jun 15 — billing remains on existing subscription
  limits until further notice. Original plan: Pro ~$20/mo, Max 5× ~$100/mo,
  Max 20× ~$200/mo, Team/Enterprise ~$100–$200/seat; 12–175× effective price
  increase for heavy programmatic users. Pause attributed to OpenAI price-war
  pressure and IPO timing. — Pause: **High** (consistent across multiple outlets).
  Original plan: **High** (Anthropic Help Center; canonical gist; 15+ outlets).
  Pause: https://thenewstack.io/anthropic-pauses-claude-agent-sdk-subscription-change/ ·
  https://the-decoder.com/anthropic-backs-off-unpopular-billing-overhaul-as-price-war-with-openai-looms/ ·
  https://aiweekly.co/alerts/anthropic-halts-claude-agent-sdk-billing-plan
  Original plan: https://support.claude.com/en/articles/15036540-use-the-claude-agent-sdk-with-your-claude-plan ·
  https://gist.github.com/MagnaCapax/d9177e35b355853f03c730dfcaa693ef ·
  https://www.axios.com/2026/05/14/anthropic-claude-price-openai-tokens
- **Microsoft** cancels Claude Code licenses in Experiences & Devices division
  (effective June 30, 2026): per-engineer costs reached $500–$2,000/month with
  84–95% adoption; engineers redirected to GitHub Copilot CLI. — **Medium**
  (multiple tech outlets; primary Microsoft announcement not directly read).
  https://cybernews.com/ai-news/microsoft-claude-code-burn-yearly-ai-budget/ ·
  https://thenextweb.com/news/microsoft-claude-code-retreat-ai-cost ·
  https://aiweekly.co/alerts/microsoft-drops-claude-code-after-budget-overrun
- **Databricks Unity AI Gateway hard spend caps** (announced Data+AI Summit,
  June 15–18, 2026): enforcement stops requests when budget reached (not just
  alerts); granular controls by user/team/tool/use-case. — **Medium-High**
  (Databricks blog confirmed via search; direct fetch 403'd).
  https://www.databricks.com/blog/ai-governance-data-ai-summit-2026-whats-new-unity-ai-gateway
- GitHub Copilot token-based billing (eff. Jun 1, 2026): reported costs jumping
  from $29/mo to $750/mo for heavy agentic use patterns. — **High** (GitHub
  official blog + TechCrunch).
  https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/ ·
  https://techcrunch.com/2026/05/30/what-a-joke-github-copilots-new-token-based-billing-spurs-consternation-among-devs/
- Goldman Sachs "Decoding the Agentic Economy" (May 8, 2026): projects 24× token
  demand increase by 2030 as agentic workflows dominate. — **High** (Goldman
  Sachs primary).
  https://www.goldmansachs.com/insights/articles/ai-agents-forecast-to-boost-tech-cash-flow-as-usage-soars
- TechCrunch runaway-cost roundup (Jun 5, 2026): $6,000 overnight run, $2,847
  four-hour runaway, $4,200 long-weekend refactor — self-reported anecdotes. —
  **Medium** (TechCrunch primary; individual figures self-reported).
  https://techcrunch.com/2026/06/05/the-token-bill-comes-due-inside-the-industry-scramble-to-manage-ais-runaway-costs/
- Anthropic Rate Limits API (Apr 25, 2026): programmatic read access to org/
  workspace rate limits; enables gateways and spend-alert integrations — a hook
  for building the §6 budget ceiling. — **High** (primary Anthropic docs).
  https://platform.claude.com/docs/en/manage-claude/rate-limits-api
- Anthropic Claude Code Analytics Admin API (Mar 2026): per-user estimated costs,
  productivity metrics, multi-model cost breakdowns. — **High** (primary docs).
  https://docs.anthropic.com/en/api/claude-code-analytics-api
- Gartner governance press release (May 26, 2026): 40% of enterprises will
  demote/decommission production agents by end of 2027 due to governance gaps
  found post-deployment; "FinOps for agentic AI" added to the Hype Cycle;
  guardian agents (agents monitoring other agents for scope drift/hallucination)
  projected at 10–15% of the agentic-AI market by 2030. — **High** (Gartner
  newsroom canonical URL; direct fetch 403'd, confirmed across multiple
  independent secondaries).
  https://www.gartner.com/en/newsroom/press-releases/2026-05-26-gartner-says-applying-uniform-governance-across-ai-agents-will-lead-to-enterprise-ai-agent-failure

## Ecosystem (newer than the seed)

- Geoffrey Huntley — **Loom** ("factory" orchestrator of ralph loops). Repo is
  experimental/proprietary and described more modestly than the talk framing —
  **Medium/Low** (gap between marketing and README).
  https://github.com/ghuntley/loom · talk: AI Engineer Melbourne, Jun 3–4 2026.
- "Loop Engineering" — term popularized by Addy Osmani, crediting Steinberger +
  Cherny — **Medium** (primary Substack 403'd; concept is derivative of KB).
  https://addyo.substack.com/p/loop-engineering
- **Loop Engineering Orange Book** (alchaincyf/loop-engineering-orange-book,
  v260615, June 15, 2026): free bilingual (Chinese/English) guide covering loop
  anatomy, five core moves, six components, cost considerations. MIT licensed.
  — **High** (GitHub repo fetched directly). https://github.com/alchaincyf/loop-engineering-orange-book
- **LangChain "The Art of Loop Engineering"** (langchain.com blog, June 16,
  2026): synthesizes Osmani's framework into LangGraph primitives; introduces
  stacked loops (agent, verification, application, hill-climbing). — **Medium**
  (confirmed via search snippet + date; direct fetch 403'd).
  https://www.langchain.com/blog/the-art-of-loop-engineering
- Steinberger tweet (June 18, 2026): practical demo of a maintainer-orchestrator
  loop — Codex polling stale PRs on 5-min wake cycles using orchestrator +
  triage + autoreview + computer-use skills; some work landing autonomously. —
  **Medium** (corroborated by two aggregators; primary X page 403'd).
  https://x.com/steipete · aggregator: https://digg.com/tech/wps0fl4e

## Verification & skills (academic)

- "Agent Skill Evaluation and Evolution: Frameworks and Benchmarks" —
  arXiv:2606.11435, submitted June 9, 2026. Four paradigms: execution feedback,
  trajectory distillation, compression, RL. — **High** (arXiv page confirmed).
  https://arxiv.org/abs/2606.11435
- "Bayesian-Agent: Posterior-Guided Skill Evolution" — arXiv:2606.08348,
  submitted June 6, 2026. Skills as hypotheses; feature-conditioned categorical
  posterior. — **High** (arXiv page confirmed). https://arxiv.org/abs/2606.08348
- "SkillHone: Continual Agent Skill Evolution Through Persistent Decision History"
  — arXiv:2606.08671, submitted June 7, 2026. Addresses loss of decision history
  across skill revisions. — **High** (arXiv HTML page read).
  https://arxiv.org/html/2606.08671

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
- **June 15 2026 billing split** — original plan promoted to High; the plan was
  paused on its effective date (Jun 15). Pause itself is High (multiple outlets).
  No primary Anthropic announcement of the pause (email to subscribers only).
  Re-check when Anthropic announces a revised plan — the credit-pool structure
  may land with different terms.
- **Microsoft dropping Claude Code** — multiple tech outlets consistent, but no
  primary Microsoft announcement directly read. Re-verify if details matter.
- **Huntley's Loom** as an "orchestrator of ralph loops" — self-described in
  talk/tweets; the public README is more modest. Re-check as it matures.
- Steinberger / Osmani "Loop Engineering" verbatim — primary X/Substack URLs
  403'd; quotes are snippet-sourced.
- **Roborev creator confirmed**: Wes McKinney (@wesmckinn, author of Pandas).
  Previous KB said Dan Kornas (a content creator, not the author). Corrected.
- **Fable 5 / Mythos 5 suspension resolved**: suspension (Jun 12–13) was
  short-lived; platform docs show both models available as of Jun 22. Opus 4.1
  deprecation (retiring Aug 5, 2026) confirmed via docs.
- **Dynamic Workflows Pro-plan GA** (~Jul 2, 2026) — secondary-source only, no
  primary changelog line found; re-verify against code.claude.com/docs/en/changelog
  or the whats-new digest once a Week 27 entry publishes.
- **AI Engineer World's Fair 2026** (Jun 29–Jul 2, San Francisco) sessions by
  Steve Yegge ("Harness Engineering" fireside w/ Guy Podjarny) and reportedly
  Addy Osmani (Day 3, on architecting autonomous-agent systems) — **Low/Medium**,
  no verbatim quotes recovered, aggregator-sourced only. Not promoted to primer;
  re-verify if a transcript or recording surfaces.
- **Cobus Greyling** ("HarnessX: When the Harness Starts Learning From Its Own
  Runs", Medium, reported Jul 2026) proposing harnesses as versioned artifacts
  that learn from execution traces — **Low-Medium**, existence corroborated by
  search but article not directly fetched, exact date unconfirmed. Not promoted;
  re-verify before citing.
- **Gas City v1.3.3 hotfix** (Jul 2, 2026) and **LangGraph 1.2.7** (Jun 30,
  2026) — routine maintenance releases, not new orchestration techniques; not
  promoted to primer.
