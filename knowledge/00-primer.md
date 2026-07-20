# Loops: the primer

> The canonical briefing for this repo. Last substantive update: 2026-07-20.
> Companion: [`sources.md`](sources.md) (every claim's source + confidence),
> [`CHANGELOG.md`](CHANGELOG.md) (dated updates).

## 1. What a loop actually is

A **loop** is a small program *you* write that drives a coding agent: it
prompts the agent, reads what it produced, decides whether the goal is met,
and if not, prompts again with updated context — repeating until a verifiable
stop condition is hit.

The shift in one sentence: **you stop being the thing inside the loop typing
prompts and become the author of the loop. The model becomes a subroutine.**

A chatbot is one LLM call; an agent is an LLM calling tools in a loop until the
job is done. What makes it a *loop* (vs. one-off prompting) is the **"done?"
decision** at the end of each pass — continue or stop based on observed output,
not stopping after one generation. Put differently: a loop is *cron plus a
decision-maker in the body* — the model, not a hardcoded branch, picks the next
action each tick.

## 2. The lineage (place any claim on this ladder)

Most online arguments are people pointing at different rungs and talking past
each other.

| Stage | What | When | Key point |
|---|---|---|---|
| **ReAct** | Academic reason→act→observe loop. One model, one loop, human watching. | Oct 2022 (arXiv:2210.03629, Princeton + Google) | Established the "think → act → observe → repeat" cycle every later agent instantiates. |
| **AutoGPT** | Goal-driven, self-prompting. | Mar 2023 | Famous for **spinning forever** — judged "am I done?" in natural language, which defaulted to "more work needed." No reliable stop condition = infinite loops + runaway bills. This failure defines everything after it. |
| **The ralph loop** | A bash one-liner piping a fixed prompt file into the agent repeatedly. | Jul 2025 (Geoffrey Huntley) | Innovation isn't the loop — it's **context discipline**: each iteration runs in a *fresh* context that reloads a fixed set of anchor files and uses **the filesystem on disk as memory** instead of growing the conversation. |
| **`/goal`** | Productized ralph: runs until a small **validator model** confirms done. | Apr–May 2026 (Codex first, then Claude Code) | The fix for AutoGPT's original sin — a separate, fresh model judges the stop condition instead of the worker grading its own homework. |
| **Orchestration loops** | Loops supervising *other* loops — concurrently, on a schedule, with durable state. | now (2026) | What Steinberger/Cherny mean. New vs. ralph: the loop (not the task) is the unit of work; loops dispatch/supervise sub-loops; scheduling replaces human kickoff; state is git-backed so it survives a crash. Now shipping natively — Claude Code **Dynamic Workflows** (§4) and Huntley's **Loom** (a "factory" orchestrator of ralph loops; self-described, repo still experimental). The field calls this **"Loop Engineering"** (Addy Osmani's coinage, crediting Steinberger + Cherny). |

**The ralph one-liner:**
```bash
while :; do cat PROMPT.md | claude ; done
```
The trick: the prompt stays the same while everything *around* it changes —
the codebase, test results, git history, a progress file. That external state
is what turns repetition into iteration.

**Myth to drop:** the "$297 programming language" story conflates two things.
The $297 was a Y-Combinator hackathon team shipping six repos overnight.
Huntley's actual language, **CURSED**, came from running Claude in a ralph loop
for ~3 months, with no single published cost figure.

## 3. The key voices

- **Peter Steinberger (@steipete)** — the tweet that lit the fuse (~Jun 7 2026):
  *"you shouldn't be prompting coding agents anymore. You should be designing
  loops that prompt your agents."* Companion point: **wrap repeated or hard
  tasks into reusable skills.**
- **Boris Cherny** — created Claude Code (Sept 2024); now reportedly ~4% of all
  public GitHub commits. *"I don't prompt Claude anymore... My job is to write
  loops."* Landed **259 PRs in 30 days, every line written by Claude Code**
  (Dec 2025). Some days manages "thousands, or tens of thousands" of agents via
  subagents. His load-bearing advice: auto-permission mode, orchestrate many
  agents, use `/goal` or `/loop` to keep going, run in the cloud, and — *"the
  most important thing"* — **give the agent a way to verify its own work
  end-to-end.** By June 2026 he added: *"I haven't written a line of code by
  hand in... eight months now"* and, on Routines: *"I'm not doing the prompting
  — I create the routines that do the prompting."* At Meta @Scale (June 22,
  2026) he framed the next transition: *"Two years ago, we wrote source code
  by hand. We started to transition so agents write the code. And now we're
  transitioning to the point where agents are prompting agents that then write
  the code"* — *"as big a step as source code → agents."* His production
  example: architecture-improvement and abstraction-deduplication agents
  running as **permanent background loops** that submit PRs continuously.
- **Steve Yegge's "Gas Town"** (open source, Jan 2026) — canonical orchestration
  loop: 20–30 Claude Code instances, a **Mayor** coordinator, background
  **patrol** loops (the "Deacon" watchdog tier), and **git-worktree-backed
  state that survives crashes** so any agent can resume another's work. Evolved
  into **Gas City** (Apr 25, 2026): Gas Town rewritten as an SDK
  (`claude-gastown`/MEOW stack) for building arbitrary agent orchestrators.
  Reportedly shipped a "Formulas 2.0" update in early July 2026 (convoy/drain
  control-flow primitives, Mayor reimplemented as a configurable skill, JSON
  output across the `gc` CLI) — **Medium** (consistent secondary detail, primary
  blog 403'd; re-verify).
- **Boris Cherny — "Steps of AI Adoption"** (~Jul 16–17, 2026, Anthropic site +
  X): a five-level maturity framework for org-wide AI adoption — **Gated (0)**
  → **Assisted (~1x)** → **Parallel (~10x)** → **Supervised autonomy (~100x)**
  → **AI-native (1,000x+)**. Anthropic org-wide sits at Step 3 by his account;
  he claims to personally operate at Step 4. Quote: *"I talk to engineers at
  other companies every day and hear the same thing: one person is 10x'ing
  their output with Claude but the rest of the org hasn't caught up."* — **High**
  (verbatim tweet text confirmed, consistent secondaries).
- **Addy Osmani — "Own the Outer Loop"** (Jul 9, 2026; reportedly the written
  version of his AI Engineer World's Fair 2026 closing keynote): follow-on to
  "Loop Engineering." Thesis: agents run the **inner loop** (investigate →
  implement → verify → repeat); the engineer must own the **outer loop** — the
  accountability boundary of evidence-before-shipping, the ship/block/modify
  verdict, and answerability for the outcome. Names three costs of
  over-delegation: **cognitive surrender**, **cognitive debt**, and
  **"orchestration tax."** Cites Sonar's 2026 State of Code report (42% of
  committed code AI-generated/assisted) and GitLab's June 2026 AI-accountability
  research. Directly reinforces this repo's "verification is not optional"
  stance from a different angle — the outer loop is a human role, not a check
  a loop can run on itself. — **Medium-High** (consistent detailed secondaries;
  primary Substack/blog 403'd).

## 4. How loops work in Claude Code

- **`/loop`** — bundled skill (v2.1.72+). `/loop 5m check the deploy` (fixed),
  `/loop check the deploy` (self-paced 1 min–1 hr), or bare `/loop`
  (PR-tending maintenance). **Cron under the hood**, but **session-scoped**: it
  only fires while Claude Code runs and is idle, and **does not run with the
  laptop closed.** Recurring tasks expire after 7 days. Stop with `Esc`.
- **`/goal`** (v2.1.139+) — sets a completion condition; works across turns
  until met. A **separate fresh model (defaults to Haiku)** returns yes/no after
  each turn; it's a session-scoped Stop hook. The validator **doesn't call
  tools**, so conditions must be provable from what the agent surfaces (e.g.,
  "all tests in test/auth pass and lint is clean").
- **`ralph-wiggum` plugin** — Anthropic's official in-session ralph via a Stop
  hook: `/ralph-loop "<task>" --completion-promise "COMPLETE" --max-iterations 50`.
  Note: `--max-iterations` **defaults to unlimited** and `--completion-promise`
  is fragile exact-string matching — always set the iteration cap yourself.
- **Cloud / "close your laptop"** — Claude Code on the web (`--remote`) runs in
  ephemeral isolated VMs behind a network proxy/allowlist. **Routines** (research
  preview) are the cloud scheduling that survives the laptop being closed (min
  interval ~1 hr).
- **Subagents** (the Task tool) spawn child agents with their own context that
  report back. **As of v2.1.172 (June 10, 2026), sub-agents can themselves spawn
  sub-agents up to 5 levels deep** — the first structural change to the
  orchestration model since Dynamic Workflows. Each frame carries its own system
  prompt and model; cost compounds geometrically with depth. **As of v2.1.181
  (June 17, 2026), foreground subagents are also capped at 5 levels** — closing
  a gap where foreground chains were previously uncapped. **Agent Teams**
  (experimental, `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`): as of v2.1.178
  (June 15, 2026), every session has one implicit team; `TeamCreate`/`TeamDelete`
  removed. Spawn teammates via `Agent(name:...)`. **v2.1.198 (July 1, 2026)**:
  subagents run **in the background by default**; background agents launched via
  `claude agents` now **auto-commit, push, and open a draft PR** on finishing
  work in a worktree instead of stopping to ask first — a real autonomy increase
  to weigh against this repo's "confirm before hard-to-reverse actions" default;
  the built-in Explore agent now inherits the session's model (capped at Opus)
  instead of always running on Haiku; the `/agents` wizard was removed (manage
  subagents by asking Claude or editing `.claude/agents/` directly). **v2.1.199
  (July 2, 2026)**: subagents cut off by rate limits or server errors now
  **return partial work instead of silently misreporting success** — closes a
  gap where a loop harness could have logged a false "done" on a truncated
  subagent run; `CLAUDE_CODE_RETRY_WATCHDOG` raises the default retry count to
  300 and removes the previous 15-retry cap on `CLAUDE_CODE_MAX_RETRIES`.
- **Dynamic Workflows** (`/workflows`) — Claude writes an
  orchestration script that fans one task across many parallel subagents in the
  background, with caps **baked into the runtime**: 16 concurrent agents, **1,000
  agents/workflow**, a per-run token budget, and worktree isolation. The native
  form of the orchestration-loop stage — guardrails enforced by the runtime, not
  just your harness. Trigger keyword: **`ultracode`** (renamed from `workflow` in
  v2.1.160, June 2, 2026). Reported to have reached **Pro-plan general
  availability around July 2, 2026** — off by default on Pro (enable via
  `/config`), on by default for Max/Team, off by default for Enterprise
  (admin-enabled) — **Medium confidence**: consistent across secondary outlets
  but no primary changelog line found; re-verify before treating as settled.
- **Observability** — `/usage` breaks spend down by skill / subagent / plugin /
  MCP, which is how you find what a loop is actually costing. V2.1.174 added a
  per-skill/agent/plugin/MCP attribution breakdown (cache misses, long context,
  24h/7d) to the VS Code Account dialog.
- **Model availability** — **Claude Sonnet 5** (`claude-sonnet-5`) became Claude
  Code's **default model** in v2.1.197 (June 30, 2026) — native 1M-token
  context, promotional pricing $2/$10 per MTok input/output through August 31,
  2026. **Claude Fable 5** (`claude-fable-5`; 1M context, 128k output, $10/$50
  per MTok I/O) launched June 9, 2026 (v2.1.170), was briefly suspended June
  12–13 following a US government export-control directive, and is **back on
  the platform** as of June 22, 2026. **Claude Mythos 5** (`claude-mythos-5`)
  — limited availability via Project Glasswing since June 9; same pricing and
  context. **Claude Opus 4.1 is deprecated** (retiring August 5, 2026). All
  other models (Opus 4.8, Haiku) unaffected.
- **Diagnostic flags** — `--safe-mode` / `CLAUDE_CODE_SAFE_MODE=1` (v2.1.169+)
  disables all customizations (skills, hooks, MCP, plugins, themes) for debugging
  without affecting auth. `fallbackModel` setting (v2.1.166+) chains up to three
  fallback models tried in order on overload or error. `/config key=value`
  (v2.1.181+) sets any config key from the prompt in any mode. **`/rewind`**
  (v2.1.191, June 24, 2026) resumes a conversation from the state before the
  last `/clear` — useful when a loop clears context mid-run and you need to
  recover.
- **Auto-mode observability** (v2.1.193, June 25, 2026) — `autoMode.classifyAllShell`
  setting routes all Bash/PowerShell commands through the auto-mode classifier,
  not just agent-approved ones. Auto-mode denial reasons now appear in the
  transcript, denial toast, and `/permissions` UI — directly useful for
  diagnosing why a loop stalls.
- **Skills** — a `SKILL.md` (frontmatter + instructions) Claude invokes
  automatically or via `/name`. The "skills not prompts" durable asset:
  version-controlled, testable, loaded on demand. `/loop` itself is one.
  As of v2.1.178, skills in **nested `.claude/skills/` directories** load
  automatically; on name clash, both appear as `<dir>:<name>`. Since Dec 2025
  the **Agent Skills spec is an open standard** (Anthropic-authored, now under
  the Agentic AI Foundation / Linux Foundation), adopted by Codex CLI, Copilot,
  Cursor, VS Code, and ~40 additional products as of June 2026 — a skill
  written here is portable across those tools; custom commands
  (`.claude/commands/`) have been folded into skills. **Microsoft's Agent
  Skills for .NET** (Microsoft Agent Framework) exited experimental preview to
  **stable/GA on July 7, 2026** — a first-party .NET implementation of the same
  SKILL.md-based open format, another concrete adoption data point beyond the
  ~40-product figure above. *(High — Microsoft dev blog, corroborated.)*
- **`Tool(param:value)` permission rule syntax** (v2.1.178+) — match a tool's
  input parameters in permission rules using `*` wildcards: `Agent(model:opus)`
  blocks Opus subagents; `Bash(cmd:rm*)` restricts shell calls. **Tool-name
  glob patterns** in deny/ask rules also supported (e.g., `mcp__*` blocks all
  MCP tools); allow rules accept globs only after a literal `mcp__<server>__`
  prefix. Useful for fine-grained guardrail hooks in loop harnesses.
- **Auto mode safety hardening** (v2.1.183, June 19, 2026) — destructive git
  commands (`git reset --hard`, `git checkout -- .`, `git clean -fd`,
  `git stash drop`, `git commit --amend` on commits not made by the agent this
  session) and IaC destroys (`terraform`/`pulumi`/`cdk destroy`) are now blocked
  by default in auto mode unless explicitly requested. Directly relevant to
  loops that run git or infrastructure operations autonomously.
- **Hook matcher fix for hyphenated MCP names** (v2.1.195, June 26, 2026) —
  hook `if` matchers with hyphenated MCP server names (e.g., `mcp__brave-search`)
  were previously substring-matching unrelated tools; now exact-match only.
  Affects targeted guardrail hooks that restrict specific MCP servers.
- **`AskUserQuestion` no longer auto-continues** (v2.1.200, July 3, 2026) —
  question dialogs used to time out and auto-proceed; that's now opt-in via an
  idle-timeout setting in `/config`, so a loop can no longer silently sail past
  a question it raised. Same release renamed the default permission mode to
  **"Manual"** (previously `default`) across CLI/VS Code/JetBrains; the old
  value is still accepted.
- **Claude Code Artifacts** (beta, June 18, 2026; Team/Enterprise) — sessions
  can produce an interactive single-page HTML artifact (≤16 MiB rendered) from
  the work done; a new output type alongside files and PRs.
- **Claude Code v2.1.202–215 (July 6–19, 2026)** — 12 releases; primary changelog
  read directly. Most loop-relevant:
  - **v2.1.207 (Jul 11)**: **Claude Opus 4.8 becomes the default model on
    Bedrock, Vertex AI, and Claude Platform on AWS** (Claude Code elsewhere
    still defaults to Sonnet 5); auto mode is now available on those three
    platforms without the previous `CLAUDE_CODE_ENABLE_AUTO_MODE` opt-in.
  - **v2.1.212 (Jul 17)**: three new **native runaway-loop caps** — a
    session-wide WebSearch cap (default 200,
    `CLAUDE_CODE_MAX_WEB_SEARCHES_PER_SESSION`), a per-session subagent-spawn
    cap (default 200, `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION`, reset by
    `/clear`), and MCP tool calls running over 2 minutes auto-moving to
    background (`CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS`) — direct product-level
    reinforcement of this repo's §6 stall/iteration hard stops, shipped by
    Anthropic rather than left to the harness. Same release: **`/fork` now
    copies a conversation into a new background session** (its own `claude
    agents` row) instead of an in-session subagent — the old in-session
    behavior moved to **`/subtask`**; the Task tool's `mode` param is
    deprecated, subagents now inherit the parent session's permission mode by
    default.
  - **v2.1.214 (Jul 18)**: new `EndConversation` tool lets Claude end sessions
    with abusive users or jailbreak attempts. ~58 security/stability fixes,
    including a Windows PowerShell 5.1 permission-check bypass and several
    Bash permission-analyzer bypasses (long commands, zsh subshells,
    `help`/`man` auto-approval) — relevant to any loop harness that gates
    shell commands via permission rules.
  - **v2.1.215 (Jul 19, latest)**: **Claude no longer auto-invokes the
    `/verify` and `/code-review` skills on its own initiative** — they now
    require explicit invocation. Directly affects this repo: the `verify` and
    `code-review` skills listed here will no longer self-trigger after edits:
    a loop that relied on that implicit behavior must now call them explicitly
    as part of its verification step (see primer §5A).
  - Also: `/doctor` becomes a full setup-checkup tool with a `/checkup` alias
    (v2.1.205, Jul 8); opt-in screen-reader accessibility mode via
    `--ax-screen-reader` / `CLAUDE_AX_SCREEN_READER=1` (v2.1.208, Jul 14);
    `/config`'s new "Dynamic workflow size" knob (small/medium/large, advisory
    not enforced) plus `workflow.run_id`/`workflow.name` OTel attributes
    (v2.1.202, Jul 6) — the first concrete config surface for the Dynamic
    Workflows feature this primer previously could only source to Medium
    confidence.
- **Anthropic's own loops taxonomy** (`claude.com/blog/getting-started-with-loops`,
  reportedly Jul 7, 2026) — an official post naming four loop types: turn-based
  (manual), goal-based (`/goal`), time-based (`/loop`), and a new **`/schedule`**
  primitive for event/schedule-triggered loops that run until disabled (distinct
  from cloud Routines' laptop-closed scheduling). **Medium** — primary blog
  403'd this pass; multiple independent secondaries converge on identical
  detail. Re-verify directly before treating `/schedule` as a confirmed command;
  if confirmed, it belongs alongside `/loop`/`/goal` above.

## 5. The two things the hype skips

**A) Verification is the whole game.** A loop is only as good as its ability to
check its own work; an open loop with no feedback is a machine for generating
confident mistakes. Give every loop one deterministic check (`npm test`,
`pytest`, `tsc --noEmit`, a linter) and run it *inside* the loop. Anthropic's
name for the pattern: **evaluator-optimizer** (one model generates, another
evaluates and feeds back). Addy Osmani's canonical loop-turn anatomy (O'Reilly
Radar, June 22, 2026) names five moves: **discovery** → **handoff** →
**verification** → **persistence** → **scheduling**; verification is the pivot
that distinguishes a loop from a one-shot generation. Tools like **roborev**
(latest v0.63.0, July 16, 2026 — up from v0.61.2 baseline; v0.62.0 tightened
auto-invocation to require explicit user request before Codex/Claude Code can
trigger its skills, v0.62.1 added persistent CI panel metrics, v0.63.0 added
CI quiet-hours throttling and machine-readable launch receipts for
automation — the v0.62.x auto-invocation tightening mirrors Claude Code's own
v2.1.215 move away from silently self-triggering review skills) operationalize
this per-commit. Anthropic's own **`security-guidance`
plugin** (shipped Claude Code Week 22) embeds a three-tier check directly
inside the coding session: fast pattern scan per edit → model review per turn →
deeper agentic review on commit or push. Osmani's corollary (June 9, 2026):
*"verification, not generation, is the next development bottleneck."* His
follow-up essay "Agentic Autonomy Levels" (July 3, 2026) extends the thesis one
step further: the autonomy granted to an agent should be **earned by
accumulated verification evidence, not asserted by a task label** — a direct
argument for this repo's per-loop verification-step requirement over
self-declared "done." (**Medium** — search-snippet corroborated, primary
Substack fetch blocked.) His earlier "Agentic Code Review" (June 16, 2026) quantified the gap across
four independent 2026 datasets: AI adoption **quadruples code volume** while
delivering only **~12% real productivity gain**; defect rates up from **9% to
54%**; code review times up **441%**; zero-review merges up **31%**. Key
finding: *"the hard part of engineering moved from writing code to deciding
whether to trust it."* **Skills supply-chain risk**: a Snyk audit of 3,984+
public Agent Skills (ToxicSkills report, June 23, 2026) found prompt injection
vulnerabilities in **36%** and critical issues (malware distribution, exposed
secrets) in **13.4%** — treat untrusted public skills as untrusted dependencies
and audit before importing into a loop harness.

**B) The cost moved from tokens to loop management.** Once the model writes code
for almost nothing, the expensive part is *running the loop* — every turn
re-bills the full accumulated context (a session can grow from 5K to 200K
tokens/call; a 20-step loop can cost ~10x a naive per-step estimate). Receipts:
- **Uber capped engineers at $1,500/month per tool** after its CTO said it
  burned the annual AI budget in ~4 months.
- Self-reported horror stories: a multi-agent system that **looped 11 days and
  ran up $47K**; overnight Claude Code runs hitting thousands of dollars; and a
  reported (unnamed, unverified) **$500M in one month** after deploying with no
  usage caps — treat the figure skeptically, but the failure mode is the point.
- **Gartner** puts agentic AI at the "Peak of Inflated Expectations" (~17% of
  orgs have deployed agents) and predicts **>40% of agentic AI projects
  canceled by end of 2027**.
- **Microsoft** cancelled most internal Claude Code licenses in its Experiences
  & Devices division, effective June 30, 2026, after per-engineer costs reached
  $500–$2,000/month. Engineers redirected to GitHub Copilot CLI. *(Medium —
  multiple tech outlets.)*
- The re-pricing is industry-wide: **GitHub Copilot** moved to token-based
  billing June 1, 2026 (reported $29→$750/mo for heavy agentic use), and
  **Goldman Sachs** projects token demand rising **24× by 2030**. A June 5 2026
  TechCrunch roundup logged a **$6,000 overnight run**, a **$2,847 four-hour**
  runaway, and a **$4,200 long-weekend** refactor — the same failure mode at
  smaller scale than the $47K/$500M headlines. *(High / Medium per source.)*
- Beyond the cancellation stat, **Gartner** predicts 40% of enterprises will
  **demote or decommission** production agents by end of 2027 over governance
  gaps, names **"FinOps for agentic AI"** as an emerging discipline, and expects
  **guardian agents** (agents watching agents for scope drift) to be 10–15% of
  the market by 2030. *(High.)* A follow-up Gartner release (July 1, 2026) puts
  a number on the flip side of the same trend: up to **$234B of enterprise
  application software spend "at risk"** from agentic AI by 2030 (~20% of
  enterprise app SaaS spend) as agents complete cross-system tasks without a
  human touching the underlying app. *(Medium — title/date confirmed, primary
  newsroom page fetch blocked.)*
- **Ramp launched cross-provider AI Token Spend Management** (July 16, 2026):
  a dashboard pulling token/subscription costs from OpenAI, Anthropic, and
  Google Gemini into one view, with weekly usage briefings, invoice
  reconciliation against actual usage, and real-time overrun alerts. Ramp
  reports **20.7× growth** in AI token spend across its customer base since
  June 2025. A new entrant in the budget-observability category alongside
  AgentGuard and the Rate Limits/Analytics Admin APIs below — notable because
  it's a finance-side tool reading spend across providers, not a harness-level
  guard. *(High — corroborated by PR Newswire, SiliconANGLE, and Ramp's own
  blog.)*
- **Anthropic shipped Claude Enterprise spend controls** (July 2, 2026): per-model
  entitlements, spend-threshold alerts firing at 75%/90% of an org's limit, a
  per-user/per-group cost analytics dashboard, and Admin API endpoints for
  scripting cost-control workflows (auto-flagging users near their limit,
  reviewing increase requests). This is the first Anthropic-native building
  block toward the §6 budget-ceiling hard stop that ships as a *product feature*
  rather than something you have to wire up yourself via the Rate Limits API —
  though it's an alerting/entitlement layer, not confirmed to hard-stop a
  request the way a harness-level ceiling does. *(Medium-High — Anthropic's own
  blog post, corroborated by two independent secondaries; direct fetch of the
  primary blog was blocked.)*

**Pricing shift (announced May 2026; paused June 15, 2026):** Anthropic announced
it would move *programmatic* entry points — Agent SDK, `claude -p`, Claude Code
GitHub Actions, subscription-authed third-party tools — off the subscription
bucket onto a **separate metered credit pool billed at API list prices**
(Pro ~$20/mo, Max 5× ~$100/mo, Max 20× ~$200/mo, Team/Enterprise ~$100–$200/seat).
On June 15, 2026 — the scheduled effective date — **Anthropic reversed course**:
Agent SDK billing remains on existing subscription limits until further notice;
advance notice will be given before any revised plan launches. The original plan
would have meant 12–175× effective price increases for heavy programmatic users.
The credit-pool architecture (and its hard-stop-on-exhaustion mechanic when the
pool is exhausted and overflow disabled) is the structure to track when the change
eventually lands. *(Pause: High — multiple outlets consistent. Original plan:
High — Anthropic Help Center `support.claude.com/articles/15036540` confirmed,
15+ independent outlets.)*

## 6. The three hard stops (non-negotiable)

Every serious loop converges on these. Anthropic's Agent SDK ships #1 and #3 as
first-class params (`max_turns`, `max_budget_usd`).

1. **Max iteration count** — "prevent runaway sessions."
2. **No-progress / stall detection** — kill the loop if it repeats an action
   without advancing (usually a hook you write; libraries like AgentGuard offer
   `LoopGuard`).
3. **Token/dollar budget ceiling** — a hard *enforcement* stop, not an alert.
   The billing layer has soft alerts but won't auto-disable, so the ceiling
   lives in your harness. For programmatic enforcement, Anthropic's **Rate
   Limits API** (Apr 25, 2026) and **Claude Code Analytics Admin API** (Mar
   2026) expose org/workspace limits and per-user estimated cost, so a gateway
   can read spend and cut the loop off; third-party gateways (e.g. Databricks
   Unity AI Gateway) now hard-stop requests at a budget rather than just alert.

## 7. The one-paragraph answer

Stop being the thing in the loop. Write the loop once, give it **skills** worth
calling and a **verification** step so it can check itself, **cap it**
(iterations + dollars + stall detection) so it provably halts, and let it run
on a schedule while you go decide *what* to build. Steinberger and Cherny are
describing the same animal from two sides.
