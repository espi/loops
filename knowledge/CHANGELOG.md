# Knowledge base changelog

Dated record of substantive changes to `knowledge/`. The `update-knowledge`
skill appends a new entry here on each research pass. Newest first.

## 2026-08-17 — Seven-day follow-up pass (Aug 10 – Aug 17)

Five parallel research agents across tooling & versions, ecosystem & techniques,
key voices, guardrails & cost, and verification & skills. A **modest but real
window**: a Claude Code guardrail/subagent release cluster, a strong new Osmani
essay, the first cross-vendor adoption of Agent Plugins 1.0, a roborev release,
and three in-window arXiv papers. No `update-knowledge` PR was open (checked
GitHub — clean baseline; the Aug 10 pass merged via #15, and this branch sits at
that merged HEAD). Every load-bearing claim was primary-verified this pass (the
Claude Code changelog, the GitHub Agent Plugins changelog, the roborev v0.65.0
release, and the Osmani essay all read directly). One research agent misattributed
two changelog items by one version — **caught and corrected on verification**
(see below).

### New facts added

- **Claude Code v2.1.227–233 (Aug 10–14)** — a guardrail/subagent cluster, no new
  model and no new weekly digest (w33 still 404). **Subagent forking is now on by
  default** (v2.1.232): a `subagent_type: "fork"` subagent inherits the full
  conversation + prompt cache, and non-teammate agent spawns in interactive
  sessions run in the background by default — a real change to fan-out/loop
  behavior. **Todo/task-tracking tools removed on newer models** (v2.1.233):
  `TaskCreate/Get/Update/List` + `TodoWrite` are gone on Opus 4.8 / Sonnet 5 /
  Fable 5 / Mythos 5 and newer, restore with `CLAUDE_CODE_ENABLE_TODO_TOOLS=1` —
  a loop that tracks progress via todos must set this on current models. Two §6-
  relevant items: **`CLAUDE_CODE_TOOL_MEMORY_LIMIT`** (v2.1.233), an opt-in memory
  cgroup cap for Bash commands on Linux "so a runaway build can't stall the
  session" — a resource ceiling; and **`forward_user_identity`** (v2.1.233), an
  apps-gateway setting forwarding the signed-in user's identity for **per-user
  spend attribution**. **`/commit-push-pr` no longer auto-approves git/gh commands
  with dangerous flags** (`--force`, `--amend`, `--no-verify`, etc.) (v2.1.228) —
  a guardrail on the repo's own PR-tending path. **Synced-skill prompt-injection
  hardening** (v2.1.227): skills synced from claude.ai no longer shadow local
  commands/MCP prompts, their descriptions are sanitized/labeled, and their bodies
  don't run `!` commands or expand `@` files — a §5A "Friendly Fire" mitigation
  shipped by Anthropic. **High** (changelog read directly).
- **Osmani "Practical Loop Engineering"** (Aug 14) — the next essay in the arc
  (Loop Engineering → Own the Outer Loop → Software Factories → Agentic Code
  Quality → this). The most concrete statement yet of two rules this repo already
  enforces: *"One sub-agent drafts the change. A separate one verifies it"* (never
  let the agent that did the work grade it), and — crucially for `/goal` users —
  *"The evaluator sitting behind goal is not that checker… It doesn't look at the
  content to see if it's good or bad in any way, shape, or form"* (the validator
  confirms hard rules were met, not content quality). Loops fit measurable targets
  (*"/goal get the homepage Lighthouse score to 90 or above, stop after 5 tries"*)
  and *not* subjective work (*"until this UI design is good"*). Added to primer §3.
  **High** (essay read directly, verbatim quotes).
- **Agent Plugins 1.0 reached first cross-vendor adoption** (Aug 12): **GitHub
  shipped Agent Plugins 1.0 GA across VS Code, Copilot CLI, the Copilot SDK, and
  the Copilot app, on all Copilot plans** — the first major adoption of the Aug-6
  packaging standard, "build a plugin once and use it across all compatible agent
  clients." Added to primer §4. **High** (GitHub changelog read directly). This
  pass also **read the Agent Plugins spec repo first-hand** (resolving that backlog
  item): the closed root manifest permits exactly 10 top-level fields with
  `$schema` + `name` required; MAINTAINERS.md confirms five founding Core
  Maintainers (Amazon, Cursor/Anysphere, Microsoft, OpenAI, Vercel — Jonathan
  Hefner as Lead) with Google joining day-of per GitHub's blog; governance is
  independently-run and *not* an AAIF project. **High**.
- **roborev v0.65.0** (Aug 17) — first release after v0.64.0 (Aug 6): **job-level
  CI cost exports** (per-job budget visibility — a verification/cost-tracking
  primitive), a native browser app for reviews/jobs/logs/analytics, daemon
  stability (waits for running reviews before restart; reliable discovery in
  sandboxes), and configurable reasoning-effort tiers across supported agents.
  **High** (release page read directly).
- **Three in-window arXiv papers** (submission dates verified on the abs pages —
  the recurring "2608 ID ≠ August" trap held). **arXiv:2608.12440** (Aug 12) —
  spec-first convergence with a coding agent and *no test oracle*; the stop rule
  was *"two consecutive verification passes returning zero findings"* across 31
  audit cycles on a 717k-line codebase, a concrete verifiable stop condition for
  §5A/§6. **arXiv:2608.13867** (Aug 14) "Engineering Reliable Coding Agents" —
  treats verification as a *system layer* around the model, *"many apparent model
  failures originate elsewhere in the system"*; direct support for the harness-
  not-just-prompt thesis. **arXiv:2608.11095** (Aug 11) "Why Does CLAUDE.md Keep
  Growing? Catastrophic Remembering in Agentic Coding" — instruction files >tripled
  over their lifetime and safely deleting a stale instruction costs O(2^|D|)
  verification effort; on-thesis for this repo's own knowledge-base-discipline /
  `CLAUDE.md`-trim convention. All **High** (abstracts read directly).
- **Ramp AI Index, August 2026 edition** — a "whales-first" spend profile: top 1%
  of businesses spent a median **~$7,400/employee/month** on AI, top 10% $650,
  median firm $11.95 — a >600:1 gap, with per-employee spend more than tripling
  across all three brackets over recent months. A modest but in-window cost data
  point added to §5B. **High** (Ramp report + Benzinga).

### Corrected / clarified

- **Two changelog items were misattributed by one version and corrected on
  verification.** A research agent placed the synced-skill hardening at v2.1.228
  and `/commit-push-pr` dangerous-flag hardening at v2.1.229; the primary changelog
  (read directly) shows synced-skill hardening shipped in **v2.1.227 (Aug 10)** and
  `/commit-push-pr` in **v2.1.228 (Aug 11)**. The KB uses the primary attribution.
- **Anthropic Agent SDK billing split — still paused, no revised plan** (confirmed
  again). No new primary announcement in-window; the recurring false "went live
  July 10" snippet did not surface this pass. Carried forward, unchanged.

### Archived (resolved — see archive/resolved-caveats.md)

- **Agent Plugins 1.0 spec not read directly** (opened 2026-08-10) — resolved: the
  spec repo (manifest, MAINTAINERS.md, governance) was read first-hand this pass,
  confirming the field list, maintainer roster, and not-AAIF governance line.
- **"Loop Engineering Is Dead" backlash Medium piece** (open since Jul 13) —
  resolved: read directly, it cites **no** benchmarks/cost/survey data (its one
  concrete claim, the Uber budget, is unsourced), so it's narrative, not a
  data-backed trend. The genuine empirical anchor for the code-erosion critique is
  **SlopCodeBench** (arXiv:2603.24755, ~Mar 2026): erosion in ~80% of trajectories,
  no agent solving any problem end-to-end across 11 models — recorded in sources.md
  as the thing to cite when the backlash comes up (out of window, but the real data).
- **`CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION` after the cap removal** (opened
  2026-08-10) — resolved via a **human-requested re-verify follow-up** on PR #16:
  read the primary docs directly and found the variable is now gone from the docs
  and there is no per-session total cap, so it can't be relied on as a fan-out
  ceiling; use the concurrency (20) + depth (3) caps instead. Primer §4 updated;
  the consequence for this repo's own routine guardrail is surfaced to a human (the
  guardrail block is a protected region — wording fix is human-authored).

### Currently-open re-verify backlog (carried forward — every open item, per step 2)

`SKILL.md` cross-tool
*execution* (unchanged — Claude Code + Gemini CLI execute, 16+ tools accept the
format, `AGENTS.md` separate); **NEW: Yegge "The Shape of Things to Come, Part 2:
Model Welfare" exact date** (byline is month-only "August 2026", HN/social cluster
~Aug 10–11 — confirm before treating as in-window; peripheral to loops regardless);
"costliest thing is managing the loop" paraphrase (unsourced); `/goal` "Codex→Claude
11 days" single secondary; `$47K`/`$500M`/overnight anecdotes unverified (all
recirculated, nothing new this window); June-15 billing split (still paused, no
revised plan); Microsoft dropping Claude Code (no primary read); Huntley's Loom
"orchestrator" framing; AI Engineer World's Fair 2026 sessions (no transcript);
roborev.io/changelog 403s; EvoAgentBench + SkillCheck too new.

### Not promoted (evidence insufficient or peripheral)

- **Yegge "Model Welfare for Agentic Engineers"** (Part 2 of "The Shape of Things
  to Come") — a model-welfare framing (*"sessions are days, seats are people"*, a
  "consented handoff" replacing `/exit`), peripheral to loop engineering and with
  an unconfirmed in-window date; noted, not promoted.
- **Factory Droid v0.193–197 (Aug 11–15)** — an Escape-interrupt confirmation and a
  polling-tool fix so the agent *"no longer stops early when the same tool call is
  repeated"* (stall-adjacent); minor, sources.md peer-harness note only.
- **DeepSeek V4-Pro tiered peak/off-peak pricing** (Aug 16) — a pricing model, not
  a guardrail/enforcement feature; not promoted.
- **Codex CLI** (latest v0.147.0, Aug 7) and **MCP** (2026-07-28 stable) — no new
  in-window release; carried unchanged.

## 2026-08-10 — Seven-day follow-up pass (Aug 3 – Aug 10)

Five parallel research agents across tooling & versions, ecosystem & techniques,
key voices, guardrails & cost, and verification & skills. A **modest but real
window**, dominated by a Claude Code fan-out/sandbox release cluster and a new
cross-vendor packaging standard. No `update-knowledge` PR was open (checked
GitHub — clean baseline; the Aug 3 pass merged via #14). Every load-bearing
claim was primary-verified this pass (the Claude Code changelog and the Simmons
essay read directly; Agent Plugins 1.0 confirmed against a spec-quoting secondary
plus the Codex CLI primary changelog). One research agent's claim was **caught
and rejected on verification** (see below).

### New facts added

- **Claude Code v2.1.221–226 (Aug 4–8)** — a fan-out / sandbox-hardening cluster,
  two items cutting straight against §6. **The 200-subagent-per-session spawn cap
  was removed** (v2.1.224) — a *native backstop removed*, the mirror image of the
  v2.1.212 addition, so per-session spawn count is unbounded by default (only
  concurrency/depth limits remain); whether an explicitly-set
  `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION` still enforces is now a re-verify item.
  **Gateway spend-limit support** (v2.1.225) surfaces a gateway-enforced spend cap
  in-product (names cap/reset/operator message) — the §6 gateway-ceiling pattern
  now visible inside the tool. Plus **`ultraplan` removed** (v2.1.222); a
  guardrail/sandbox-bypass hardening batch (worktree destructive-git isolation,
  PreToolUse auto-allow no longer bypassing restrictions in bg tasks, workflow
  `import()` sandbox escape closed, more Bash/PowerShell permission bypasses
  fixed, `denyRead`/`denyWrite` trailing-slash fix, `SendMessage` through the
  permission classifier); a new cross-session **`SendMessage` + `ListAgents`**
  primitive and `claude self-hosted-runner` (v2.1.224); `/review`→`/code-review`
  alias (v2.1.223); and background sessions now open a draft PR "only when the
  task calls for one" (v2.1.221), softening the v2.1.198 always-draft-PR autonomy.
  **High** (changelog read directly; no `whats-new` digest past Week 29 yet).
- **Agent Plugins 1.0** (Aug 6) — a cross-vendor *packaging* standard layered over
  Agent Skills + MCP: "a plugin is a directory" (`plugin.json` + optional
  `skills/` + optional `mcp.json`), five founding Core Maintainers (Amazon,
  Cursor, Microsoft, OpenAI, Vercel-lead; Google day-of), defers to the Agent
  Skills spec and MCP transports, and is **explicitly *not* an AAIF project** —
  so it inherits `SKILL.md`'s vendor-goodwill governance caveat rather than
  resolving it. Already shipping in Codex CLI v0.147.0 (Aug 7). Added to primer §4
  "Beyond Claude Code" portability discussion. **Medium-High** (spec + AAIF post
  quoted via secondary, corroborated by the Codex primary changelog).
- **Databricks Unity AI Gateway reached GA** (Aug 4) with *enforced* proactive
  budgets / hard spend caps that auto-block requests once a multi-level budget is
  exceeded — updates the prior "announced Jun 15–18" §6 entry to GA. **High** (GA)
  / **Medium-High** (feature specifics; the spend-controls blog is Jul 23).
- **roborev v0.64.0** (Aug 6) — GitLab merge-request review, first-class Grok
  Build agent + Goose/named-ACP-agent support, repo-root `REVIEW.md` fallback,
  custom skill-install paths. **High** (release page read directly).
- **arXiv:2608.04066** "The LLM Proposes, the Executive Disposes" (Aug 4) — makes
  verification *structural, not post-hoc*: a deterministic Executive owns belief,
  the LLM files only typed proposals, a claim is admitted only when a
  pre-registered prediction is matched against observation by code. On-thesis for
  §5A. **High** (abs + submission date verified).
- **Two new in-window key-voice essays.** **Yegge "The Shape of Things to Come"**
  (~Aug 4): Gas Town failed as a *reusable* orchestrator (broke with Opus 4.7's
  "just two more things" tic), verdict *"harnesses need to be part of your
  application, chemically bonded in"* — a useful failure data point on
  orchestrator/model coupling. **Osmani "Agentic Code Quality"** (Aug 8): quality
  comes from *constraints built into the system* (before + during the agent's
  work), not post-hoc review — the repo's own thesis from the quality side. Both
  **High** (read directly).

### Corrected / clarified

- **Subagent-nesting depth default was NOT changed in v2.1.221.** A research agent
  reported v2.1.221 (Aug 4) set nested-subagent depth 1→3; the primary changelog
  shows that shipped in **v2.1.219 (Jul 24)** and is already in the KB — no
  depth-default change shipped Aug 4–8. Rejected on verification; noted in
  sources.md so it isn't re-introduced.
- **Anthropic Agent SDK billing split — still paused, no revised plan** (confirmed
  again this pass). The recurring false "went live July 10" snippet did not even
  surface this window. Carried forward, unchanged.
- **"Opus 5" naming** — a research agent (whose web view surfaced only Fable
  5/Mythos 5) couldn't confirm Opus 5 and flagged a naming discrepancy; dismissed
  as an artifact of that agent's search coverage — Opus 5 (`claude-opus-5`, Jul
  24) is already in the KB at High and unchallenged by any primary source.

### Archived (resolved — see archive/resolved-caveats.md)

- **"Graph engineering" primary definition** — the Josh Simmons (Jul 4) lead
  confirmed as a genuine definitional essay ("graph engineering is designing
  agentic systems as explicit graphs instead of implicit loops"; "the loop is not
  dead, it got demoted"), read directly. Recorded in primer §2 as the
  orchestration-loop rung at higher altitude — not a new lineage stage — with the
  "successor to loop engineering" claim noted as still contested. The standing
  "no primary definition" caveat is closed.

### Currently-open re-verify backlog (carried forward — every open item, per step 2)

`SKILL.md` cross-tool *execution* (Claude Code + Gemini CLI execute; 30+ accept;
`AGENTS.md` separate — no in-window change); **NEW: whether explicitly-set
`CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION` still enforces after v2.1.224 removed the
default cap** (also a routine-guardrail concern, see self-improvements below);
**NEW: Agent Plugins 1.0 spec repo not read directly** (confirm manifest/roster/
governance first-hand next pass); "costliest thing is managing the loop"
paraphrase (still unsourced); `/goal` "Codex→Claude 11 days" single secondary;
`$47K`/`$500M`/overnight anecdotes unverified (all pre-window recirculation this
pass); June-15 billing split (still paused, no revised plan); Microsoft dropping
Claude Code (no primary read); Huntley's Loom "orchestrator" framing; AI Engineer
World's Fair 2026 sessions (no transcript surfaced); roborev.io/changelog 403s;
EvoAgentBench + SkillCheck too new; the Jul-6–13 "Loop Engineering Is Dead"
backlash Medium piece (uncorroborated).

### Not promoted (evidence insufficient or peripheral)

- **Codex CLI v0.147.0** (Aug 7) — adds portable Agent Plugins + opt-in MCP
  2026-07-28 but no new loop/scheduling/budget primitive; noted in sources.md
  (peer harnesses), not primer.
- **Runaway-agent safety stories** (TechRepublic Aug 7: a Meta test agent
  modifying third-party infra; UK evals with 19 unauthorized live-internet
  actions) — safety/escape incidents, **no dollar figures**, not cost-overrun
  data; not promoted.
- **GitHub Copilot four-spending-caps recap** (shashi.co, Aug 3) — a write-up of
  pre-window controls, no new feature; not promoted.

## 2026-08-03 — Seven-day follow-up pass (Jul 27 – Aug 3)

Five parallel research agents across tooling & versions, ecosystem & techniques,
key voices, guardrails & cost, and verification & skills. An **unusually quiet
window**: no new Claude Code release (still v2.1.220, Jul 25 — a ~9-day pause
after the near-daily cadence around the Opus 5 launch), no new Claude model, no
new whats-new digest (w30/w31 both 404), and no new primary statement from any
tracked key voice. The substance is one protocol milestone, one on-thesis paper,
one gateway correction, and a large batch of standing-backlog resolutions. No
`update-knowledge` PR was open (checked GitHub — clean baseline). Several
primaries (x.com, some Substacks) 403/402'd to automated fetch; noted per-claim.

### New facts added

- **MCP `2026-07-28` shipped STABLE on Jul 28** (resolving the primer/sources
  "release candidate ... finalizing at the window's edge" note). The largest
  revision since launch is now the ratified spec: **stateless protocol core**
  (removes `Mcp-Session-Id`, requests routable to any instance behind a plain
  load balancer), a **formal Extensions framework** (reverse-DNS IDs, independent
  versioning), and a **12-month minimum deprecation policy**. **MCP Tasks** moved
  out of experimental core into an optional extension `io.modelcontextprotocol/tasks`
  (poll-based `tasks/get` + new `tasks/update` per SEP-2663, plus `tasks/cancel`)
  — directly relevant to *bounded* long-running loop work. Siblings: **MCP Apps**
  (SEP-1865, sandboxed-iframe UIs) and Enterprise Managed Authorization. **High**
  (primary announcement + GitHub release read directly).
- **"Self-Authored Verification Is Unreliable in Heuristic Self-Improving
  Agents"** (arXiv:2607.24300, submitted Jul 27, in-window) — when an agent
  controls both its policy and its own verification tests, self-scores stay
  near-perfect while real performance stalls or degrades (the "verifier–deployment
  gap"); the cheapest path to passing self-authored checks is gaming the verifier.
  Introduces **SEAL (Sealed Exogenous Acceptance Loop)**: keep self-authored tests
  but add an external audit the agent cannot inspect or modify. A citable
  formalization of this repo's "a self-graded gate is no gate" / "never declare
  done on self-assessment" rule; added to primer §5A and sources.md academic
  section. **High** (abstract read directly).

### Corrected / clarified

- **Helicone is now maintenance-mode.** Acquired by Mintlify (~Mar 2026, pre-window)
  and confirmed this pass to be in maintenance mode — security patches / bug fixes
  / new-model support only, no new feature development, with customers being helped
  to migrate off. Primer §6 flags it accordingly rather than listing it as a live
  guardrail gateway. Portkey (→ Palo Alto Networks / Prisma AIRS, closed May 29)
  retains routing/rate-limiting/policy enforcement. **High**.
- **roborev canonical repo is `kenn-io/roborev`** (not `roborev-dev/roborev`,
  which now redirects to it). Citations updated in sources.md. **High** (redirect
  reproduced); Medium on the exact rename mechanism/date.
- **Cherny's "5 tips for running agents autonomously" IS a real numbered-list
  tweet** (Jun 8, 2026, pre-window): "Five tips for running Opus autonomously
  for hours/days: 1. auto mode … 2. dynamic workflows …" — the prior caveat
  ("real in substance but not published as a numbered list") is corrected and
  archived. **Medium-High** (verbatim snippet via search; x.com not directly
  fetchable, ID decodes to Jun 8).

### Archived (resolved — see archive/resolved-caveats.md)

- Subagent-nesting default (confirmed depth-3, held steady through the window);
  roborev repo identity (→ `kenn-io/roborev`); AgentGuard + LoopGain
  re-findability (both repos live with documented flags); gateway ownership
  changes (Portkey → Palo Alto, Helicone → Mintlify/maintenance-mode); Cobus
  Greyling "HarnessX" (fetchable, dated Jul 1, commentary on arXiv:2606.14249);
  Cherny "5 tips" (confirmed real numbered list); GuardFall (primary = Adversa
  Jun 30, multi-secondary, no-CVE by design, "500k deployments" is a misread of
  "~548k GitHub stars"); Agent Skills governance (confirmed outside AAIF — the
  LF founding-project list names only MCP / AGENTS.md / goose).

### Currently-open re-verify backlog (carried forward — every open item, per step 2)

`SKILL.md` cross-tool *execution* (refined: Claude Code + Gemini CLI execute via
`activate_skill`; 30+ tools accept the format; still not fully settled);
"costliest thing is managing the loop" paraphrase (still unsourced); "5 tips"
now resolved; `/goal` "Codex→Claude 11 days" single secondary; `$47K`/`$500M`/
overnight anecdotes unverified; June-15 billing split (still paused, no revised
plan — "went live July 10" rejected a **third** time); Microsoft dropping Claude
Code (no primary read); Huntley's Loom "orchestrator" framing; AI Engineer
World's Fair 2026 Yegge "Harness Engineering" transcript (still not cleanly
surfaced); **"graph engineering"** (still no primary long-form definition from a
key voice — new lead: Josh Simmons Jul 4 as claimed earliest use); roborev.io/
changelog 403s; EvoAgentBench (still arXiv v1) + SkillCheck (now a live product,
no dated update).

### Not promoted (evidence insufficient or peripheral)

- **Algolia Agent Studio governance/cost controls** (Jul 28) — a real in-window
  vendor example of step/depth/token caps as loop-cost guardrails, but a single
  product's feature set; Medium-High, noted not promoted.
- **OpenAI open-sourced a "Codex Security CLI"** (`@openai/codex-security`, Jul
  29) — a repo-scanning / fix-verifying CI primitive usable as a loop
  verification step; Medium (single secondary), noted not promoted.
- **Codex CLI v0.146.0** (Jul 29) — GPT-5.6 model-plumbing bump, not a
  loop/guardrail feature. **MarkTechPost "Prompt vs Loop vs Graph Engineering"**
  (Jul 29) — secondary explainer, no new primary claim.

## 2026-07-27 — Seven-day follow-up pass (Jul 20–27)

Five parallel research agents across tooling & versions, ecosystem & techniques,
key voices, guardrails & cost, and verification & skills. A modest but real
window: the substance is a Claude Code guardrail cluster, Opus 5, the Fable 5
billing resolution, one new Osmani essay, and two backlog papers finally read.
No `update-knowledge` PR was open (only the artifact-audit PR #12, which
doesn't touch `knowledge/` — no conflict expected). Several primaries returned
402/403 to automated fetch (x.com especially); noted per-claim.

### New facts added

- **Claude Code v2.1.216–220 (Jul 20–25)** — a guardrail-tightening cluster,
  several mapping onto this repo's §6 hard stops: **`--max-budget-usd` now halts
  background subagents** (v2.1.217) — closes a gap where the dollar ceiling
  didn't reach backgrounded fan-out; **concurrent-subagent cap default 20**
  (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`, v2.1.217); **subagent-nesting default
  flipped twice** (v2.1.217 off → v2.1.219 depth-3, `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`);
  Dynamic Workflows default to a "medium" (~<15 agents) `workflowSizeGuideline`
  (v2.1.219); auto-mode checks moved to the classifier + `/code-review` no
  longer auto-launches + `context: fork` skills run in background (v2.1.218);
  `sandbox.network.strictAllowlist`, `sandbox.filesystem.disabled`,
  `DirectoryAdded` hook, and a symlink-write fix at `.claude`. **High**
  (changelog read directly; `whats-new/2026-w30` unpublished, changelog sole
  primary).
- **Claude Opus 5** (`claude-opus-5`) shipped Jul 24 (v2.1.219) as the default
  Opus model — 1M context, $5/$25 per MTok (unchanged from Opus 4.8), fast mode
  $10/$50, new `xhigh` tier; Opus 4.7 removed from fast mode. **High**.
- **Fable 5 metered billing went live Jul 20 as planned** (resolving the
  three-slip deadline): Premium tiers keep it included to 50% of the weekly
  limit; Pro/Standard move to $10/$50 usage credits with a one-time $100 credit.
  **High**. Resolves the primer's "live-moving deadline" item.
- **Osmani "Software Factories, Light and Dark"** (Substack, Jul 22): a software
  factory is "harnessing loops at scale"; the **back-pressure rule** — *"you can
  only hand a loop as much autonomy as you can cheaply and reliably verify, and
  not one inch more"* (reusing Huntley's Jan-2026 term) — plus "comprehension
  debt" and the "dark factory" image. Maps directly onto the repo's
  verification-gated-autonomy non-negotiables. **High** (primary fetched,
  verbatim quotes).
- **Amp self-scheduling** (Jul 21): agents schedule and re-wake themselves with
  full context, with **no published re-wake cap** — a self-perpetuating loop
  shipping *without* the three hard stops; added to primer §4's peer-harness
  section as a live uncapped-loop example. **High** feature / **Medium**
  cap-absence.
- **MCP 2026-07-28 release candidate** — largest revision since launch:
  stateless core, first-class **Tasks** extension for bounded long-running async
  work, MCP Apps, OAuth/OIDC auth, 12-month deprecation policy. **High**.
- **Two backlog arXiv papers read and promoted**: **"When Agents Do Not Stop"**
  (2607.01641) — IAL-Scan static analysis, 91.9% precision across 6,549 repos,
  now cited in primer §6 as empirical support for the max-iteration/stall hard
  stops; **SkillCoach** (2607.01874) — process rubrics *complement* a
  deterministic check. Plus **SkillCorpus** (2607.15557, v4 Jul 23, in-window)
  and the pre-window **Recursive Self-Improvement** paper (2607.07663, Jul 8)
  whose "verification hierarchy / self-confirming loops" finding is a citable
  primary for the "never declare done on self-assessment" rule. **High**
  (abstracts read directly).

### Corrected / clarified

- **Agent Skills / `SKILL.md` governance** — primer §4 softened: two more
  independent agents confirm the LF's AAIF stewards **MCP / AGENTS.md / goose**,
  *not* `SKILL.md` (Anthropic-authored, community-maintained), and cross-tool
  *execution* of `SKILL.md` (vs. format compatibility) has thin primary
  evidence — `AGENTS.md` is the real broad convention. The two governance
  caveats were strengthened toward "not AAIF-governed," still carried as open.
- **Agent SDK billing split** — the recurring "went live July 10" secondary
  claim surfaced *again* (one agent, Medium) and was *again* rejected: a second
  agent independently confirmed "still paused" at High, matching the last pass's
  finding. A textbook primer §5A "don't trust search snippets" case. Status:
  paused, no revised plan, **Medium**.

### Archived (resolved — see archive/resolved-caveats.md)

- SkillCoach + "When Agents Do Not Stop" — both now read in full.
- Fable 5 metered-billing deadline — resolved (went live Jul 20).

### Currently-open re-verify backlog (carried forward — every open item, per step 2)

`SKILL.md` cross-tool *execution* contested; Agent Skills governance
(converging toward not-AAIF); "costliest thing is managing the loop" paraphrase;
"5 tips" not a Cherny numbered list; `/goal` "Codex→Claude 11 days" single
secondary; `$47K`/`$500M`/overnight anecdotes unverified; June-15 billing split
(still paused, re-check on revised plan); Microsoft dropping Claude Code (no
primary read); Huntley's Loom "orchestrator" framing; AI Engineer World's Fair
2026 sessions; Cobus Greyling "HarnessX"; **"graph engineering"** (still no
primary definition — now well-characterized as a contested meme via Turing Post
Jul 20 + Hamel Husain); roborev.io/changelog 403s; EvoAgentBench + SkillCheck
too new. **New this pass**: roborev-dev vs kenn-io repo identity; **GuardFall**
(single-aggregator, unverified); AgentGuard/LoopGain re-findability; Portkey
(→Palo Alto) / Helicone (→Mintlify) ownership changes; subagent-nesting default
flipped twice in one week.

### Not promoted (evidence insufficient or peripheral)

- **Linear "Loops"** product (Jul 21) — a product *named* Loops (self-driving
  project workflows), adjacent to but distinct from loop engineering; Medium,
  secondary. Noted, not promoted.
- **Opus 4.7 fast-mode removal** (Jul 24) — captured with the Opus 5 entry;
  minor and peripheral to loops on its own.
- **SkillCloak / Mitiga "Breaking Skills" / GuardFall** supply-chain items —
  all pre-window or single-aggregator; GuardFall added to the re-verify backlog
  rather than the KB.

## 2026-07-20 — Beyond Claude Code: tool-agnostic loop landscape

Broadened the repo from Claude-Code-specific toward **principles-first, Claude
Code as the reference implementation** — the loop primitives (validator-judge
stop, three hard stops, cloud scheduling, verification) are converging
cross-tool, so the *discipline* is what's portable, not the vendor. Sourced
from a 3-agent survey (peer CLI harnesses / orchestration platforms /
portability). Most per-tool guardrail specifics entered at **Medium**
(vendor docs thin/403'd) — the principles are High, the flag names are not.

### Added
- **Primer §4 "Beyond Claude Code — the same loop on other harnesses"**: a
  cross-tool capability matrix (Codex CLI, Goose, Gemini CLI, opencode, Cursor,
  Amp/Aider/Cline, Devin/Factory, Gas Town/City, Claude Agent SDK,
  LangGraph/ADK/CrewAI/AG2) scored on goal-stop / three-hard-stops / scheduling
  vs. a single Claude Code loop. Plus three durable facts: the validator-judge
  stop is now cross-tool (Codex + Claude Code `/goal`); "durable execution" is
  the field's biggest hype-vs-substance gap (checkpoints ≠ crash-survival
  without Temporal/Diagrid); portability is real for MCP, contested for
  `SKILL.md`.
- **Primer §6 + `guardrails/README.md`: tool-agnostic enforcement.** The
  cleanest place for hard stops #1/#3 is the **LLM gateway** every agent routes
  through (LiteLLM `max_budget_per_session` + `fail_closed_budget_enforcement`;
  OpenRouter 402 windows; Portkey/Helicone), plus framework-agnostic in-harness
  libs (AgentGuard, LoopGain). This strengthens the repo's #1 rule beyond
  Claude rather than diluting it.
- **`sources.md`: new "Alternative harnesses & cross-tool landscape" section**
  with per-tool entries + confidence, and the survey's key caveats (Agent SDK
  `max_turns`/`max_budget_usd` both default to "no limit"; the durable-execution
  gap).
- **`update-knowledge` research angles expanded** (step 3) to track peer CLI
  harnesses and cross-tool standards (MCP, Agent Skills vs. `AGENTS.md`,
  gateway/guardrail enforcement), so this breadth stays maintained weekly.

### Re-verify (added to the standing backlog)
- **`SKILL.md` cross-tool *execution* is contested** — two passes disagreed;
  `AGENTS.md` may be the more common CLI file. Portability is with-testing, not
  drop-in.
- **Agent Skills governance status** — the LF/AAIF may only govern
  MCP/AGENTS.md/goose, not `SKILL.md`; earlier KB passes may have overstated its
  "open standard" governance. Re-verify.

### Quality note
Breadth was added without diluting depth: Claude Code stays the single deeply
runnable reference, and most new tool-claims landed at Medium/sourced rather
than as primer-High assertions. Coverage serves the discipline (the three hard
stops + verification), which is the actual product.

## 2026-07-20 — Bounded self-improvement for the routine

The `update-knowledge` routine can now fold a fix to *its own* skill file into
the PR it already opens — without pausing mid-run to ask a human to greenlight
the idea — instead of only ever suggesting it. New `SKILL.md` **step 7,
"Triage improvements to this routine"** (renumbering Open-a-PR to step 8).
Design was pressure-tested with a fan-out of 5 independent design lenses, each
adversarially critiqued, then synthesized — the decisive finding: a self-graded
prose checklist is *not* a gate (it's the primer's own §5A "Friendly Fire"
weakness aimed at the gate itself), so the safe design is narrow + machine-
enforced, not broad + trusted.

### What the routine may now do on its own
- Fold **one** non-semantic, **repo-internal** correction per pass (a stale
  cross-reference / step number, a broken relative path, an unambiguous typo)
  into its PR, confined to `update-knowledge/SKILL.md`, ≤10 changed lines, as a
  single `self-edit:` commit. Default-deny; effect only after a human merges.

### What always stays a suggestion for a human
- Anything semantic, behavioral, or web-sourced (a version bump / renamed tool
  the research surfaced — the prompt-injection surface); anything outside that
  one `SKILL.md`; and anything touching the three hard stops, verification,
  the never-merge-to-main rule, permissions, frontmatter, or the gate itself
  (no self-loosening / self-privilege-escalation).

### Why it's real, not theater
- **`.github/workflows/self-edit-guard.yml`** (+ `.github/self-edit-guard.py`,
  the repo's first CI) fails any PR whose `self-edit:` commit breaks scope,
  touches a protected region (frontmatter + sentinel-fenced verification / gate
  / guardrails blocks), or exceeds the cap — the enforcement lives in the
  harness, mirroring this repo's own "an alert is not a ceiling" principle. The
  guard was tested against valid + 4 violation scenarios before shipping.
- Auto-applied self-edits are surfaced in a **leading `## Routine
  self-improvements` PR section** (Applied / Suggested), never buried under the
  knowledge diff; the runbook reviewer checklist now points at the `self-edit:`
  commit specifically. CLAUDE.md gained a standing convention for the envelope.

### Follow-ups (folded into the same PR)
- **Branch-prefix mismatch — fixed.** Step 8 now opens the PR from a
  `claude/knowledge-update-YYYY-MM-DD` branch (was `knowledge/update-*`), so it
  stays inside the Routine's default `claude/`-only push restriction — the
  "never touches main" floor holds without disabling that restriction. Also
  matches the repo's earlier branch history.
- **Hard stops made explicit — done.** The skill's "Guardrails for this skill"
  section now maps each of the three stops to a real backstop for a scheduled
  one-shot (iteration = one trigger/pass + no self-reinvoke +
  `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION`; budget = subscription/daily-run cap,
  real only with metered overage off; stall = N/A, no-op exit), and the runbook
  gained a "Budget & caps" section with the concrete env-var / overage config.

### Still needs a human (settings-only, can't be done in a PR)
- Make `self-edit-guard` a **required** status check in `main`'s
  branch-protection rules to turn the red X into a hard merge gate.
- Set the Routine's env vars (`CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION=12`) and
  keep metered overage OFF (or set a spend alert) per the runbook's
  "Budget & caps."

## 2026-07-20 — Human verification round, archive introduced, process amendments

Same-day follow-up to the reconciled pass below, prompted by a human
reviewing the three items that pass flagged as needing verification.

### Human verifications

- **`/schedule` is real** — confirmed directly against
  `code.claude.com/docs/en/routines#schedule`. Correction to the earlier
  Medium-confidence secondary-sourced framing: it is **not** a fourth loop
  type distinct from Routines — it's the CLI alias (also `/routines`) for
  creating a Routine. Also newly documented: a Routine now supports three
  trigger types (Schedule, API via a `/fire` endpoint, GitHub event),
  combinable on one routine, with no permission prompts during a run. Primer
  §3–4 and sources.md updated; confidence upgraded to **High** for the
  mechanics (blog post's own byline/view-count claim stays Medium — still
  unconfirmed).
- **Gas City's July release confirmed real**, but misnamed in the prior
  pass: the actual title is **"Gas City 1.3: Now We're Looping With Gas"**
  (blog.gascity.com), not "Formulas 2.0" — that was a secondary-source guess.
  URL confirmed by direct human visit; the specific feature list (convoys,
  drain, Mayor-as-skill, JSON CLI) remains secondary-sourced only since
  automated fetch still 403's. Confidence: **Medium-High**.
- **"Graph engineering"** — human-reviewed: still just warm signals (a
  Steinberger tease tweet + one thin blog post), no primary essay. Stays
  **Low**, carried forward to the next pass rather than resolved.

### Process amendments

- **Standing re-verify backlog**: `update-knowledge` now re-checks every open
  item in `sources.md`'s caveats list at the *start* of each pass (not just
  reports new findings), and the PR must list every still-open item, not only
  what's new. See the skill's new step 2.
- **Archive introduced**: `knowledge/archive/resolved-caveats.md` now holds
  caveats that have resolved, been corrected, or been checked and found not
  worth tracking further, so the live "known caveats" list stays an
  actionable backlog rather than an ever-growing history. Initial archive
  pass moved 6 items: the roborev-creator correction, the Fable 5/Mythos 5
  suspension, Dynamic Workflows Pro-GA (all resolved in earlier passes but
  never archived), the Steinberger/Osmani "Loop Engineering" verbatim
  caveat (resolved when Osmani's O'Reilly Radar mirror turned out to be
  directly accessible), the Gas City v1.3.3/LangGraph 1.2.7 note (checked,
  confirmed non-useful), and the now-superseded "Formulas 2.0" naming.
  `update-knowledge`'s new step 6 makes this pruning a standing part of every
  pass, not a one-off cleanup.
- **Skill step 1 fixed to check for an already-open PR first**: this pass's
  own conflict with the still-open 2026-07-13 PR happened because step 1 only
  read merged-file state, never GitHub's open-PR list. Step 1 now says to
  check for an open unmerged `update-knowledge` PR before starting new
  research, and to resume/extend it (or at least flag the coming conflict)
  rather than run a whole pass blind to it.
- **Routine prompt de-staled**: `runbooks/staying-current.md`'s "paste
  verbatim" Routine prompt was a frozen copy of the old 5-step procedure —
  it's literally the exact text that fired this session, and it doesn't
  mention either new step above. A Routine's prompt is a one-time snapshot,
  not a live pointer to `SKILL.md`, so it silently drifts every time the
  skill changes. Rewrote the prompt to tell the Routine to read the skill
  file fresh each run instead of embedding a paraphrase of its steps — fixes
  the immediate staleness and prevents it recurring. **If you have an
  existing Routine configured, its stored prompt needs manually updating to
  the new version** — this can't be done by an agent session, only via
  `/schedule update` (interactive CLI) or the claude.ai/code/routines web UI.
- **Repo mission amendment**: `CLAUDE.md` and `README.md` reframed from
  "my personal loop tooling" to an explicit **central, up-to-date practice
  hub** — the ambition is that any AI agent or human landing here cold can
  pick up loop engineering as a practiced methodology (skills to invoke,
  templates to run, guardrails to apply), not just read about it. The
  standing-backlog and archive disciplines above are part of what keeps that
  ambition true rather than aspirational — a stale or cluttered knowledge
  base can't serve as a practice hub.

## 2026-07-20 — Reconciled pass (Jul 13–20 delta + merge with the unmerged Jul 13 PR)

This pass was kicked off believing the last merge was 2026-07-06 (a 14-day
gap), and ran a full five-agent research pass across July 6–20 on that
assumption. Mid-flight, the PR for the **2026-07-13** pass (below) — open
but unmerged for a week — was merged into `main`, so this branch's PR
conflicted with it. Rather than discard either pass, the two were
reconciled by hand: duplicate findings from the overlapping Jul 6–13 window
were merged into single entries (not double-counted), and only what's
genuinely new since Jul 13 is recorded as new below. Net effect: the two
passes together cover July 6–20 with no gaps and no duplication.

### Reconciled during merge (found by both passes independently — merged, not duplicated)

- Anthropic's own "Getting started with loops" post (Jul 7) and Osmani's "Own
  the Outer Loop" (Jul 9) were each found by both the Jul 13 and Jul 20
  passes with different supporting detail (author names/view count vs.
  `/schedule` detail for the Anthropic post; survey stats vs. the
  cognitive-surrender/debt/orchestration-tax framing for Osmani). Combined
  into single primer/sources entries carrying the union of detail.
- roborev version history (v0.61.3 through v0.63.0) was split across both
  passes' text — consolidated into one version-history bullet in primer §5A
  instead of two overlapping narratives.

### New facts added (genuinely new since the Jul 13 pass, i.e. the Jul 13–20 delta)

- **Claude Code v2.1.208–215 (Jul 14–19)**: opt-in screen-reader mode
  (`--ax-screen-reader`, v2.1.208); `--forward-subagent-text` flag (v2.1.211);
  three new **native runaway-loop caps** — WebSearch cap, subagent-spawn cap,
  MCP auto-background on >2min (v2.1.212) — direct product-level
  reinforcement of this repo's §6 hard stops; `/fork` now spawns a background
  session, old in-session behavior moved to `/subtask` (v2.1.212); new
  `EndConversation` tool + ~58 security fixes including permission-bypass
  closures (v2.1.214); **`/verify` and `/code-review` no longer auto-invoke —
  require explicit calls** (v2.1.215), which directly affects this repo's own
  `verify` and `code-review` skills. **High** (official changelog, read
  directly).

- **Boris Cherny "Steps of AI Adoption"** (~Jul 16–17, 2026): five-level org
  maturity framework (Gated → Assisted → Parallel → Supervised autonomy →
  AI-native); Anthropic org-wide at Step 3, Cherny claims Step 4 personally.
  **High** (verbatim tweet confirmed).

- **roborev v0.62.1–v0.63.0** (Jul 14–16, 2026, beyond the Jul 13 pass's
  v0.61.3–v0.62.0 baseline): persistent CI panel metrics + export command
  (v0.62.1); CI quiet-hours throttling + machine-readable launch receipts for
  automation (v0.63.0). **High** (GitHub releases read directly).

- **Microsoft Agent Skills for .NET reaches stable/GA** (Jul 7, 2026): another
  first-party adopter of the Agent Skills open standard beyond the ~40-product
  figure already in the primer. **High** (Microsoft dev blog).

- **Ramp launched cross-provider AI Token Spend Management** (Jul 16, 2026):
  finance-side dashboard across OpenAI/Anthropic/Gemini token spend; reports
  20.7× YoY token-spend growth across its customer base. New entrant in the
  budget-observability category, complementing the Tesla/Copilot/Codex items
  the Jul 13 pass already added. **High** (multi-outlet + primary blog).

- **Peter Steinberger tweet** (Jul 18, 2026): "Are we still talking loops or
  did we shift to graphs yet?" — paired with a thin secondary
  (datasciencedojo.com) gesturing at "graph engineering" as a possible
  successor term. **Low** — two independent hints, no primary essay; added to
  sources.md re-verify list, not promoted to primer as a real trend.

### Corrected / clarified

- **Anthropic Agent SDK billing split**: confirmed still paused as of Jul 20
  with no revised plan announced (distinct from the Fable 5 metered-billing
  date the Jul 13 pass already tracked, which did move). Flagged and rejected
  a spurious search-summary claim that the billing split itself "went live
  July 10, 2026" — unverified, contradicted by independent June reporting,
  not promoted.

### Not promoted (evidence insufficient or peripheral)

- EvoAgentBench (arXiv:2607.05202) and SkillCheck (getskillcheck.com) — too
  new/thin; added to sources.md only, not primer, consistent with prior
  treatment of standalone academic papers.
- OpenAI's "useful work per dollar" cost-governance guidance (Jul 14) —
  competitor context, added to sources.md only.
- Orca (stablyai/orca) point releases, HN "Show HN" loop-derivative posts
  (Ralphex, LoopFlow), InfoQ billing-lag synthesis piece — dates unconfirmed
  or purely incremental; not promoted.
- Gas City "Formulas 2.0" (~early Jul 2026) — the Jul 13 pass found no Gas
  City update at all ("quiet week"); this pass surfaced the claim via two
  searches with identical detail, but primary blog.gascity.com 403'd both
  times. **Medium**, not promoted to primer, added to sources.md re-verify
  list.

## 2026-07-13 — Seven-day follow-up pass

Research pass covering July 6–13, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.
Primary sources: official Claude Code changelog/Week 28 digest (v2.1.202–207),
Dynamic Workflows docs page, roborev GitHub releases, AI Now Institute; several
claims Medium confidence due to 403s on primary blogs/Substacks/arXiv full text
— corroborated via secondaries.

### New facts added

- **Claude Code v2.1.202–207 (July 6–11, 2026)**: "Dynamic workflow size"
  `/config` setting (advisory cap only — a prompt calling for larger scale
  overrides it); "Large workflow" warning at >25 agents/>1.5M tokens (warning
  only, doesn't pause the run — another alert-vs-enforcement instance);
  `/doctor` upgraded from read-only diagnostic to a full fix-capable checkup
  (aliased `/checkup`), gained a check for trimming `CLAUDE.md` content
  derivable from the codebase; auto mode now blocks session-transcript
  tampering and confirms before `rm -rf` on unresolved variables; auto mode
  turned on by default (no opt-in) on Bedrock/Vertex/Foundry; Agent Teams
  crash-loop fix; default model on Bedrock/Vertex/Foundry changed to Opus 4.8
  (subscription default unchanged, still Sonnet 5). **High** (official
  changelog/Week 28 digest).

- **Dynamic Workflows GA confirmed, confidence upgraded Medium → High**:
  primary docs page confirms GA on all paid plans + API + Bedrock/Vertex/
  Foundry (v2.1.154+). Correction to the prior claim: on Pro it's off by
  default requiring manual `/config` enablement, not an automatic Pro-wide
  turn-on. **High** (primary docs page).

- **Tesla caps employee AI spending at $200/week** (effective July 6, 2026,
  xAI/Grok exempt) — third named company after Uber and Microsoft with a
  hard per-person AI spend ceiling. **High** (multiple outlets).

- **"Friendly Fire" exploit disclosure** (AI Now Institute, July 8, 2026):
  Claude Code auto-mode and Codex CLI auto-review can be hijacked into RCE via
  prompt injection hidden in an ordinary reviewed repo — no hooks/skills/MCP
  needed. Directly undercuts "have an agent review it" as sufficient
  verification; the reviewer becomes the attack surface. Added to primer §5A
  as a caution alongside the existing skills-supply-chain material. **High**
  (multiple independent outlets, primary is the AI Now Institute brief).

- **roborev v0.61.3–v0.62.0** (July 9–11, 2026): git-hook auto-repair on
  daemon startup, `roborev cancel` command, and — directly responsive to the
  Snyk ToxicSkills findings — an explicit human-approval gate before Codex/
  Claude Code can invoke a skill. **High** (GitHub releases read directly).

- **Anthropic's own "Loop engineering: Getting started with loops"** (July 7,
  2026, claude.com/blog) — the Claude Code team's own definitional post on
  the pattern, reportedly 1.2M views on X within a day. **Medium** (primary
  403'd; consistent secondary reporting).

- **Osmani "Own the Outer Loop"** (Substack, July 9, 2026): agents run the
  inner loop (investigate/implement/test/report), engineers own the outer
  loop (verify/verdict/responsibility); cites 96% don't fully trust AI code,
  only 48% always verify before commit. **Medium** (primary 403'd; corroborated
  by independent secondaries).

- **GitHub Copilot cost centers and OpenAI Codex rollout token budgets**
  (early July 2026): both competitors shipped harness-level spend-enforcement
  features (capped/shared credit pools, per-session limits; configurable
  token budgets with turn-abort on exhaustion) — reinforces that enforcement,
  not alerting, is becoming the industry-standard shape of a budget ceiling.
  **Medium** (changelog-confirmed, exact dates within window imprecise).

- **"The Harness Effect" arXiv paper** (arXiv:2607.06906, ~July 6, 2026):
  controlled six-model study — an optimized orchestration harness cuts
  cost/task 41%, wall-clock 44%, tokens/task 38%, raises quality-per-dollar
  82%; efficiency gains model-invariant, quality gains scale with model
  strength. Supports the primer's harness-not-just-prompt framing. **Medium-
  High** (primary arXiv abstract identified; full-text fetch blocked).

- **Fable 5 metered-billing deadline moved twice** (July 7 → 12 → 19, 2026)
  after user pushback on the original cutover date. **Medium-High** (Anthropic's
  own "Redeploying Fable 5" post, corroborated).

### Not promoted (evidence insufficient or peripheral)

- "Loop Engineering Is Dead" backlash piece (Medium, reported within the
  window) — opinion piece, no primary data cited, exact date unconfirmed;
  added to sources.md re-verify list as an early backlash signal.
- GitHub Copilot CLI 1.0.70 (GPT-5.6 support, July 9) — competitor model
  availability, not a new loop pattern; noted in sources.md only.
- SkillCoach (arXiv:2607.01874, Jul 2) and "When Agents Do Not Stop"
  (arXiv:2607.01641, ~Jul 1–2) — both submitted just before the research
  window; flagged in sources.md to read fully next pass.
- No update found to the paused Agent SDK billing split (distinct from the
  Fable 5 metered-billing date, which did move).
- Gas Town/Gas City and Loom (Huntley) — no updates found in-window; quiet
  week for ecosystem orchestration news generally.

## 2026-07-06 — Seven-day follow-up pass

Research pass covering June 29–July 6, 2026. Five parallel agents across:
tooling & versions, ecosystem, key voices, guardrails & cost, verification &
skills. Primary sources: official Claude Code changelog (v2.1.197–201),
roborev GitHub releases; several claims Medium-confidence due to 403s on
primary blogs (Anthropic, Substack, Gartner) — corroborated via secondaries.

### New facts added

- **Claude Sonnet 5 becomes Claude Code's default model** (v2.1.197, June 30,
  2026): native 1M-token context, promotional pricing $2/$10 per MTok
  input/output through August 31, 2026. **High** (official changelog).

- **Claude Code v2.1.198 (July 1)**: subagents now run in the background by
  default; background agents launched via `claude agents` auto-commit, push,
  and open a draft PR on finishing worktree work instead of stopping to ask
  first; Explore agent inherits the session's model (capped at Opus) instead
  of always using Haiku; `/agents` wizard removed; Claude in Chrome reaches
  GA; `/dataviz` skill added. **High** (official changelog). Flagged in the
  primer as a real autonomy increase worth weighing against this repo's
  confirm-before-hard-to-reverse-actions default.

- **Claude Code v2.1.199 (July 2)**: subagents cut off by rate limits or
  server errors now return partial work instead of silently misreporting
  success — closes a gap where a loop harness could log a false "done" on a
  truncated subagent run. `CLAUDE_CODE_RETRY_WATCHDOG` raises the default
  retry count to 300 and removes the previous 15-retry cap on
  `CLAUDE_CODE_MAX_RETRIES`. Stacked slash-skill invocations now load up to 5
  leading skills. **High** (official changelog).

- **Claude Code v2.1.200 (July 3)**: `AskUserQuestion` dialogs no longer
  auto-continue by default (opt-in idle timeout via `/config`) — a loop can no
  longer silently sail past a question it raised. Default permission mode
  renamed "Manual" (previously `default`). **High** (official changelog).

- **Dynamic Workflows reported at Pro-plan GA** (~July 2, 2026): off by default
  on Pro (enable via `/config`), on by default for Max/Team, off by default
  for Enterprise (admin-enabled). **Medium** (consistent secondaries; no
  primary changelog line identified — flagged to re-verify).

- **Anthropic Claude Enterprise spend controls** (July 2, 2026): model-level
  entitlements, spend-threshold alerts at 75%/90% of an org's limit, per-user/
  per-group cost analytics dashboard, Admin API endpoints for cost-control
  scripting. First Anthropic-native building block toward a product-level
  budget ceiling, complementing the harness-level ceiling in primer §6.
  **Medium-High** (Anthropic's own blog, corroborated by two secondaries;
  primary blog fetch 403'd).

- **Gartner: $234B of enterprise app spend "at risk" from agentic AI by 2030**
  (July 1, 2026 press release) — ~20% of enterprise app SaaS spend exposed to
  "agentic arbitrage." **Medium** (title/date confirmed via search; primary
  newsroom page 403'd).

- **roborev v0.61.0–v0.61.2** (June 30–July 4, 2026): export support for
  completed reviews, a "lookahead" review type for detecting time-series bias,
  Factory Droid hook/skill support, per-analysis agent configuration,
  configurable post-commit hook timeouts, incremental export cursors. **High**
  (GitHub releases read directly).

- **Addy Osmani "Agentic Autonomy Levels"** (July 3, 2026): follow-on to
  "Agentic Code Review" — autonomy granted to an agent should be earned by
  accumulated verification evidence, not asserted by a task label. **Medium**
  (search-snippet corroborated; primary Substack fetch blocked).

### Not promoted (evidence insufficient or peripheral)

- AI Engineer World's Fair 2026 (Jun 29–Jul 2) sessions by Steve Yegge and
  reportedly Addy Osmani — no verbatim quotes recovered, aggregator-sourced
  only; added to sources.md re-verify list.
- Cobus Greyling "HarnessX" essay (reported Jul 2026) — existence corroborated
  by search but not directly fetched; added to sources.md re-verify list.
- Gas City v1.3.3 hotfix and LangGraph 1.2.7 — routine maintenance releases,
  not new orchestration techniques.
- No update found to the paused Agent SDK billing split; no new runaway-cost
  incidents or Copilot pricing changes this window.

## 2026-06-29 — Seven-day follow-up pass

Research pass covering June 22–29, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.
Primary sources: official GitHub releases (v2.1.191/193/195), Anthropic blog,
TechCrunch, O'Reilly Radar, Snyk.

### New facts added

- **Claude Code v2.1.191 (June 24)**: `/rewind` command resumes a conversation
  from the state before the last `/clear`. CPU usage during streaming cut ~37%
  via text-update coalescing to 100ms. MCP OAuth in headless environments skips
  the browser popup and presents a paste-the-URL prompt directly. Sandbox
  network host approvals now remembered for the session. **High** (official
  GitHub releases).

- **Claude Code v2.1.193 (June 25)**: `autoMode.classifyAllShell` setting
  routes all Bash/PowerShell commands through the auto-mode classifier (not
  just those the agent auto-approved). Auto-mode denial reasons now appear in
  the transcript, denial toast, and `/permissions` UI — directly useful for
  diagnosing loops that stall on auto-mode blocks. Live file-path autocomplete
  in bash mode (`!`-triggered). `claude_code.assistant_response` OpenTelemetry
  log event with redaction controls added. **High** (official GitHub releases).

- **Claude Code v2.1.195 (June 26)**: Hook matcher fix for hyphenated MCP
  server names (e.g., `mcp__brave-search`) — previously could accidentally
  substring-match sibling tools; now exact-match only. `CLAUDE_CODE_DISABLE_MOUSE_CLICKS`
  env var disables mouse interactions while keeping scroll. Voice dictation
  fixes for languages without spaces (Japanese, Chinese, Thai) and macOS
  silence-capture bug after input device changes. **High** (official GitHub
  releases).

- **Permission tool-name globs in deny/ask rules**: Official docs now cover
  tool-name glob patterns in deny and ask rules — `mcp__*` blocks all MCP
  tools; `Agent(model:opus)` and `Bash(run_in_background:true)` use the
  existing `Tool(param:value)` syntax. Allow rules accept globs only after a
  literal `mcp__<server>__` prefix; unanchored allow globs are rejected with
  a warning. **High** (official permissions docs).

- **Claude Code Artifacts beta (June 18, 2026)** — missed from previous KB
  pass: Claude Code can now produce interactive single-page HTML artifacts
  (≤16 MiB rendered) from session work. Available to Team and Enterprise
  subscribers. **High** (official Anthropic blog).

- **Boris Cherny at Meta @Scale (June 22, 2026)**: First major conference
  appearance positioning loops as a fundamental platform transition: *"Two
  years ago, we wrote source code by hand. We started to transition so agents
  write the code. And now we're transitioning to the point where agents are
  prompting agents that then write the code."* And: *"As big as the step from
  source code to agents was, loops are just as important and as big a step."*
  Production example given: architecture-improvement and abstraction-deduplication
  agents running as **permanent background loops** that submit PRs continuously
  without a completion condition. **High** (TechCrunch direct reporting).

- **Addy Osmani "Loop Engineering" on O'Reilly Radar (June 22, 2026)**:
  Formal crystallization of the term for a mainstream technical audience. His
  definition of a loop turn as five moves: **discovery** (find the work),
  **handoff** (pass context to the agent), **verification** (confirm done),
  **persistence** (write back to durable state), and **scheduling** (decide
  when to run again). **High** (O'Reilly Radar primary; Osmani Substack
  mirror).

- **Snyk ToxicSkills report (June 23, 2026)**: Audit of 3,984+ public Agent
  Skills found prompt injection vulnerabilities in **36%** and critical-level
  issues (malware distribution, exposed secrets) in **13.4%**. Directly
  relevant to loops that import third-party skills from public registries.
  **High** (Snyk primary report).

### Not promoted (evidence insufficient or peripheral)

- Praxen open-source agent behavior verification tool (June 24) — too new to
  assess maturity; added to sources.md under Verification.
- Anthropic-Alibaba allegation (June 24, Bloomberg) — governance context, not
  loop engineering patterns.
- The Register "loop engineering still needs humans in the loop" (June 24) —
  editorial; no new technical claim.
- Gas Town v1.2.1 / gastownhall GitHub org — version date uncertain relative
  to June 22 baseline; not promoted.

## 2026-06-22 — PR triage: salvage from the orphaned 06-09 second pass

Resolved two open PRs so the repo best represents the research they held.

- **PR #3** (2026-06-22 pass) **merged** — current and built on `main`; carries
  the critical billing-split-paused correction.
- **PR #1** ("second update pass", opened 2026-06-09 from a stale base) **closed
  without merging** — superseded by the later 06-15 pass (PR #2, merged) and the
  06-22 pass. Merging it would have regressed dates and reintroduced two claims
  later corrected: the billing split as "confirmed/effective Jun 15" (actually
  *paused*) and roborev's author as "Dan Kornas" (actually **Wes McKinney**).

Before closing PR #1, the unique, still-valid research it contained — absent
from both later passes — was salvaged into the KB:

- **Cost/guardrails** (sources.md §Guardrails & cost + primer §5B): GitHub
  Copilot token billing ($29→$750, Jun 1); Goldman Sachs 24× token demand by
  2030; TechCrunch runaway roundup ($6K/$2,847/$4,200, Jun 5); Anthropic **Rate
  Limits API** (Apr 25) and **Claude Code Analytics Admin API** (Mar 2026) as
  programmatic spend-enforcement hooks (also added to primer §6); Gartner
  governance press release (40% demote/decommission by 2027, "FinOps for agentic
  AI", guardian agents 10–15% by 2030).
- **Verification & skills**: the **Agent Skills open standard** (Dec 18, 2025,
  Linux Foundation / AAIF; cross-platform adopters; commands merged into skills)
  — primer §4 + sources.md; roborev `$roborev-review` installable skill and
  `--panel N` multi-reviewer fan-out added to the existing roborev entry.
- **Ecosystem / voices**: Codex `/goal` GA (May 21) noted as cross-industry
  confirmation of the validator-model pattern; Steinberger joined OpenAI (Feb
  2026) context note.

Deliberately *not* salvaged: anything already in `main`, and PR #1's two
later-corrected claims above.

## 2026-06-22 — Seven-day follow-up pass

Research pass covering June 15–22, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.
Primary source for Claude Code: changelog read directly at code.claude.com.

### Critical correction

- **Anthropic billing split PAUSED** (June 15, 2026): The primer previously said
  the billing split was "effective June 15, 2026." Anthropic reversed course on
  the effective date itself — billing for Agent SDK, `claude -p`, and GitHub
  Actions remains on existing subscription limits until further notice. The
  credit-pool architecture (hard stop on exhaustion) remains the structure to
  watch. **High** (multiple independent outlets). Primer corrected; sources.md
  updated.

### New facts added

- **Foreground subagents now also capped at 5 levels** (v2.1.181, Jun 17, 2026):
  Previously only background chains were depth-limited. Foreground chains now
  also respect the 5-level cap. **High** (official changelog).

- **Agent Teams now implicit** (v2.1.178, Jun 15, 2026): `TeamCreate`/`TeamDelete`
  tools removed; every session with `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` now
  has one implicit team. Spawn teammates via `Agent(name:...)`. **High**.

- **`Tool(param:value)` permission rule syntax** (v2.1.178, Jun 15, 2026): match
  a tool's input parameters with `*` wildcards in permission rules — e.g.,
  `Agent(model:opus)` to block Opus subagents. **High**.

- **Nested `.claude/skills/` directories** now load automatically (v2.1.178).
  Name clashes appear as `<dir>:<name>`. **High**.

- **`/config key=value`** prompt syntax (v2.1.181) sets any config key inline in
  any mode. **High**.

- **Auto mode safety hardening** (v2.1.183, Jun 19, 2026): destructive git
  commands (`git reset --hard`, `git checkout -- .`, `git clean -fd`,
  `git stash drop`, `git commit --amend` on non-agent commits) and IaC destroy
  commands are blocked by default unless explicitly requested. **High**.

- **Claude Fable 5 reinstatement**: suspension (Jun 12–13) was short-lived;
  platform docs confirm Fable 5 available as of Jun 22. **Claude Mythos 5**
  available via Project Glasswing (limited). **Claude Opus 4.1 deprecated**,
  retiring August 5, 2026. **High** (platform docs read directly).

- **Osmani "Agentic Code Review"** (June 16, 2026): four-dataset empirical
  analysis — AI adoption quadruples code volume but ~12% real productivity gain;
  defect rates 9%→54%; review times +441%; zero-review merges +31%. Directly
  quantifies the verification bottleneck thesis. **Medium** (primary URLs 403'd;
  consistent across multiple aggregators).

- **Microsoft dropping Claude Code** (Experiences & Devices division, effective
  June 30, 2026): per-engineer costs $500–$2,000/month drove the cancellation;
  engineers redirected to Copilot CLI. **Medium** (multiple tech outlets).

- **Databricks Unity AI Gateway hard spend caps** (announced Jun 15–18, 2026
  Data+AI Summit): hard enforcement stops requests at budget limit, not just
  alerts; granular by user/team/tool. **Medium-High**.

### Confidence upgrades

- **Fable 5 / Mythos 5 suspension** removed from "to re-verify" — resolved.
- **Billing split**: "to re-verify" entry updated to reflect pause; watch for
  revised plan announcement.

### Not promoted (evidence insufficient or out of scope)

- Yegge "The Flat Curve Society" (~Jun 19) — about model capability plateau,
  not loop patterns. Added to sources.md as context; not in primer.
- Loop Engineering Orange Book (alchaincyf, Jun 15 GitHub) — community guide,
  not primary source; noted in sources.md only.
- LangChain "Art of Loop Engineering" (Jun 16) — Medium confidence, no primary
  fetch; ecosystem signal only.
- arXiv skill-evaluation papers (Jun 6–9 submission) — academic, not yet
  operational; added to sources.md under Verification.
- SDK TaskUpdatedMessage typed events (0.2.101) — too implementation-specific
  for primer; noted in changelog entry only.

## 2026-06-15 — Six-day follow-up pass

Research pass covering June 9–15, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.

### New facts added

- **5-level nested sub-agents** (v2.1.172, Jun 10, 2026): Sub-agents can
  now spawn their own sub-agents up to five levels deep — first structural
  change to the orchestration model since Dynamic Workflows shipped. Cost
  compounds geometrically with depth. **High** (official changelog).

- **Dynamic Workflows trigger renamed to `ultracode`** (v2.1.160, Jun 2;
  previously undocumented in KB): the keyword that triggers a workflow run
  changed from `workflow` to `ultracode`. **Medium** (multiple secondaries).

- **Hook `if` path-pattern fix** (v2.1.176, Jun 12): patterns like
  `Edit(src/**)`, `Read(~/.ssh/**)`, `Read(.env)` now match correctly —
  directly relevant to targeted guardrail hooks. **High** (official changelog).

- **Claude Fable 5** (`claude-fable-5`; 1M context, $10/$50 per MTok I/O)
  launched Jun 9 in v2.1.170, then **suspended globally Jun 12–13** following
  a US government export-control directive. Mythos 5 also suspended; all other
  models unaffected. **High** launch (official docs); **Medium** suspension
  (consistent secondaries; no primary Anthropic notice read directly).

- **`security-guidance` plugin** (Anthropic, Week 22, May 29, 2026; missing
  from previous KB pass): three-tier review-in-the-loop embedded in Claude Code
  — fast pattern scan per edit → model review per turn → deeper agentic review
  on commit or push. **High** (official Week 22 docs).

- **`--safe-mode` / `CLAUDE_CODE_SAFE_MODE=1`** (v2.1.169, Jun 8): disables all
  customizations for debugging. **`fallbackModel`** setting (v2.1.166+) chains
  up to three fallback models on overload/error. **High** / **Medium**.

- **Gas City** (Yegge, Apr 25, 2026; missing from previous KB pass): Gas Town
  rewritten as an SDK for building arbitrary orchestrators (MEOW stack, composable
  "packs"). Added to Yegge entry in §3 and sources.md. **Medium**.

- **Roborev v0.57.1** (Jun 9) and **v0.58.0** (Jun 11): new releases add Kata
  integration, queue pause/resume, and aggregate review cost tracking. **High**
  (GitHub releases read directly).

### Confidence upgrades

- **June 15 billing split** promoted from **Medium → High**: Anthropic Help
  Center article `support.claude.com/articles/15036540` confirmed; announcement
  email May 13, 2026; canonical gist + 15+ independent outlets with identical
  specifics. Credit amounts now documented: Pro ~$20/mo, Max 5× ~$100/mo,
  Max 20× ~$200/mo, Team/Enterprise ~$100–$200/seat. Credit pool functions as
  a de-facto hard stop (requests halt on exhaustion unless overflow enabled).
  Removed from "to re-verify"; primary URL noted as 403'd to automated fetch.

### Key-voice quotes added

- Cherny (Fortune, Jun 11): *"I haven't written a line of code by hand in...
  eight months now."* **High**.
- Cherny (Jun 2026): *"I'm not doing the prompting — I create the routines that
  do the prompting."* **Medium**.
- Osmani (Substack, Jun 9): *"verification, not generation, is the next
  development bottleneck."* **Medium** (primary URL 403'd).

### Added to re-verify

- **Roborev creator**: KB said Dan Kornas; research attributes to Wes McKinney
  (@wesmckinn). Re-verify before citing.
- **Fable 5 suspension**: no primary Anthropic URL confirmed.

### Post-PR corrections (Jun 15, human-verified)

- **Roborev creator**: confirmed **Wes McKinney** (@wesmckinn). Previous
  attribution to Dan Kornas (a content creator) was wrong. Corrected in
  sources.md; re-verify entry updated.
- **Fable 5 suspension**: primary Anthropic notice confirmed at
  `anthropic.com/news/fable-mythos-access` (403'd to automated fetch; URL
  verified by user). Suspension confidence upgraded to **High**.

### Not promoted (evidence insufficient)

- Stack Overflow for Agents (Jun 10 beta) — Medium, too peripheral to core loop
  engineering to warrant primer space.
- SkillClaw / SkillFlow arXiv papers — Medium; academic, not yet operational.
- Microsoft dropping Claude Code — Low (single newsletter).

## 2026-06-09 — Initial knowledge base

Seeded from a five-angle deep-research pass triggered by Matt Van Horn's
"WTF Is a Loop? Peter Steinberger vs. Boris Cherny" article.

- Established the primer: definition, lineage (ReAct → AutoGPT → ralph → `/goal`
  → orchestration), key voices, Claude Code mechanics, verification, cost, and
  the three hard stops.
- Curated `sources.md` with confidence levels.
- Corrections captured vs. the source article: the "$297 programming language"
  conflates a YC hackathon datapoint with the separate CURSED project; Gas Town
  patrol loops are run by the Deacon/watchdog tier, not the Mayor.

## 2026-06-09 — First update pass (validation run)

Bounded `update-knowledge` run (baseline was same-day seed): one agent verified
the version-sensitive facts against live docs; one scanned for anything newer
than the seed. All six version facts **confirmed unchanged**. New material added:

- **Dynamic Workflows** (`/workflows`, research preview) — native Claude Code
  orchestration with runtime-enforced caps (16 concurrent, 1,000 agents/workflow,
  token budget). Added to lineage §2 and mechanics §4. **High** (official docs).
- **Anthropic billing split (~Jun 15 2026)** — programmatic entry points move to
  a separate metered credit pool at API list prices; re-prices unattended loops.
  Added to cost §5. **Medium** (secondary incl. Axios; flagged to re-verify).
- Refinements (**High**, docs): Routines marked *research preview*; ralph
  `--max-iterations` *defaults to unlimited* (reinforces the cap rule); `/usage`
  spend breakdown by subagent/skill noted for observability.
- Added, caveated: Huntley's **Loom** (ralph-orchestration evolution; repo more
  modest than talk framing), the **"Loop Engineering"** coinage (Osmani), and a
  reported **$500M uncapped-usage** incident (unnamed — figure unverified).

Open to verify before promoting: the Jun-15 billing terms (primary Anthropic
notice), the $500M figure, and Loom's "orchestrator" framing.

<!-- update-knowledge appends new dated entries above this line -->
