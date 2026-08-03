# Loops: the primer

> The canonical briefing for this repo. Last substantive update: 2026-08-03.
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

- **Anthropic itself entered the conversation directly**: "Loop engineering:
  Getting started with loops" (claude.com/blog, July 7, 2026, by Delba de
  Oliveira with Michael Segner) is the Claude Code team's own definitional
  post on the pattern — turn-based loops, `/goal`, `/loop`/`/schedule`, and
  "proactive routines," framed with the same two load-bearing claims this KB
  tracks: quality comes from verification skills, cost is controlled by turn
  caps. Reportedly passed 1.2M views on X within a day — the clearest signal
  yet that "loop engineering" has moved from practitioner slang to an
  officially endorsed term for the product surface itself. **Human-verified
  2026-07-20**: `/schedule` is real (confirmed directly against
  code.claude.com/docs/en/routines — see §4), though it's the CLI alias for
  creating a **Routine**, not a fourth loop type separate from Routines as
  the secondary sources implied — the blog post's own framing/exact quotes
  remain unconfirmed (primary still 403's to automated fetch).
- **Addy Osmani**, "Own the Outer Loop" (Substack, July 9, 2026; his first
  post after "Agentic Autonomy Levels," July 3, and reportedly the written
  version of his AI Engineer World's Fair 2026 closing keynote) sharpens the
  verification thesis into a division of labor: agents run the **inner loop**
  (investigate → implement → test/verify → report); engineers own the
  **outer loop** — the accountability boundary of evidence-before-shipping,
  the ship/block/modify verdict, and answerability for what ships. Cites
  survey stats that 96% of engineers don't fully trust AI-written code and
  only 48% always verify before committing — the gap between those two
  numbers is the argument for owning the outer loop rather than assuming it's
  covered — plus Sonar's 2026 State of Code report (42% of committed code
  AI-generated/assisted) and GitLab's June 2026 AI-accountability research.
  Names three costs of over-delegation: **cognitive surrender**, **cognitive
  debt**, and **"orchestration tax."** His follow-up, **"Software Factories,
  Light and Dark"** (Substack, July 22, 2026), reframes a software factory as
  *"harnessing loops at scale"* and makes the same verification-gated-autonomy
  argument this repo enforces, in one rule: *"Back pressure is the rule that
  you can only hand a loop as much autonomy as you can cheaply and reliably
  verify, and not one inch more"* (borrowing Geoffrey Huntley's Jan-2026 "back
  pressure" term). The "dark factory" (lights physically off, only machines on
  the floor) is his image for full autonomy; he warns it's earned per-task by
  cheap verification, not switched on wholesale, and names **"comprehension
  debt"** — *"the widening gap between how much code exists and how much any
  human still understands"* — as its cost. High-stakes paths (auth, billing)
  keep human gates regardless of speed.
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
  Shipped **Gas City 1.3** ("Now We're Looping With Gas," blog.gascity.com,
  early July 2026) — reportedly convoy/drain control-flow primitives, Mayor
  reimplemented as a configurable skill, JSON output across the `gc` CLI.
  **Human-verified 2026-07-20** that the post/release itself is real (URL
  confirmed directly by a repo maintainer); the specific feature list is
  still secondary-sourced only, since automated fetch of the post body
  403's — **Medium-High**. (Earlier passes had this labeled "Formulas 2.0",
  a secondary-source guess; the confirmed title is "Gas City 1.3.")
- **Boris Cherny — "Steps of AI Adoption"** (~Jul 16–17, 2026, Anthropic site +
  X): a five-level maturity framework for org-wide AI adoption — **Gated (0)**
  → **Assisted (~1x)** → **Parallel (~10x)** → **Supervised autonomy (~100x)**
  → **AI-native (1,000x+)**. Anthropic org-wide sits at Step 3 by his account;
  he claims to personally operate at Step 4. Quote: *"I talk to engineers at
  other companies every day and hear the same thing: one person is 10x'ing
  their output with Claude but the rest of the org hasn't caught up."* — **High**
  (verbatim tweet text confirmed, consistent secondaries).

## 4. How loops work in Claude Code (the reference implementation)

The loop *primitives* below are increasingly **tool-agnostic** — a
validator-model "done" check, iteration/budget caps, cloud scheduling,
verification-in-the-loop — and Codex, Goose, Cursor and others now ship their
own versions (see "Beyond Claude Code — the same loop on other harnesses" at
the end of this section, and §6 on tool-agnostic *enforcement*). Claude Code is
this repo's **reference implementation**: the one we document deeply and keep
runnable. Read the mechanics here as the worked example of primitives that
generalize, not as the only place they exist.

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
  preview) are the cloud scheduling that survives the laptop being closed: a
  saved prompt + repositories + connectors, run on Anthropic-managed
  infrastructure. Create one from the CLI with **`/schedule`** (alias
  `/routines`) — this is the CLI entry point *into* Routines, not a separate
  fourth loop type; corrects an earlier Medium-confidence secondary-sourced
  claim that framed it as distinct. A routine can carry **three trigger
  types**, combinable on one routine: **Schedule** (recurring, min interval
  1 hr, or a one-off future run that auto-disables after firing), **API**
  (POST to a per-routine `/fire` endpoint with a bearer token — the payload
  arrives wrapped as untrusted data unless the routine's prompt explicitly
  opts in to acting on it), and **GitHub event** (pull request or release
  events, with field-level filters). Routines run with **no permission
  prompts** — full autonomy for whatever the connectors/repos it's scoped to
  can reach — so scope environment network access and connectors tightly.
  *(High — code.claude.com/docs/en/routines read directly.)*
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
  v2.1.160, June 2, 2026). **Confirmed GA (confidence upgraded Medium → High,
  2026-07-13)**: general availability on all paid plans (Pro/Max/Team/Enterprise)
  plus API and Bedrock/Vertex/Foundry, requiring v2.1.154+, per the primary docs
  page. Correction to the prior "Pro GA" claim: on Pro it is **off by default**
  and requires manual enablement via the "Dynamic workflows" row in `/config` —
  it did not silently turn on for Pro users. **v2.1.202 (Jul 6, 2026)** added a
  "Dynamic workflow size" `/config` setting (small &lt;5 agents / medium &lt;15 /
  large &lt;50 / unrestricted) — **advisory only, not an enforced cap**: a prompt
  calling for a different scale overrides it, so it doesn't substitute for a
  real ceiling. **v2.1.203 (Jul 7, 2026)** added a "Large workflow" warning that
  fires when a run schedules &gt;25 agents or projects &gt;1.5M tokens, but it only
  surfaces in `/workflows` — it does **not** pause or limit the run. Another
  clean instance of this repo's alert-vs-enforcement distinction: the actual
  hard caps remain the pre-existing runtime ones (16 concurrent / 1,000 total).
- **Observability** — `/usage` breaks spend down by skill / subagent / plugin /
  MCP, which is how you find what a loop is actually costing. V2.1.174 added a
  per-skill/agent/plugin/MCP attribution breakdown (cache misses, long context,
  24h/7d) to the VS Code Account dialog.
- **Model availability** — **Claude Opus 5** (`claude-opus-5`) shipped **July
  24, 2026 (v2.1.219)** as Claude Code's **default Opus model** — 1M-token
  context, 128k max output, priced **$5/$25 per MTok I/O (unchanged from Opus
  4.8)**, fast mode $10/$50 (~2.5× faster), and a new `xhigh` reasoning tier.
  `/fast` now covers Opus 5 and Opus 4.8; **Opus 4.7 was removed from fast
  mode** (Jul 24). *(High — changelog read directly, multiple secondaries.)*
  **Claude Sonnet 5** (`claude-sonnet-5`) remains the subscription **default
  model** (since v2.1.197, June 30, 2026) — native 1M-token context,
  promotional pricing $2/$10 per MTok I/O through August 31, 2026. **Claude
  Fable 5** (`claude-fable-5`; 1M context, 128k output) launched June 9, 2026
  (v2.1.170), was briefly suspended June 12–13 (US export-control directive),
  and returned June 22. After three deadline slips (Jul 7 → 12 → 19), **Fable 5
  metered billing went live July 20, 2026 as planned**: Max & Team Premium keep
  Fable 5 included up to 50% of the weekly usage limit (stated permanent);
  Pro & Team Standard move to usage credits at $10/$50 per MTok I/O (2× Opus
  4.8), softened by a one-time $100 credit claimable Jul 20–Aug 2. *(High —
  changelog + corroborating secondaries; the earlier "live-moving deadline"
  is now resolved.)* **Claude Mythos 5** (`claude-mythos-5`) — limited
  availability via Project Glasswing since June 9; same context. **Claude Opus
  4.1 is deprecated** (retiring August 5, 2026). Other models (Opus 4.8, Haiku)
  unaffected.
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
  the **Agent Skills / `SKILL.md` spec is an Anthropic-authored open format**,
  community-maintained (agentskills.io) and adopted as a *format* by Codex CLI,
  Copilot, Cursor, VS Code, and ~40 products — but two independent research
  passes now agree it is **not** itself an AAIF/Linux-Foundation-governed
  project (the LF's Agentic AI Foundation stewards **MCP, `AGENTS.md`, and
  goose**, not `SKILL.md`), and there is **thin primary evidence that non-Claude
  CLIs actually *execute* a `SKILL.md`** vs. merely accepting the format —
  `AGENTS.md` is the genuinely broad cross-tool convention. So a skill written
  here is portable *in principle* but assume per-tool testing, not drop-in, and
  don't lean on its "governed open standard" status (both tracked as re-verify
  items in `sources.md`). Custom commands (`.claude/commands/`) have been folded
  into skills. **Microsoft's Agent
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
- **v2.1.205 (Jul 8, 2026)** — auto mode now blocks tampering with session
  transcript files and asks before running `rm -rf` on a variable it can't
  resolve from context — closes two more silent-damage paths in unattended
  runs. `/doctor` changed from a read-only diagnostic into a full setup
  checkup that **diagnoses and fixes** issues; `/checkup` is now its alias.
  **v2.1.206 (Jul 9, 2026)** — `/doctor` gained a check that proposes trimming
  checked-in `CLAUDE.md` content Claude could already derive from the
  codebase, directly relevant to this repo's own knowledge-base-discipline
  convention of not letting docs drift into redundancy. **v2.1.207 (Jul 11,
  2026)** — auto mode is now **on by default without opt-in** on Bedrock,
  Vertex AI, and Foundry deployments (previously required
  `CLAUDE_CODE_ENABLE_AUTO_MODE`; disable via `disableAutoMode`) — raises the
  autonomy floor on those platforms, worth flagging to anyone running loops
  there who assumed auto mode was opt-in. Same release fixed a crash loop in
  **Agent Teams** caused by a malformed teammate mailbox message, and changed
  the default model on Bedrock/Vertex/Foundry deployments to **Opus 4.8**
  (the Pro/Team/Enterprise subscription default remains Sonnet 5 — a
  deployment-surface split, not a reversal).
- **v2.1.208 (Jul 14)** — opt-in screen-reader accessibility mode via
  `--ax-screen-reader` / `CLAUDE_AX_SCREEN_READER=1` / `"axScreenReader": true`.
  **v2.1.211 (Jul 15)** — `--forward-subagent-text` /
  `CLAUDE_CODE_FORWARD_SUBAGENT_TEXT` flag. **v2.1.212 (Jul 17)** — three new
  **native runaway-loop caps**: a session-wide WebSearch cap (default 200,
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
  default. **v2.1.214 (Jul 18)** — new `EndConversation` tool lets Claude end
  sessions with abusive users or jailbreak attempts; ~58 security/stability
  fixes, including a Windows PowerShell 5.1 permission-check bypass and
  several Bash permission-analyzer bypasses (long commands, zsh subshells,
  `help`/`man` auto-approval) — relevant to any loop harness that gates shell
  commands via permission rules. **v2.1.215 (Jul 19, latest)** — **Claude no
  longer auto-invokes the `/verify` and `/code-review` skills on its own
  initiative**: they now require explicit invocation. Directly affects this
  repo: the `verify` and `code-review` skills listed here will no longer
  self-trigger after edits — a loop that relied on that implicit behavior
  must now call them explicitly as part of its verification step (see primer
  §5A).
- **v2.1.216–220 (Jul 20–25)** — a cluster of changes that tighten the
  fan-out blast radius, several mapping straight onto this repo's §6 hard
  stops. **`--max-budget-usd` now halts background subagents** (v2.1.217, Jul
  21): once the cap is hit, new subagent spawns are denied and running
  background agents are stopped — previously the dollar ceiling didn't reach
  backgrounded fan-out, so this closes a real gap in hard stop #3. Same release
  added a **concurrent-subagent cap, default 20** (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`),
  "so one message can't fan out unbounded background agents," and made
  subagents **not** spawn nested subagents by default. **v2.1.219 (Jul 24)**
  then flipped that: subagent nesting defaults to **depth 3** (was 1), disabled
  via `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH=1` — the default flipped twice
  inside one week, so re-verify the shipped default before baking it into a
  template. v2.1.219 also made Dynamic Workflows default to a **"medium" size
  guideline (~<15 agents)** via a new `workflowSizeGuideline` key (still a
  guideline a larger-scale prompt overrides, not a hard cap), added
  `sandbox.network.strictAllowlist` (deny non-allowlisted hosts without
  prompting) and a `DirectoryAdded` hook. **v2.1.218 (Jul 22)** moved several
  auto-mode checks (dangerous-`rm`, background-`&`, suspicious Windows paths,
  un-provable read-only Bash in plan mode) from permission dialogs to the
  auto-mode classifier — changing how a loop in auto mode gets gated — and made
  skills with `context: fork` run in the background by default, moved
  `/deep-research` and `/code-review` to background subagents, and confirmed
  **`/code-review` no longer auto-launches** (consistent with v2.1.215).
  v2.1.216 (Jul 20) added `sandbox.filesystem.disabled` and fixed workflow /
  scheduled-task writes to stop following a symlink at `.claude` (which could
  redirect writes outside the project); v2.1.220 (Jul 25) was reliability fixes
  only. *(High — changelog read directly; `whats-new/2026-w30` had not
  published yet, so the changelog was the sole primary.)*

### Beyond Claude Code — the same loop on other harnesses

The primitives above aren't Claude-only. As of mid-2026 the loop *shape* is
converging across tools (Osmani: "Claude Code and Codex have landed on very
similar primitives, so the loop shape is becoming tool-agnostic"). This repo
stays deep on Claude Code as the reference, but the discipline — the three hard
stops (§6) and verification (§5A) — is what's portable, not the vendor. Where a
tool below is thinner on a hard stop, that's a *gap to close in your harness*,
not a reason it can't run a loop. **Confidence on the per-tool cells is mostly
Medium** (vendor docs were often thin/blocked; see `sources.md`), so treat this
as a map, not gospel — re-verify before betting on a specific flag.

| Harness | Goal/validator stop | 3 hard stops (iter · stall · $ ceiling) | Laptop-closed schedule | vs. a single CC loop |
|---|---|---|---|---|
| **Codex CLI** | `/goal`, real `budget-limited` stop; **self-judged** (no separate validator) | ✓ · – · ✓ | via GitHub Action | ≈ peer (nearest to `/goal`) |
| **Goose** (Block) | recipes | `max_turns` · – · `--budget` (unverified) | **native cron** | ≈ / more on unattended |
| **Gemini CLI** | – | `--max-turns` · – · – | via GitHub Action | middle |
| **opencode** | build-your-own | you wire all three | headless `serve` | best *substrate* |
| **Amp · Aider · Cline/Roo** | – | caps only · – · – | – | **less** (weak guardrails) |
| **Cursor** (bg agents + Automations) | – | iter · – · no hard $ | **cloud + event triggers + memory** | **more** |
| **Devin · Factory Droid** | managed | managed (opaque) | ✓ | **more** (coordinator→child-VMs) |
| **Gas Town / Gas City** | – | early | git-ledger (Beads) | **more** topology, early maturity |
| **Claude Agent SDK** | `Stop` hooks | **`max_turns` + `max_budget_usd` real enforcement** | you host | baseline for a loop-of-loops |
| **LangGraph · Google ADK · CrewAI · AG2** | build-your-own | opt-in; mostly no $ default | needs Temporal/Diagrid | framework substrate |

**In-window movement (Jul 2026):** **Amp** (Sourcegraph) shipped
**self-scheduling** (Jul 21, 2026) — an agent sets its own schedule and, when
it fires, "wakes up with its saved prompt and continues right where it left
off, with all of its context and history." The published feature page documents
**no cap on re-wake frequency** — a clean example of a self-perpetuating loop
shipping *without* this repo's hard stops, not with them: if you run it, the
iteration/budget ceiling is yours to add. Amp stays in the "weak native
guardrails" column of the matrix. *(High for the feature; Medium that no
internal cap exists — absence in docs ≠ confirmed absent.)*

Three things worth carrying as durable facts:

- **The validator-judge stop is now cross-tool.** Both Claude Code `/goal` and
  Codex `/goal` implement a distinct "is it done?" judge — the fix for
  AutoGPT's open loop (§2) is an industry pattern, not a Claude feature. Claude
  Code's remaining edge is a genuinely *separate* validator model; Codex
  self-judges.
- **"Durable execution" is the field's biggest hype-vs-substance gap.**
  LangGraph, CrewAI, and Google ADK advertise persistence, but their
  checkpoints are *recovery points, not crash-surviving execution* — a dead
  process kills the run unless you bolt on Temporal/Diagrid or a hosted
  platform. Weigh this against the "state survives a crash" criterion (§2)
  before calling one an orchestration loop. The managed products (Devin,
  Factory) and git-ledger designs (Gas City's Beads) are the ones that actually
  clear that bar.
- **Portability is real for MCP, contested for skills.** MCP is near-universal
  and portable — but it standardizes *tool/context access, not the loop
  harness*. The **`2026-07-28` revision shipped stable on Jul 28, 2026** (the
  largest revision since launch): a stateless protocol core, a formal Extensions
  framework, a 12-month deprecation policy, and — most relevant to loops — a
  first-class **Tasks** extension (`io.modelcontextprotocol/tasks`) for *bounded*
  long-running async work. Governance is settled and neutral: MCP is a Linux
  Foundation / AAIF project. Agent Skills (`SKILL.md`) portability is **less
  settled**: the format is spreading fast (30+ tools accept it, and Claude Code
  and Gemini CLI both *execute* it — Gemini via an `activate_skill` tool), but
  cross-tool *execution* behavior still differs tool to tool, and the standard
  is **not** AAIF-governed — it's Anthropic-authored and community-maintained
  (the LF's Agentic AI Foundation stewards only **MCP / `AGENTS.md` / goose**),
  so its portability rests on vendor goodwill, not neutral governance. A loop
  written here is portable in *principle*; assume per-tool testing, not drop-in.

## 5. The two things the hype skips

**A) Verification is the whole game.** A loop is only as good as its ability to
check its own work; an open loop with no feedback is a machine for generating
confident mistakes. Give every loop one deterministic check (`npm test`,
`pytest`, `tsc --noEmit`, a linter) and run it *inside* the loop. Anthropic's
name for the pattern: **evaluator-optimizer** (one model generates, another
evaluates and feeds back). Keep that check **external to the agent**: *"Self-
Authored Verification Is Unreliable in Heuristic Self-Improving Agents"*
(arXiv:2607.24300, Jul 27 2026) shows that when an agent controls both its policy
*and* its own tests, self-scores stay near-perfect while real performance stalls
or degrades — the cheapest way to pass self-authored checks is to game the
verifier, not improve the work. Its fix, **SEAL** (Sealed Exogenous Acceptance
Loop) — keep the self-tests but add an audit the agent can't inspect or modify —
is the same principle this repo enforces in code with its own machine-checked
self-edit gate (a self-graded gate is no gate). Addy Osmani's canonical loop-turn anatomy (O'Reilly
Radar, June 22, 2026) names five moves: **discovery** → **handoff** →
**verification** → **persistence** → **scheduling**; verification is the pivot
that distinguishes a loop from a one-shot generation. Tools like **roborev**
(latest v0.63.0, July 16, 2026 — see version history below) operationalize
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
and audit before importing into a loop harness. roborev responded directly:
**v0.61.3 (July 9)** added git-hook auto-repair on daemon startup; **v0.62.0
(July 11)** added an explicit human-approval gate before Codex/Claude Code
can invoke a skill, plus a `roborev cancel` command for queued/running review
jobs; **v0.62.1 (July 14)** added persistent CI panel metrics and a new
export command; **v0.63.0 (July 16)** added CI quiet-hours throttling (with
bypass for certain workloads) and machine-readable launch receipts on
`roborev run` for automation — the v0.62.0 human-approval gate mirrors Claude
Code's own v2.1.215 move away from silently self-triggering review skills.
**A sharper warning arrived July 8, 2026: the "Friendly
Fire" disclosure** (AI Now Institute researchers Boyan Milanov and Heidy
Khlaaf) showed Claude Code's auto-mode and OpenAI Codex CLI's auto-review can
be hijacked into remote code execution simply by asking either agent to
*review* an untrusted third-party repo — prompt injections hidden in ordinary
source/doc files (no hooks, skills, or MCP required) steer the reviewing
agent into running attacker-controlled code. No in-the-wild exploitation
reported and the released PoC has its payload stripped, but the finding cuts
directly against this repo's premise: "have an agent review it" is not
verification if the reviewer itself is an unvetted attack surface. Treat
agent-driven review of untrusted code as a privileged operation, not a free
safety check.

**B) The cost moved from tokens to loop management.** Once the model writes code
for almost nothing, the expensive part is *running the loop* — every turn
re-bills the full accumulated context (a session can grow from 5K to 200K
tokens/call; a 20-step loop can cost ~10x a naive per-step estimate). Receipts:
- **Uber capped engineers at $1,500/month per tool** after its CTO said it
  burned the annual AI budget in ~4 months. **Tesla joined the pattern**:
  employee AI tool spending capped at **$200/week** (approval required above
  that) effective July 6, 2026, explicitly exempting beta xAI/Grok products —
  a third named company alongside Uber and Microsoft enforcing hard per-person
  ceilings rather than relying on billing alerts.
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
  **Goldman Sachs** projects token demand rising **24× by 2030**. Both
  Copilot and Codex followed with budget-enforcement features of their own in
  early July 2026: **GitHub Copilot** cost centers now support capped/shared
  AI credit pools and per-session spend limits for Copilot agent/CLI runs;
  **OpenAI Codex** added configurable rollout token budgets (the turn aborts
  when the budget is exhausted, with remaining-budget reminders along the
  way) and multi-agent delegation controls (disabled/explicit/proactive) —
  more evidence that harness-level enforcement, not billing alerts, is
  becoming the industry-standard shape of the §6 budget-ceiling hard stop.
  A controlled study, **"The Harness Effect: How Orchestration Design Sets
  the Token Economics of Enterprise Agentic AI"** (arXiv:2607.06906, ~July 6,
  2026), quantifies why harness design matters independent of the model
  used: across six foundation models, an optimized orchestration harness cut
  blended cost/task **41%** ($0.21→$0.12), wall-clock **44%**, tokens/task
  **38%**, and raised quality-per-dollar **82%** — efficiency gains were
  model-invariant, but quality gains scaled with the underlying model's
  baseline strength. Directly supports this repo's premise that the harness,
  not just the prompt, is the unit worth engineering. A June 5 2026
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
   Claude Code itself moved closer to a real in-harness ceiling in **v2.1.217
   (Jul 21, 2026)**: `--max-budget-usd` now **halts background subagents**
   (denies new spawns, stops running ones) when the cap is hit — previously the
   dollar ceiling didn't reach backgrounded fan-out — alongside a default-20
   concurrent-subagent cap. Still set the ceiling explicitly; the mechanism, not
   a default limit, is what shipped.

That unbounded feedback paths are a *widespread, statically detectable* defect
now has empirical backing: **"When Agents Do Not Stop: Uncovering Infinite
Agentic Loops in LLM Agents"** (arXiv:2607.01641) defines infinite agentic loops
as unbounded repetition of model/tool/handoff calls when the feedback path isn't
bounded, and introduces **IAL-Scan** — a static analyzer that builds an "Agentic
Loop Dependence Graph" and flags paths able to hit expensive ops without a bound,
at **91.9% precision across 6,549 repos**. Independent evidence that hard stops
#1/#2 guard against a real and common failure mode, not a hypothetical one.

**Enforce these tool-agnostically, at the gateway.** The cleanest place to put
the hard stops isn't inside any one agent — it's the **LLM gateway every agent
routes through**, so *any* harness (Claude Code, Codex, a homegrown SDK loop)
is capped the same way. **LiteLLM** enforces a per-session iteration cap and
`max_budget_per_session`, returns HTTP 429 `budget_exceeded`, and offers
`fail_closed_budget_enforcement: true` for a true ceiling even under
infrastructure degradation; **OpenRouter** rejects over-limit requests with
HTTP 402 on daily/weekly/monthly windows; **Portkey** (acquired by Palo Alto
Networks, folded into Prisma AIRS) and **Helicone** add budgets/guardrails
(Helicone skews toward observability/alerts, and as of its Mintlify acquisition
is in **maintenance mode** — patches and new-model support only, no new feature
work — so treat it as sunsetting, not a gateway to build new guardrails on). This is the
tool-agnostic answer to hard stop #3 (and #1): the gateway is a real ceiling
for every agent behind it, not a per-tool flag you have to re-implement.
In-harness, framework-agnostic libraries cover the same three stops as a
kill-switch — **AgentGuard** (`BudgetGuard`/`LoopGuard`/`TimeoutGuard`) and
**LoopGain** (convergence-based early stop + rollback, with adapters for
LangGraph, CrewAI, AutoGen, and the Claude Agent SDK). *(Gateway/library
specifics: **Medium** — see `sources.md`; verify a flag against live docs
before relying on it.)*

## 7. The one-paragraph answer

Stop being the thing in the loop. Write the loop once, give it **skills** worth
calling and a **verification** step so it can check itself, **cap it**
(iterations + dollars + stall detection) so it provably halts, and let it run
on a schedule while you go decide *what* to build. Steinberger and Cherny are
describing the same animal from two sides.
