# Sources

Curated, deduplicated source list for the loops knowledge base. Confidence
reflects how the claim was verified: **High** = primary source read directly or
identical verbatim across multiple independent sources; **Medium** = consistent
across several secondary sources but primary not directly confirmed; **Low** =
single source / unverified provenance.

Verified as of 2026-06-22. Re-check before relying on version numbers or dates.

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
- **Claude Code changelog** (primary; v2.1.170–185, Jun 9–20, 2026) — **High**.
  https://code.claude.com/docs/en/changelog
  Key loop-relevant changes: v2.1.172 — 5-level nested sub-agents; v2.1.174 —
  usage attribution breakdown in VS Code Account dialog; v2.1.176 — hook `if`
  path-pattern fix; v2.1.178 (Jun 15) — agent teams implicit, `Tool(param:value)`
  permission syntax, nested skills load from subdirs; v2.1.181 (Jun 17) —
  foreground subagents also capped at 5 levels, `/config key=value`,
  `CLAUDE_CLIENT_PRESENCE_FILE`; v2.1.183 (Jun 19) — auto mode blocks destructive
  git/IaC commands, `attribution.sessionUrl`; v2.1.185 (Jun 20) — stream-stall
  threshold raised to 20s.
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
- roborev (continuous per-commit review, **Wes McKinney** (@wesmckinn)) — **High**
  (GitHub releases read directly).
  v0.57.1 (Jun 9, 2026): Windows archive fixes, daemon route, TUI performance.
  v0.58.0 (Jun 11, 2026): Kata integration, branch filtering for hooks, queue
  pause/resume, **aggregate review cost tracking**, generated public daemon client.
  https://github.com/roborev-dev/roborev/releases · https://www.roborev.io/

## Guardrails & cost

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
