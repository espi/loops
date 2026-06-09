# Loops: the primer

> The canonical briefing for this repo. Last substantive update: 2026-06-09 (pass 2).
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
| **Orchestration loops** | Loops supervising *other* loops — concurrently, on a schedule, with durable state. | now (2026) | What Steinberger/Cherny mean. New vs. ralph: the loop (not the task) is the unit of work; loops dispatch/supervise sub-loops; scheduling replaces human kickoff; state is git-backed so it survives a crash. Now shipping natively — Claude Code **Dynamic Workflows** (§4) and Huntley's **Loom** (a "factory" orchestrator of ralph loops; open-source Rust monorepo at github.com/ghuntley/loom, proprietary license, no public releases yet). The field calls this **"Loop Engineering"** (Addy Osmani's coinage, crediting Steinberger + Cherny). |

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
  tasks into reusable skills.** *(Steinberger joined OpenAI in February 2026;
  this quote predates that role.)*
- **Boris Cherny** — created Claude Code (Sept 2024); now reportedly ~4% of all
  public GitHub commits. *"I don't prompt Claude anymore... My job is to write
  loops."* Landed **259 PRs in 30 days, every line written by Claude Code**
  (Dec 2025). Some days manages "thousands, or tens of thousands" of agents via
  subagents. His load-bearing advice: auto-permission mode, orchestrate many
  agents, use `/goal` or `/loop` to keep going, run in the cloud, and — *"the
  most important thing"* — **give the agent a way to verify its own work
  end-to-end.**
- **Steve Yegge's "Gas Town" → "Gas City"** (Jan 2026 → Apr 2026) — Gas Town
  was the canonical orchestration loop: 20–30 Claude Code instances, a **Mayor**
  coordinator, background **patrol** loops (the "Deacon" watchdog tier), and
  **git-worktree-backed state that survives crashes** so any agent can resume
  another's work. In April 2026, Gas Town was rewritten from scratch as
  **Gas City** — a composable Go SDK removing hardcoded roles in favour of
  declarative "packs", built by Julian Knutsen and Chris Sells (Yegge curates,
  not codes it). Adds a controller/supervisor reconciliation loop and a
  **Dolt**-backed versioned audit trail of every agent action. A "Gastown pack"
  ships as a drop-in migration path from Gas Town.

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
  report back; **Agent Teams** (experimental) add a shared task list + messaging.
- **Dynamic Workflows** (`/workflows`, research preview) — Claude writes an
  orchestration script that fans one task across many parallel subagents in the
  background, with caps **baked into the runtime**: 16 concurrent agents, **1,000
  agents/workflow**, a per-run token budget, and worktree isolation. The
  natural-language trigger keyword is `"ultracode"` (v2.1.157+; `"workflow"` still
  accepted). The `/deep-research` bundled workflow is the canonical example —
  it fans claims across independent subagents and adversarially cross-checks
  results before surfacing them. The native form of the orchestration-loop stage —
  guardrails enforced by the runtime, not just your harness.
- **Observability** — `/usage` breaks spend down by skill / subagent / plugin /
  MCP, which is how you find what a loop is actually costing.
- **Skills** — a `SKILL.md` (frontmatter + instructions) Claude invokes
  automatically or via `/name`. The "skills not prompts" durable asset:
  version-controlled, testable, loaded on demand. `/loop` itself is one.
  As of December 2025, Anthropic open-sourced the **Agent Skills specification**
  (now governed by the Agentic AI Foundation / Linux Foundation); adopters include
  Codex CLI, GitHub Copilot, Cursor, and VS Code — a skill built for Claude Code
  is portable across platforms. Custom commands (`.claude/commands/`) have been
  merged into skills. Skills support `run: subagent` frontmatter for automatic
  subagent dispatch. Use `--safe-mode` (or `CLAUDE_CODE_SAFE_MODE=1`) to start
  Claude Code with all skills/hooks/plugins disabled for clean troubleshooting;
  `disableBundledSkills` hides bundled skills and built-in slash commands.

## 5. The two things the hype skips

**A) Verification is the whole game.** A loop is only as good as its ability to
check its own work; an open loop with no feedback is a machine for generating
confident mistakes. Give every loop one deterministic check (`npm test`,
`pytest`, `tsc --noEmit`, a linter) and run it *inside* the loop. Anthropic's
name for the pattern: **evaluator-optimizer** (one model generates, another
evaluates and feeds back). Tools like **roborev** operationalize this per-commit;
roborev now ships an installable `$roborev-review` Agent Skill (`roborev skills
install`) with a `--panel N` flag that fans a commit review to N independent
reviewer subagents whose verdicts are synthesized before surfacing results.

**B) The cost moved from tokens to loop management.** Once the model writes code
for almost nothing, the expensive part is *running the loop* — every turn
re-bills the full accumulated context (a session can grow from 5K to 200K
tokens/call; a 20-step loop can cost ~10x a naive per-step estimate). Receipts:
- **Uber capped engineers at $1,500/month per tool** after its CTO said it
  burned the annual AI budget in ~4 months.
- Self-reported horror stories: a multi-agent system that **looped 11 days and
  ran up $47K**; a TechCrunch investigation (June 2026) documented a **$6,000
  overnight run**, a **$2,847 four-hour runaway**, and a **$4,200 long-weekend
  refactor**; and a reported (unnamed, unverified) **$500M in one month** —
  treat the figure skeptically, but the failure mode is the point.
- **GitHub Copilot** moved to token-based billing June 1, 2026; developer reports
  cite costs jumping from $29/mo to $750/mo for heavy agentic use patterns.
  **Goldman Sachs** (May 2026) projects token demand rising **24× by 2030** as
  agentic workflows dominate.
- **Gartner** predicts **>40% of agentic AI projects canceled by end of 2027**
  (Jun 2025). A separate May 2026 Gartner press release adds: **40% of
  enterprises will demote or decommission production agents by end of 2027** due
  to governance gaps discovered post-deployment. Gartner identifies **"FinOps for
  agentic AI"** as an emerging Hype Cycle cluster and predicts **guardian agents**
  (agents monitoring other agents for scope drift and hallucination) will capture
  10–15% of the agentic AI market by 2030.

**Pricing shift (effective June 15 2026, confirmed):** Anthropic's Help Center
confirms programmatic entry points — Agent SDK, `claude -p`, Claude Code GitHub
Actions, subscription-authed third-party tools — move off the subscription bucket
onto a **separate metered credit pool at API list prices**. Credits per month: Pro
$20, Max 5× $100, Max 20× $200, Team/Enterprise $100–$200/seat. Interactive Claude
Code in the terminal, Claude.ai chat, and Cowork stay on subscription limits.
Overflow halts SDK/Agent SDK requests unless the user separately enables
pay-as-you-go "usage credits". Since unattended ralph/SDK loops run through exactly
those entry points, this directly re-prices them. *(High — primary Anthropic Help
Center article `support.claude.com/en/articles/15036540`.)*

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
