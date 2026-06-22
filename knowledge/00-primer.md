# Loops: the primer

> The canonical briefing for this repo. Last substantive update: 2026-06-22.
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
  — I create the routines that do the prompting."*
- **Steve Yegge's "Gas Town"** (open source, Jan 2026) — canonical orchestration
  loop: 20–30 Claude Code instances, a **Mayor** coordinator, background
  **patrol** loops (the "Deacon" watchdog tier), and **git-worktree-backed
  state that survives crashes** so any agent can resume another's work. Evolved
  into **Gas City** (Apr 25, 2026): Gas Town rewritten as an SDK
  (`claude-gastown`/MEOW stack) for building arbitrary agent orchestrators.

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
  removed. Spawn teammates via `Agent(name:...)`.
- **Dynamic Workflows** (`/workflows`, research preview) — Claude writes an
  orchestration script that fans one task across many parallel subagents in the
  background, with caps **baked into the runtime**: 16 concurrent agents, **1,000
  agents/workflow**, a per-run token budget, and worktree isolation. The native
  form of the orchestration-loop stage — guardrails enforced by the runtime, not
  just your harness. Trigger keyword: **`ultracode`** (renamed from `workflow` in
  v2.1.160, June 2, 2026).
- **Observability** — `/usage` breaks spend down by skill / subagent / plugin /
  MCP, which is how you find what a loop is actually costing. V2.1.174 added a
  per-skill/agent/plugin/MCP attribution breakdown (cache misses, long context,
  24h/7d) to the VS Code Account dialog.
- **Model availability** — **Claude Fable 5** (`claude-fable-5`; 1M context,
  128k output, $10/$50 per MTok I/O) launched June 9, 2026 (v2.1.170), was
  briefly suspended June 12–13 following a US government export-control
  directive, and is **back on the platform** as of June 22, 2026. **Claude
  Mythos 5** (`claude-mythos-5`) — limited availability via Project Glasswing
  since June 9; same pricing and context. **Claude Opus 4.1 is deprecated**
  (retiring August 5, 2026). All other models (Opus 4.8, Sonnet, Haiku)
  unaffected.
- **Diagnostic flags** — `--safe-mode` / `CLAUDE_CODE_SAFE_MODE=1` (v2.1.169+)
  disables all customizations (skills, hooks, MCP, plugins, themes) for debugging
  without affecting auth. `fallbackModel` setting (v2.1.166+) chains up to three
  fallback models tried in order on overload or error. `/config key=value`
  (v2.1.181+) sets any config key from the prompt in any mode.
- **Skills** — a `SKILL.md` (frontmatter + instructions) Claude invokes
  automatically or via `/name`. The "skills not prompts" durable asset:
  version-controlled, testable, loaded on demand. `/loop` itself is one.
  As of v2.1.178, skills in **nested `.claude/skills/` directories** load
  automatically; on name clash, both appear as `<dir>:<name>`.
- **`Tool(param:value)` permission rule syntax** (v2.1.178+) — match a tool's
  input parameters in permission rules using `*` wildcards: `Agent(model:opus)`
  blocks Opus subagents; `Bash(cmd:rm*)` restricts shell calls. Useful for
  fine-grained guardrail hooks in loop harnesses.
- **Auto mode safety hardening** (v2.1.183, June 19, 2026) — destructive git
  commands (`git reset --hard`, `git checkout -- .`, `git clean -fd`,
  `git stash drop`, `git commit --amend` on commits not made by the agent this
  session) and IaC destroys (`terraform`/`pulumi`/`cdk destroy`) are now blocked
  by default in auto mode unless explicitly requested. Directly relevant to
  loops that run git or infrastructure operations autonomously.

## 5. The two things the hype skips

**A) Verification is the whole game.** A loop is only as good as its ability to
check its own work; an open loop with no feedback is a machine for generating
confident mistakes. Give every loop one deterministic check (`npm test`,
`pytest`, `tsc --noEmit`, a linter) and run it *inside* the loop. Anthropic's
name for the pattern: **evaluator-optimizer** (one model generates, another
evaluates and feeds back). Tools like **roborev** (v0.58.0, June 11, 2026;
now includes aggregate review cost tracking and Kata integration) operationalize
this per-commit. Anthropic's own **`security-guidance` plugin** (shipped Claude
Code Week 22) embeds a three-tier check directly inside the coding session: fast
pattern scan per edit → model review per turn → deeper agentic review on commit
or push. Osmani's corollary (June 9, 2026): *"verification, not generation, is
the next development bottleneck."* His follow-up essay "Agentic Code Review"
(June 16, 2026) quantified the gap across four independent 2026 datasets: AI
adoption **quadruples code volume** while delivering only **~12% real
productivity gain**; defect rates up from **9% to 54%**; code review times up
**441%**; zero-review merges up **31%**. Key finding: *"the hard part of
engineering moved from writing code to deciding whether to trust it."*

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
   lives in your harness.

## 7. The one-paragraph answer

Stop being the thing in the loop. Write the loop once, give it **skills** worth
calling and a **verification** step so it can check itself, **cap it**
(iterations + dollars + stall detection) so it provably halts, and let it run
on a schedule while you go decide *what* to build. Steinberger and Cherny are
describing the same animal from two sides.
