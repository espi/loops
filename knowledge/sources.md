# Sources

Curated, deduplicated source list for the loops knowledge base. Confidence
reflects how the claim was verified: **High** = primary source read directly or
identical verbatim across multiple independent sources; **Medium** = consistent
across several secondary sources but primary not directly confirmed; **Low** =
single source / unverified provenance.

Verified as of 2026-07-27. Re-check before relying on version numbers or dates.

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
- **Gas City 1.3** ("Now We're Looping With Gas," blog.gascity.com, early July
  2026) — reportedly convoy/drain control-flow primitives, Mayor
  reimplemented as a configurable skill, JSON output across the `gc` CLI.
  **Human-verified 2026-07-20**: URL confirmed real by a repo maintainer
  visiting it directly (automated WebFetch still returns 403 on both the
  post and the blog root). Post/release existence: **High** (human-verified).
  Specific feature list (convoys/drain/etc.): **Medium** (secondary-sourced
  only — the post body itself has never been independently read). Note: this
  was mislabeled "Formulas 2.0" in the 2026-07-13 pass — that was a
  secondary-source guess; the confirmed title is "Gas City 1.3."
  https://blog.gascity.com/posts/gas-city-1-3-now-were-looping-with-gas/
- Steve Yegge — "The Flat Curve Society" (Medium, ~June 19, 2026): model
  capability plateau, AI adoption culture; *"supervised agentic flows"* as the
  key enterprise shift. Peripheral to loop patterns but relevant macro context.
  — **Medium** (date confirmed "3 days ago" from Jun 22 in two independent
  search sets; Medium 403'd; quotes from search extracts).
  https://steve-yegge.medium.com/the-flat-curve-society-36c8b01eb33b ·
  https://x.com/Steve_Yegge/status/2067816148775956952
- Boris Cherny "Steps of AI Adoption" (~Jul 16–17, 2026) — five-level maturity
  framework (Gated → Assisted → Parallel → Supervised autonomy → AI-native);
  quote on 10x'ing output while orgs lag. — **High** (verbatim X post confirmed;
  secondary explainer consistent).
  https://x.com/bcherny/status/2077929379661844559 ·
  https://www.explainx.ai/blog/boris-cherny-steps-ai-adoption-claude-code-july-2026
- Addy Osmani "Own the Outer Loop" (Substack/Elevate, Jul 9, 2026; reportedly
  the written version of his AI Engineer World's Fair 2026 closing keynote) —
  follow-on to "Loop Engineering" and "Agentic Autonomy Levels" (Jul 3); inner
  loop (agent: investigate/implement/test/report) vs. outer loop (engineer:
  verdict/verify/responsibility); three over-delegation costs (cognitive
  surrender, cognitive debt, orchestration tax); cites 96% of engineers don't
  fully trust AI-written code and only 48% always verify before committing,
  plus Sonar's 2026 State of Code report (42% AI-generated/assisted code) and
  GitLab's June 2026 AI-accountability research. — **Medium-High** (primary
  403'd; corroborated by daily.dev repost + two independent AlphaSignal AI
  posts with matching detail).
  https://addyo.substack.com/p/own-the-outer-loop ·
  https://addyosmani.com/blog/own-the-outer-loop/ ·
  https://daily.dev/posts/own-the-outer-loop-yabisltr3
- Peter Steinberger tweet (Jul 18, 2026): "Are we still talking loops or did we
  shift to graphs yet?" — teaser, possibly signaling a "graph engineering"
  framing shift; not independently corroborated as a real trend yet (see
  re-verify list). Followed ~Jul 25 by a one-line "am I a graph engineer now"
  post — still no long-form essay. — **Medium** (search-snippet sourced; direct
  fetch 402/403'd). https://x.com/steipete/status/2078277297791189132
- **Addy Osmani "Software Factories, Light and Dark"** (Substack, July 22,
  2026) — follow-on to "Own the Outer Loop"; a software factory is "harnessing
  loops at scale," oversight calibrated per task by verification cost and
  consequence. Verbatim: *"Back pressure is the rule that you can only hand a
  loop as much autonomy as you can cheaply and reliably verify, and not one inch
  more"* (reuses Geoffrey Huntley's Jan-2026 "back pressure" term,
  ghuntley.com/pressure/); *"A dark factory runs with the lights physically off,
  because the only things on the floor are machines and machines don't need
  light to see"*; names **"comprehension debt"** — *"the widening gap between how
  much code exists and how much any human still understands."* Maps directly to
  this repo's verification-gated-autonomy non-negotiables. — **High** (primary
  Substack fetched directly, verbatim quotes, date confirmed).
  https://addyo.substack.com/p/software-factories-light-and-dark
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

- **Anthropic "Loop engineering: Getting started with loops"** (claude.com/blog,
  Jul 7, 2026; Delba de Oliveira, Michael Segner) — Anthropic's own definitional
  post on the pattern. **Medium** (primary URL 403'd; consistent secondary
  reporting from explainx.ai, mer.vin, Claude Directory).
  https://claude.com/blog/getting-started-with-loops
  **Human-verified 2026-07-20**: `/schedule` itself is real — confirmed
  directly against the primary docs page. It's the CLI alias for creating a
  **Routine** (also aliased `/routines`), not a separate fourth loop type as
  the secondary sources framed it; a routine supports three trigger types
  (Schedule/API/GitHub event). **High** for `/schedule`'s existence and
  mechanics (code.claude.com/docs/en/routines read directly); the blog post's
  own framing, author byline, and view-count claim remain unconfirmed at
  **Medium** (primary blog itself still 403's).
  https://code.claude.com/docs/en/routines#schedule

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
- **Claude Code changelog** (primary; v2.1.170–215, Jun 9–Jul 19, 2026) — **High**.
  https://code.claude.com/docs/en/changelog ·
  https://github.com/anthropics/claude-code/releases
  July window (v2.1.202–215) key changes: v2.1.202 (Jul 6) — Dynamic Workflows
  "size" config knob, `workflow.run_id`/`workflow.name` OTel attributes;
  v2.1.205 (Jul 8) — `/doctor` becomes full setup checkup, `/checkup` alias;
  v2.1.207 (Jul 11) — Opus 4.8 default on Bedrock/Vertex/Foundry, auto mode
  opt-in removed on those platforms; v2.1.208 (Jul 14) — `--ax-screen-reader`
  accessibility mode, `vimInsertModeRemaps`, `CLAUDE_CODE_PROCESS_WRAPPER`;
  v2.1.211 (Jul 15) — `--forward-subagent-text`; v2.1.212 (Jul 17) — WebSearch
  cap (200/session), subagent-spawn cap (200/session, `/clear`-reset), MCP
  calls >2min auto-background, `/fork`→background session (`/subtask` takes
  over old in-session behavior), Task tool `mode` param deprecated (subagents
  inherit parent permission mode); v2.1.214 (Jul 18) — `EndConversation` tool,
  ~58 security fixes (Windows PowerShell 5.1 permission bypass, Bash
  permission-analyzer bypasses); v2.1.215 (Jul 19) — `/verify` and
  `/code-review` no longer auto-invoked, require explicit call.
  Opus 4.8 release date (May 28, 2026, not new this window): **Medium**
  (anthropic.com/news, not re-fetched this pass) — https://www.anthropic.com/news/claude-opus-4-8
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
  mid-conversation system role for harness reminders; **v2.1.202 (Jul 6)** —
  "Dynamic workflow size" `/config` setting (advisory cap, not enforced —
  a prompt calling for larger scale overrides it); **v2.1.203 (Jul 7)** —
  "Large workflow" warning at >25 agents or >1.5M projected tokens, surfaced
  in `/workflows` only, does not pause/limit the run; **v2.1.205 (Jul 8)** —
  auto mode blocks tampering with session transcript files and asks before
  `rm -rf` on an unresolvable variable, `/doctor` becomes a full fix-capable
  checkup (was read-only), `/checkup` added as alias; **v2.1.206 (Jul 9)** —
  `/doctor` gained a check proposing trims to checked-in `CLAUDE.md` content
  derivable from the codebase; **v2.1.207 (Jul 11)** — auto mode on by
  default without opt-in on Bedrock/Vertex/Foundry (was opt-in via
  `CLAUDE_CODE_ENABLE_AUTO_MODE`, now disable via `disableAutoMode`),
  Agent Teams crash-loop fix (malformed teammate mailbox message), default
  model on Bedrock/Vertex/Foundry changed to Opus 4.8 (subscription default
  unchanged, still Sonnet 5). Source for this batch: Week 28 digest.
  https://code.claude.com/docs/en/whats-new/2026-w28
- **Dynamic Workflows GA — confirmed** (confidence upgraded Medium → High,
  2026-07-13): primary docs page confirms GA on all paid plans
  (Pro/Max/Team/Enterprise) plus API and Bedrock/Vertex/Foundry, requiring
  v2.1.154+. Correction: on Pro it is off by default and requires manual
  enablement via the "Dynamic workflows" row in `/config` — not an automatic
  Pro-wide turn-on as earlier secondary coverage implied. **High** (primary
  docs). https://code.claude.com/docs/en/workflows
- **Fable 5 metered-billing deadline moved twice** (Jul 7–13, 2026): included-
  subscription access to Fable 5 was slated to end Jul 7, 2026 (metered
  billing $10/$50 per MTok I/O to begin); after pushback Anthropic extended
  included access to Jul 12, then again on Jul 13 to **Jul 19, 2026**. Track
  as a moving date, not settled. **Medium-High** (Anthropic's own "Redeploying
  Fable 5" post, corroborated by Digital Applied's pricing-guide coverage).
  https://www.anthropic.com/news/redeploying-fable-5 ·
  https://www.digitalapplied.com/blog/claude-fable-5-usage-credits-july-7-pricing-guide-2026
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
  v0.62.0 (Jul 11, 2026): new cancellation command; **now requires explicit
  user request before Codex/Claude Code can invoke roborev skills** (tightens
  auto-invocation — parallels Claude Code's own v2.1.215 move away from
  self-triggered review skills); honors env-var config paths; documents Gemini
  ACP settings; prevents workflow model leakage into agents.
  v0.62.1 (Jul 14, 2026): persistent CI panel metrics + new export command;
  stable JSON contract for version info; Codex agent hook can invoke
  `roborev-fix` skill; blocks incompatible model pairings.
- **Claude Code v2.1.216–220 (Jul 20–25, 2026)** — **High** (changelog read
  directly; `whats-new/2026-w30` not yet published, changelog was sole primary).
  v2.1.216 (Jul 20): `sandbox.filesystem.disabled`; workflow/scheduled-task
  writes no longer follow a symlink at `.claude`. v2.1.217 (Jul 21):
  `--max-budget-usd` now **halts background subagents** (denies new spawns,
  stops running ones) at the cap; new **concurrent-subagent cap default 20**
  (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`); subagents no longer spawn nested
  subagents by default. v2.1.218 (Jul 22): several auto-mode checks
  (dangerous-`rm`, background-`&`, suspicious Windows paths, un-provable
  read-only Bash in plan mode) moved from permission dialogs to the auto-mode
  classifier; skills with `context: fork` run in background by default;
  `/deep-research` + `/code-review` run as background subagents; `/code-review`
  no longer auto-launches. v2.1.219 (Jul 24): **subagent nesting defaults to
  depth 3** (was 1; `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH=1` to disable — note
  the default flipped twice inside the week); Dynamic Workflows default to a
  "medium" size guideline (~<15 agents) via `workflowSizeGuideline`;
  `sandbox.network.strictAllowlist`; `DirectoryAdded` hook; Opus 5 added (below).
  v2.1.220 (Jul 25): reliability fixes only.
  https://code.claude.com/docs/en/changelog
- **Claude Opus 5** (`claude-opus-5`) shipped v2.1.219 (Jul 24, 2026) as the
  **default Opus model** — 1M context, 128k output, $5/$25 per MTok I/O
  (unchanged from Opus 4.8), fast mode $10/$50 (~2.5× faster), new `xhigh`
  reasoning tier; `/fast` covers Opus 5 + Opus 4.8, Opus 4.7 removed from fast
  mode. — **High** (changelog + secondaries).
  https://code.claude.com/docs/en/changelog ·
  https://www.marktechpost.com/2026/07/24/meet-the-new-claude-opus-5-frontier-class-agentic-coding-and-computer-use-at-unchanged-opus-pricing/
- **Fable 5 metered billing went live July 20, 2026 as planned** (resolving the
  Jul 7→12→19 slips): Max & Team Premium keep Fable 5 included up to 50% of the
  weekly usage limit (stated permanent); Pro & Team Standard move to usage
  credits at $10/$50 per MTok I/O (2× Opus 4.8), one-time $100 credit claimable
  Jul 20–Aug 2. — **High** (v2.1.219 changelog fixed the Fable plan-labeling,
  corroborating live rollout; multiple secondaries).
  https://fable5.app/fable-5-usage-limits/ ·
  https://usagebox.com/articles/claude-fable-5-usage-credits-switch-july-2026
  v0.63.0 (Jul 16, 2026): CI quiet-hours throttling (with bypass for certain
  workloads); machine-readable launch receipts on `roborev run` for
  automation; tightened skill triggers to prevent unintended activation.
  https://github.com/roborev-dev/roborev/releases · https://www.roborev.io/
  (v0.62.x–v0.63.0: **High** primary GitHub releases read directly; not
  independently cross-checked against roborev.io/changelog, which 403'd.)
- **Microsoft Agent Skills for .NET reaches stable/GA** (July 7, 2026) — exited
  experimental preview in Microsoft Agent Framework; `[Experimental]` attribute
  removed. Same SKILL.md-based open format as Anthropic's Agent Skills
  standard, now with a first-party .NET implementation. **High** (Microsoft
  dev blog, corroborated).
  https://devblogs.microsoft.com/agent-framework/agent-skills-for-net-is-now-released/ ·
  https://www.dotnetramblings.com/post/07_07_2026/07_07_2026_19/
- "EvoAgentBench: Benchmarking Agent Self-Evolution via Ability Transfer" —
  arXiv:2607.05202, ~Jul 6, 2026. Extracts trace-grounded "Abilities" from
  agent executions into domain-specific Ability Graphs; shows curated ability
  content transfers across model families. Extends the skill-evolution academic
  line below. **Medium** (arXiv fetch 403'd; date inferred from ID + search
  snippet). https://arxiv.org/abs/2607.05202
- **SkillCheck** (getskillcheck.com) — third-party Agent Skills validator;
  v3.26/v3.27 (Jul 2026) added reference-aware composability/observability
  checks and "anti-slop" cluster-mining checks (AI-vocabulary escalation,
  cliché detection) against the Agent Skills open standard. **Medium**
  (search-summary sourced only, not directly fetched; too new/thin to promote
  to primer). https://www.getskillcheck.com/
- Addy Osmani "Agentic Autonomy Levels" (Substack, Jul 3, 2026) — follow-on to
  "Agentic Code Review": autonomy granted to an agent should be earned by
  accumulated verification evidence, not asserted by a task label; names
  "autonomy as status" as an anti-pattern. — **Medium** (search-snippet
  corroborated; primary Substack fetch blocked/paywall-adjacent).
  https://addyo.substack.com/p/agentic-autonomy-levels

- **"Friendly Fire" exploit disclosure** (AI Now Institute, Boyan Milanov &
  Heidy Khlaaf, Jul 8, 2026): PoC shows Claude Code (Sonnet 4.6/5, Opus 4.8)
  in auto-mode and OpenAI Codex CLI (GPT-5.5) in auto-review can be hijacked
  into RCE by asking either agent to review an untrusted third-party repo —
  prompt injections hidden in ordinary source/doc files (no hooks/skills/
  MCP/config required) steer the agent into running attacker-controlled code
  during what looks like a security review. No in-the-wild exploitation
  reported; released PoC has payload stripped. Directly undercuts "have an
  agent review it" as a sufficient verification step — the reviewer becomes
  the attack path. **High** (multiple independent outlets corroborate; primary
  is the AI Now Institute brief).
  https://ainowinstitute.org/publications/friendly-fire-exploit-brief
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

- **Tesla caps employee AI tool spending at $200/week** (approval required
  above that; beta xAI/Grok products explicitly exempt), effective July 6,
  2026 — third named company (with Uber, Microsoft) enforcing a hard
  per-person spend ceiling. **High** (multiple corroborating outlets).
  https://electrek.co/2026/07/02/tesla-caps-employee-ai-spending-200-week/ ·
  https://www.investing.com/news/stock-market-news/tesla-sets-200-weekly-cap-on-staff-ai-spending-starting-july-6--information-93CH-4773971
- **GitHub Copilot cost centers** (rollout continuing Jul 1–9, 2026): now
  support capped/shared AI credit pools and per-session spend limits for
  Copilot agent/CLI runs. **Medium** (GitHub changelog + Tech Times coverage;
  exact day within window imprecise).
  https://github.blog/changelog/2026-07-02-cost-centers-now-support-included-usage-caps/ ·
  https://www.techtimes.com/articles/319988/20260709/github-copilot-breaks-agent-barrier-free-desktop-app-jetbrains-cost-controls.htm
- **OpenAI Codex rollout token budgets** (Jul 2026 release): configurable
  per-rollout token budgets (turn aborts on exhaustion, remaining-budget
  reminders) plus multi-agent delegation controls
  (disabled/explicit/proactive). **Medium** (changelog-confirmed; exact date
  within window imprecise). https://releasebot.io/updates/openai/codex
- **"The Harness Effect: How Orchestration Design Sets the Token Economics of
  Enterprise Agentic AI"** (arXiv:2607.06906, ~Jul 6, 2026): controlled
  six-model experiment — optimized orchestration harness cuts blended
  cost/task 41% ($0.21→$0.12), wall-clock 44%, tokens/task 38%, raises
  quality-per-dollar 82%; efficiency gains model-invariant, quality gains
  scale with underlying model strength. **Medium-High** (primary arXiv
  abstract page identified; full-text fetch 403'd, relying on abstract +
  search-engine summary). https://arxiv.org/abs/2607.06906
- **Ramp AI Token Spend Management** (Jul 16, 2026): cross-provider
  (OpenAI/Anthropic/Gemini) token/subscription cost dashboard, weekly usage
  briefings, invoice reconciliation, real-time overrun alerts; reports 20.7×
  growth in AI token spend across Ramp's customer base since June 2025. New
  entrant in the budget-observability-tool category. **High** (PR Newswire,
  SiliconANGLE, Ramp's own blog, consistent).
  https://www.prnewswire.com/news-releases/ramp-launches-ai-token-spend-controls-302827389.html ·
  https://siliconangle.com/2026/07/16/ramp-targets-ais-fastest-growing-cost-expanded-token-spend-tracking/ ·
  https://ramp.com/blog/ai-token-spend-launch
- **OpenAI "Managing AI investments in the agentic era"** (Jul 14, 2026):
  enterprise cost-governance guidance — token-price drops don't equal cheaper
  outcomes; five steps (usage visibility, outcome-based model evaluation,
  governance of agentic/connector access, funding compounding workflows,
  matching capacity to proven demand). Competitor/industry context, not an
  Anthropic or Claude Code change. **High** (primary OpenAI page read).
  https://openai.com/index/managing-ai-investments-in-agentic-era/
- **Anthropic Agent SDK billing split — still paused, no revised plan found**
  as of Jul 27, 2026. No primary Anthropic announcement located in the Jul
  6–27 window revising the pause from June 15. The recurring search-sourced
  claim that the split "went live July 10, 2026" **surfaced again this pass**
  (one research agent reported it at Medium via a single secondary,
  thenewstack.io/anthropic-agent-sdk-credits) and was **again rejected**: a
  second agent independently confirmed "still paused" at High
  (thenewstack.io/anthropic-pauses-...), and the last pass had already flagged
  the "went live" framing as unverified and likely erroneous. **Do not treat as
  fact.** This is a textbook primer §5A "don't trust search snippets" case —
  two passes, two independent contradictions. Status:
  paused-with-no-revision-announced remains **Medium** (absence of evidence,
  not evidence of absence). Re-check when Anthropic announces a revised plan.
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

## Alternative harnesses & cross-tool landscape (mid-2026 survey)

Added 2026-07-20 from a 3-agent survey (CLI harnesses / orchestration platforms
/ portability). Feeds primer §4 "Beyond Claude Code" and §6 gateway enforcement.
**Most per-tool guardrail specifics are Medium** — vendor docs were often
thin/403'd; re-verify a specific flag against live docs before treating as High.

### Peer CLI harnesses
- **OpenAI Codex CLI** — `/goal` with persistent completion conditions and a
  real `budget-limited` stop state; completion is **self-judged** (no separate
  validator model like Claude's). MCP + AGENTS.md; no native scheduler. **High**
  (official) on `/goal`; **Medium** on budget-stop specifics.
  https://developers.openai.com/codex/use-cases/follow-goals ·
  https://github.com/openai/codex/issues/20536
- **Goose (Block)** — strongest guardrail story among CLI peers: `max_turns` /
  `GOOSE_MAX_TURNS` cap (**High**, official), a built-in **cron scheduler** for
  recurring unattended recipes (**High**, official), and a reported `--budget`
  dollar ceiling (**Low** — single secondary; verify).
  https://block.github.io/goose/docs/guides/recipes/recipe-reference/ ·
  https://deepwiki.com/block/goose/4.1.5-scheduler-and-recurring-tasks
- **Gemini CLI** — `maxSessionTurns` / `--max-turns` iteration cap (**High**,
  PR #3507); scheduling only via the separate `run-gemini-cli` GitHub Action, not
  the CLI. No hard $ ceiling / stall detector / separate validator.
  https://github.com/google-gemini/gemini-cli/pull/3507
- **opencode** (MIT) — headless `opencode serve` OpenAPI server enables async /
  remote / scheduled orchestration; JSON/MD-defined subagent pipelines
  (reviewer + sandboxed implementor). Best *substrate* to build a guarded loop
  on; no built-in budget/validator. **Medium** (secondary).
  https://byteiota.com/opencode-open-source-ai-coding-agent-guide-2026/
- **Cursor** — cloud **background agents** (laptop-closed, branch→PR) +
  **Automations** (scheduled + Slack/Linear/GitHub/webhook triggers, cross-run
  memory); agent loop iterates ~8× by default. No documented hard $ ceiling or
  separate validator. More sophisticated than a single CC session. **Medium**
  (secondary). https://byteiota.com/cursor-automations-always-on-ai-coding-agents-end-prompt-loop/
- **Amp** (Sourcegraph) — autonomous multi-step agent; **no documented**
  iteration cap / stall detector / budget ceiling (guidance is "keep threads
  short"). MCP. **Less** on guardrails. **Medium/Low** (secondary). **New Jul
  21, 2026**: shipped **self-scheduling** — an agent sets its own schedule and
  on firing "wakes up with its saved prompt and continues right where it left
  off, with all of its context and history." Published page documents **no
  re-wake-frequency cap** — a self-perpetuating loop shipping *without* the
  three hard stops; the ceiling is the operator's to add. Also new: Puck
  meta-agent, Slack "summon Amp." — **High** feature / **Medium** cap-absence
  (absence in docs ≠ confirmed absent). https://ampcode.com/news/schedule
- **Aider** — bounded ~3× self-correction retry + `--auto-test` (real test in
  loop); no goal primitive, scheduler, or budget ceiling. A retry helper, not an
  autonomous loop harness. **Medium**.
- **Cline / Roo Code** — IDE-embedded; `allowedMaxRequests` caps consecutive
  auto-approved calls then pauses (an iteration cap, not a goal primitive); no
  scheduler / hard $ / validator. **High** on the cap (official Roo docs).
  https://docs.roocode.com/advanced-usage/rate-limits-costs

### Orchestration platforms
- **Claude Agent SDK** — real enforcement: `max_turns` + `max_budget_usd` **both
  default to "No limit"** but halt with `error_max_turns` / `error_max_budget_usd`
  when set (reinforces this repo's "explicitly set a ceiling" rule — the SDK
  ships the mechanism, not a default cap); worktree-isolated subagents;
  resumable/forkable sessions with pluggable `session_store`. **High** (primary).
  https://code.claude.com/docs/en/agent-sdk/agent-loop
- **OpenHands** (ex-OpenDevin, ~70k★) — `AgentDelegateAction` hand-off;
  `MAX_ITERATIONS` (~100) + a hard accumulated-cost cutoff that aborts. **more**
  on delegation + cost caps. **Medium**. https://github.com/All-Hands-AI/OpenHands
- **Devin** (Cognition) — Managed Devins: coordinator decomposes → child
  sessions in isolated VMs; playbooks; durable managed loop-of-loops. Guardrail
  specifics opaque (product). **Medium / Low** on ceilings.
  https://docs.devin.ai/release-notes/2026
- **Factory (Droid)** — coordinator → specialized droids; Missions;
  `--worktree` conflict-free parallel `droid exec`; managed model routing.
  Enterprise-scale parallelism, **more** sophisticated. **Medium**.
  https://theaiagentindex.com/agents/factory-ai
- **LangGraph / Google ADK / CrewAI / AG2** — framework substrates (you build
  the loop). **Key caveat (High):** their "durable execution" is *recovery
  checkpoints, not crash-surviving execution* — a dead process kills the run
  without Temporal/Diagrid/hosted platform. CrewAI guardrails are opt-in
  (`max_iter` default 15, no default $ ceiling — a $2,400 runaway is the
  cautionary tale). `microsoft/autogen` is **maintenance-mode**; use **AG2** or
  **Microsoft Agent Framework 1.0** (Apr 3 2026).
  https://www.diagrid.io/blog/checkpoints-are-not-durable-execution-why-langgraph-crewai-google-adk-and-others-fall-short-for-production-agent-workflows ·
  https://learn.microsoft.com/en-us/agent-framework/migration-guide/from-autogen/

### Cross-tool standards & portability
- **MCP** — de-facto cross-tool standard for tool/context access (OpenAI,
  Google, Microsoft, Anthropic; an AAIF project; 5,800+ servers). The
  **2026-07-28 release candidate** (largest revision since launch) finalized at
  this window's edge: stateless core, a first-class **Tasks** extension for
  long-running async work (directly relevant to *bounded* long-running loop
  work), **MCP Apps** (server-rendered UI over the same JSON-RPC consent path),
  OAuth/OIDC-aligned auth, and a formal 12-month deprecation policy; beta SDKs
  for the RC shipped in-window. Standardizes *tool access, not the loop
  harness*. **High** (primary release-candidate post + secondaries).
  https://blog.modelcontextprotocol.io/posts/2026-07-28-release-candidate/ ·
  https://blog.modelcontextprotocol.io/posts/2026-mcp-roadmap/
- **Codex `/goal` = cross-tool validator-judge pattern** — same architecture as
  Claude Code `/goal` (distinct judge, evidence-based stop). Confirms the
  validator-model stop is an industry pattern, not a Claude feature. **High**.
  https://developers.openai.com/cookbook/examples/codex/using_goals_in_codex
- **Osmani "Loop Engineering" is explicitly tool-agnostic** — layered model
  (prompt → context → harness → loop), "Claude Code and Codex have landed on
  very similar primitives, so the loop shape is becoming tool-agnostic." **High**.
  https://addyosmani.com/blog/loop-engineering/

### Tool-agnostic guardrail / budget enforcement (feeds primer §6)
- **LiteLLM** — gateway: per-session iteration cap + `max_budget_per_session`,
  429 `budget_exceeded`, `fail_closed_budget_enforcement: true` for a true
  ceiling. **High** (docs, though page 403'd to fetcher — search-summary
  confirmed). https://docs.litellm.ai/docs/a2a_iteration_budgets
- **OpenRouter** — gateway: rejects over-limit requests (HTTP 402) on
  daily/weekly/monthly windows. **High**.
  https://openrouter.ai/docs/guides/features/guardrails
- **LoopGain** (`loopgain-ai/loopgain`) — convergence-based early stop +
  rollback; adapters for LangGraph, CrewAI, AutoGen, OpenAI Agents, **Claude
  Agent SDK**. **Medium**. https://github.com/loopgain-ai/loopgain
  (AgentGuard already tracked under Guardrails & cost.)

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
- GitHub Copilot CLI 1.0.70 (Jul 9, 2026): adds support for OpenAI's GPT-5.6
  model family (Sol/Terra/Luna variants) across Copilot surfaces including
  agent/coding-agent mode — expands model choice for Copilot's autonomous
  coding agent, not a new loop pattern. **Medium** (search-aggregated from
  GitHub changelog/blog coverage; primary changelog not directly fetched).
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
- **"When Agents Do Not Stop: Uncovering Infinite Agentic Loops in LLM Agents"**
  — arXiv:2607.01641 (~Jul 1–2, 2026; **read this pass**, resolving the
  standing backlog item). Defines infinite agentic loops as unbounded
  repetition of model/tool/handoff calls when the feedback path isn't bounded;
  introduces **IAL-Scan**, a static analyzer building an "Agentic Loop
  Dependence Graph" to detect paths that repeatedly hit expensive ops without a
  bound — **91.9% precision across 6,549 repos**. Empirical support for this
  repo's max-iteration / stall-detection hard stops (primer §6). — **High**
  (abstract read directly). https://arxiv.org/abs/2607.01641
- **"SkillCoach: Self-Evolving Rubrics for Evaluating and Enhancing Agentic
  Skill-Use"** — arXiv:2607.01874 (submitted Jul 2, 2026; **read this pass**,
  resolving the standing backlog item). Derives skill-grounded *process* rubrics
  from real rollouts to evaluate skill selection/following/composition/
  reflection, catching failures outcome-only checks miss; keeps an external
  verifier as a separate signal — i.e. process rubrics *complement*, don't
  replace, a deterministic success check (consistent with primer §5A). — **High**
  (abstract read directly). https://arxiv.org/abs/2607.01874
- **"SkillCorpus: Consolidating and Evaluating the Open Skill Ecosystem for
  Real-World LLM Agents"** — arXiv:2607.15557 (v1 Jul 17, **v4 Jul 23, 2026,
  in-window**). Consolidates ~821K→96,401 curated skills across 16 categories +
  a retrieval stack; reports up to +7.5pp task gains. Relevant to the
  `SKILL.md` ecosystem/portability question. — **High** (abstract read
  directly). https://arxiv.org/abs/2607.15557
- "Recursive Self-Improvement in AI: From Bounded Self-Refinement to Autonomous
  Research Loops" — arXiv:2607.07663 (submitted Jul 8, 2026). Posits a
  **verification hierarchy** — formal verifiers (strongest) → … → self-assessment
  (weakest) — and shows demonstrated self-improvement strength *tracks* this
  hierarchy, with **self-confirming loops** as the failure mode when the ordering
  is violated. A citable primary source for this repo's "an agent never declares
  done on its own self-assessment" rule. — **High** (abstract read directly).
  https://arxiv.org/abs/2607.07663

## Known caveats / things to re-verify

This is a **live backlog**, not a permanent record: every `update-knowledge`
pass carries every open item below forward and re-checks it or asks a human
to. When an item resolves (confirmed, corrected, or determined not worth
tracking), move it to [`archive/resolved-caveats.md`](archive/resolved-caveats.md)
instead of deleting it or leaving it here indefinitely.

- **`SKILL.md` cross-tool *execution* is contested.** Two research passes
  disagreed: one found the Agent Skills format read by a broad cross-vendor set
  (Codex CLI, Gemini CLI, Cursor, VS Code, Goose, opencode…); the other found
  **no** surveyed CLI tool *confirmed to execute* a `SKILL.md`, with **`AGENTS.md`**
  being the actually-common file convention. The format is spreading but
  per-tool execution behavior (discovery, honored frontmatter, permissions)
  differs. Treat a skill authored here as portable-with-testing, not drop-in.
  Re-verify which tools truly run `SKILL.md` vs. only `AGENTS.md`.
- **Agent Skills governance status — converging toward "not AAIF-governed."**
  Earlier KB passes recorded Agent Skills as an AAIF / Linux Foundation-governed
  open standard; the 2026-07-20 survey and now **two independent 2026-07-27
  agents** all found the LF's Agentic AI Foundation names only **MCP /
  AGENTS.md / goose** as its projects — `SKILL.md` is Anthropic-authored,
  community-maintained (agentskills.io), *not* confirmed AAIF-governed. Primer
  §4 softened accordingly this pass. Still an open re-verify (no primary AAIF
  project list stating the negative was read), but the evidence is now
  one-directional. If it holds, `SKILL.md` portability rests on vendor goodwill,
  not a neutral standard.
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
- **"Graph engineering" as a successor term to "loop engineering"** — the meme
  is heating in secondaries but **still has no primary long-form definition** as
  of 2026-07-27. This pass found: Steinberger has published only tweets (Jul 18
  "did we shift to graphs yet?"; ~Jul 25 "am I a graph engineer now"), no essay;
  Hamel Husain's X Article "Loop Engineering Is Dead. Enter Graph Engineering"
  (Jul 18, pre-window) is an opinion piece, not a definition; **Turing Post
  FOD#159 "Is Graph Engineering Real?" (Jul 20, read directly, High)** argues
  the term spread with *no consensus definition* ("graph" used for control
  graphs, knowledge graphs, execution traces, and improvement loops
  interchangeably); Louis-François Bouchard (Towards AI, in-window) and others
  push back on the "loop engineering is dead" framing. Net: a **contested,
  undefined meme, not a defined successor discipline**. **Low.** Carry forward;
  promote to the lineage ladder (primer §2) only if a primary essay actually
  defines the term. https://www.turingpost.com/p/is-graph-engineering-real-why-everyone-is-talking-about-it
- **roborev.io/changelog** consistently 403's to automated fetch even as the
  GitHub releases page is readable — cross-check the two if a claim ever
  depends on changelog prose rather than release notes.
- **EvoAgentBench** (arXiv:2607.05202) and **SkillCheck** (getskillcheck.com)
  — too new/thin to promote to primer this pass; tracked above under
  Verification & skills.
- **"Loop Engineering Is Dead: Here's the Data Behind the AI Backlash"**
  (Medium, "AI Engineering Simplified," reported within the week of Jul
  6–13, 2026) — argues production failures are souring the loop-engineering
  hype that peaked mid-June. **Low-Medium** (opinion piece, no primary data
  cited per summary, exact publish date unconfirmed) — not promoted to
  primer; useful as an early signal of backlash if corroborated later.
  https://medium.com/ai-engineering-simplified/loop-engineering-is-dead-heres-the-data-behind-the-ai-backlash-6d1b204e4b9a
- **roborev repo identity** — search surfaced two repos described as
  "continuous background code review": `roborev-dev/roborev` (the one the KB
  tracks and reads directly) and `kenn-io/roborev`. Confirm which is canonical
  (possible fork/rename) before citing the other. **Low.** Added 2026-07-27.
- **GuardFall** — a claimed "universal shell-injection design flaw affecting
  >500k open-source deployments," attributed to July 2026, surfaced from a
  single aggregator (adversa.ai roundup) with no primary source or precise
  date. Verify against a primary before treating as real. **Low.** Added
  2026-07-27.
- **AgentGuard / LoopGain re-findability** — two research agents this pass
  could not re-locate AgentGuard (KB cites github.com/bmdhodl/agent47, High
  from README) or LoopGain (github.com/loopgain-ai/loopgain, Medium) via
  search. A search miss is not disproof, but confirm both repos still exist at
  the cited URLs next pass before relying on their flag names. Added 2026-07-27.
- **Gateway ownership changes** — Portkey was acquired by Palo Alto Networks
  (closed ~May 29, folding into Prisma AIRS) and Helicone by Mintlify (~March
  2026); both are cited in primer §6. Pre-window context, but re-verify the
  budget-enforcement flags still exist under new ownership before citing.
  **Medium.** Added 2026-07-27.
- **Subagent-nesting default flipped twice in one week** (v2.1.217 off →
  v2.1.219 depth-3, Jul 21–24) — re-verify the currently-shipped default before
  baking it into a template. Added 2026-07-27.
