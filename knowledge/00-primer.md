# Loops: the primer

> The canonical briefing for this repo. Last substantive update: 2026-10-05.
> Companion: [`sources.md`](sources.md) (every claim's source + confidence, and the live backlog),
> [`CHANGELOG.md`](CHANGELOG.md) (dated updates); pre-2026-09-29 verbatim detail is in
> [`archive/primer-detail-2026-09.md`](archive/primer-detail-2026-09.md). Confidence tags are
> **High / Medium / Low** as recorded in `sources.md`; per-release, per-paper and correction-history
> detail lives there, not here.
>
> ⚠️ **How to read the numbers below.** A meta-analysis of 259 agentic-security papers — the corpus much
> of §5A rests on — finds most report no variance estimate or repeated runs, and that on a 100-instance
> benchmark *"the minimum difference in ASR detectable at conventional power is 18.2 percentage points"*,
> concluding *"cross-paper ASR comparison is currently unsupported"* (arXiv:2609.25173). **So: trust the
> mechanisms and directions across papers; trust magnitudes only within a single paper**, and read each
> benchmark's figure against the size *that* paper reports.

## 1. What a loop actually is

A **loop** is a small program *you* write that drives a coding agent: it
prompts the agent, reads what it produced, decides whether the goal is met,
and if not, prompts again with updated context — repeating until a verifiable
stop condition is hit.

The shift in one sentence: **you stop being the thing inside the loop typing
prompts and become the author of the loop. The model becomes a subroutine.**

A chatbot is one LLM call; an agent is an LLM calling tools in a loop until the job is done. What makes it
a *loop* is the **"done?" decision** at the end of each pass — continue or stop based on observed output.
Put differently: a loop is *cron plus a decision-maker in the body* — the model, not a hardcoded branch,
picks the next action each tick.

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
is what turns repetition into iteration. (Never run it like this — §6.)

**Myth to drop:** the "$297 programming language" story conflates a YC-hackathon team shipping six
repos overnight with Huntley's actual language, **CURSED**, which came from ~3 months of ralph looping
and has **no published cost figure** (detail in `sources.md`).

**"Graph engineering"** (Josh C. Simmons, Jul 4 2026: *"designing agentic systems as explicit graphs
instead of implicit loops"*) **demotes** the loop rather than replacing it, by its own account —
*"Inside a node, a model still runs the same loop it always ran."* Treat it as the orchestration rung at
a higher altitude; the "successor" claim stays contested. **High** (essay read directly).

## 3. The key voices

- **Anthropic** — "Loop engineering: Getting started with loops" (claude.com/blog, Jul 7,
  2026, Delba de Oliveira with Michael Segner): the Claude Code team's own definitional post
  (turn-based loops, `/goal`, `/loop`/`/schedule`, proactive routines; quality from
  verification skills, cost from turn caps). `/schedule` is the CLI entry into **Routines**,
  not a fourth loop type (**High**, docs); the post's exact quotes remain unconfirmed.
- **Addy Osmani** — the most consistent written statement of this repo's doctrine (Substack
  `addyo.substack.com` is the canonical index). The arc, each essay **High** unless noted:
  **"Own the Outer Loop"** (Jul 9): agents run the inner loop, engineers own the
  accountability boundary; **"Software Factories, Light and Dark"** (Jul 22): *"you can only
  hand a loop as much autonomy as you can cheaply and reliably verify, and not one inch
  more"*; **"Agentic Code Quality"** (Aug 8): quality lives in the constraints around agents;
  **"Practical Loop Engineering"** (Aug 14): *"One sub-agent drafts the change. A separate one
  verifies it"*, and the `/goal` evaluator *"doesn't look at the content"* — it checks the stop
  condition, not quality, so the deterministic check must encode "good"; **"Human judgment
  … relocates"** (Aug 21): a **verification budget**, cheap checks first; **"Audit your Agent
  files"** (Aug 27, **Medium-High**): configuration has a half-life, prune it; **"Agentic Skill
  Decay"** (Aug 31): *"you have to have that expertise to verify it"*; **"Brownfield Agentic
  Engineering"** (Sep 14): where no check exists yet, **pin behaviour in a separate pass or by
  a person before the loop runs** (*"A person draws the map, not the agent"*) — the
  checker-is-not-the-maker rule applied to building the check. **"The Code Nobody Reads"** (Sep 28):
  *"A test written or controlled by the thing it's testing doesn't prove much"* and *"Real independence
  comes from a different source of truth: a spec a person wrote, a reference implementation, a proof"* —
  an outside voice for §5A.1's *evidence*-independence property specifically. (Two statistics he cites
  are uncited upstream — see the backlog.) None of the essays address iteration caps, stall detection or
  budget ceilings.
- **Peter Steinberger** — the fuse (~Jun 7, 2026): *"you shouldn't be prompting coding agents
  anymore. You should be designing loops that prompt your agents"*; wrap repeated work into
  skills. Blog quiet since Feb 15, 2026; he publishes mainly on x.com, which is unfetchable.
- **Boris Cherny** — created Claude Code; *"My job is to write loops"*; 259 PRs in 30 days all
  written by Claude Code (Dec 2025); *"the most important thing"* is **giving the agent a way to
  verify its own work end-to-end**; permanent background loops submitting PRs (Meta @Scale, Jun
  22). "Steps of AI Adoption" (Jul 16–17, **High**): Gated → Assisted → Parallel → Supervised
  autonomy → AI-native. No enumerable first-party feed, so "nothing new from Cherny" is only
  ever **Medium**.
- **Steve Yegge** — Gas Town → **Gas City** (orchestration SDK; **v1.5.0 shipped 2026-10-05**, from
  `gastownhall/gascity` — the repo this KB had been tracking, `gastown`, has been dormant since June).
  *"The Shape of Things to Come"* (Aug 2): Gas Town *"fell apart at the seams with Opus 4.7"* — a model
  update silently broke a working loop, an argument for stall detection — and *"Harnesses need to be part
  of your application, chemically bonded in"*. *"Seats and Sunsets"* (Sep 15) is the failure report: his
  agents ratcheted to *"650 distinct refusal sites"* until *"We cut it down to 14 fences, and now I have
  to personally approve any new ones"* — independent support for **widening a guardrail envelope being
  human-authored only** — and a 24/7 factory costing *"around $12,000/month"*. *"Fences, not Sandboxes"*
  (Aug 24) reaches mechanical enforcement only by escalation from norms; this repo starts there. **High.**
- **Simon Willison** (**High**): loops need *"extraordinary discipline and knowledge"*; *"you can
  actually spend $1,000 in a day doing real work"* — a credible practitioner's number (his Uber cap has
  **no figure**; "$1,500" is **Low, do not cite**); and a first-hand pathology: `max` effort *"hit [the
  128,000 output limit] while it was still reasoning"* (n=2 SVG probe on Opus 5.5, **now replicated on
  Sonnet 5.5**, Sep 28). Consequence: **an iteration can consume its whole output budget and emit
  nothing**, so a stall detector must key on state change, not "did it respond".
  ⚠️ **And the outside voice this repo's third hard stop was missing** — "Default hard budget caps"
  (**Oct 3, 2026**): *"Soft caps, 'after $X/month, send me a warning email', will not cut it."* ·
  *"I think hard budget caps need to be the default. If someone wants to live dangerously they should be
  able to do that, but it needs to be on an opt-in basis."* He reaches it from coding agents specifically
  — they *"greatly reduce the friction of spinning up code that can do useful things"* that cost money.
  **Note what it adds, not just what it confirms: his subject is the pay-by-usage services a loop's
  *code* calls, a cost surface `guardrails/` does not yet cover.**
- **Geoffrey Huntley** — newest posts **Oct 2, 2026** (two, both readable; the "Sep 27, paywalled" record
  is superseded). *"software doesn't need to be readable anymore. it needs to be explainable."* carries
  **two techniques this primer did not have**: *"Types are a form of verification. They provide back
  pressure: compiler errors that the LLM picks up and fixes automatically, every loop."* and *"Pick a
  language that does the verification for you, and you need less intelligence to stay on the rails"* —
  **substrate choice as a verification-strength *and cost* lever** — plus simulator-first as a way to
  *build* the deterministic check: *"building it in Rust and building the simulator first, then driving
  the agent to validate everything through the simulator."* (The second Oct 2 post is organizational and
  off-angle.) Still useful: *"If you wrap the tool calls around another loop, it's just a loop. But
  there's a lot of science in the context engineering"*. **High.**

*Through Oct 5: Yegge and Osmani quiet after the posts above; **Ronacher published in-window but
off-topic** (record that, not "quiet"); **Steinberger's blog is quiet since Feb 15 but he posts mainly on
x.com, so his silence is a coverage gap, not a verified quiet**; Cherny has no enumerable feed, so his
absence is permanently **Medium**. Method traps (a feed's `<updated>` tracks regeneration, not new content
— confirmed live this pass; Willison's archive under-reports, use his Atom feed) are in `sources.md`.*

## 4. How loops work in Claude Code (the reference implementation)

The loop *primitives* — a validator-model "done" check, iteration/budget caps, cloud
scheduling, verification in the loop — are increasingly **tool-agnostic**; Claude Code is this
repo's **reference implementation**, documented deeply and kept runnable. Per-version detail is
in `sources.md` ("Claude Code mechanics" and the dated "Added" sections). **Attribute a feature
to the version its own doc page names**; some versions have no changelog heading (and there is
no v2.1.279). Read the changelog (`code.claude.com/docs/en/changelog`) directly — the weekly
`whats-new` digest lags and skips weeks, so it is not a reliable tripwire.

### The loop surfaces

- **`/loop`** — bundled skill (v2.1.72+ — minimum no longer citable against current docs,
  **Medium**). Fixed interval, self-paced (1 min–1 hr) or bare maintenance mode. **Cron under the
  hood, session-scoped**: fires only while Claude Code runs and is idle; **not with the laptop
  closed**; recurring tasks expire after 7 days. v2.1.281 fixed a wakeup storm that re-fired
  failed deliveries every second.
- **`/goal`** (minimums are now stated **per feature**, not per command — e.g. check-ins v2.1.234+,
  idle check-ins v2.1.236+) — a completion condition judged by a **separate fresh model (Haiku by
  default)** after each turn, implemented as a session-scoped Stop hook. The validator **doesn't call
  tools**, so conditions must be provable from what the agent surfaces — and it judges the stop
  condition, not content quality (Osmani, §3). Current behaviour: check-ins back off and are capped at
  three per goal while idle (v2.1.239/246); the goal survives resume and compaction (v2.1.239/274); it
  retries or pauses and says why instead of silently stalling (v2.1.269). Agent-set goals were
  explicitly declined (issue #70649).
  ⚠️ **Two things to get right about `/goal` and the hard stops.** Its **only documented way to bound a
  run is self-reported**: *"include a turn or time clause in the condition, such as `or stop after 20
  turns`. Claude reports progress against that clause each turn and the evaluator judges it from the
  conversation."* Since the evaluator *"does not call tools"*, that bound is narrated by the worker and
  graded from the narration — by §5A.3 and §5A.9 **a pacing hint, not hard stop #1**, so a `/goal` loop
  still needs an external cap. But it **does** ship genuine no-progress detection, keyed on absence of
  tool use: *"If Claude keeps answering the evaluator without making progress (no tool use for several
  turns in a row), Claude Code stops the loop, prints a warning, and returns control to you with the
  goal still set."* Note it **pauses awaiting a human rather than terminating** — useful attended, not
  a termination guarantee unattended. **High.**
- **`ralph-wiggum` plugin** — Anthropic's official in-session ralph via a Stop hook:
  `/ralph-loop "<task>" --completion-promise "COMPLETE" --max-iterations 50`.
  `--max-iterations` **defaults to unlimited** and `--completion-promise` is fragile
  exact-string matching — always set the cap yourself. **And the cap lives where the agent can
  reach it (High — source read directly):** the plugin keeps its iteration count in
  `.claude/ralph-loop.local.md` **inside the agent's worktree**, and `hooks/stop-hook.sh` only
  enforces the cap `if [[ $MAX_ITERATIONS -gt 0 ]]` (line 51) — so an agent that writes
  `max_iterations: 0` removes its own cap. See "instruments are removable" (§5A).
- **Cloud / "close your laptop"** — **Routines** survive a closed laptop (saved prompt + repos +
  connectors on Anthropic infrastructure, created with **`/schedule`**), with three combinable triggers:
  **Schedule** (min 1 hr), **API** (payload wrapped as untrusted data), **GitHub event**. Routines run
  with **no permission prompts**, so scope network and connectors tightly, and **locally configured MCP
  servers cannot attach**. ⚠️ **And a routine could report success it never had:** until v2.1.286,
  *"routine runs whose cloud session never started"* showed as **Succeeded** — this routine's own
  substrate, and one more instance of declared ≠ delivered. **High.**
- **Skills** — `SKILL.md` invoked automatically or via `/name`; version-controlled, testable, loaded on
  demand. Since v2.1.215 `/verify` and `/code-review` **no longer auto-invoke** — **a loop must call its
  verification step explicitly.** Hygiene tools: `/skill-doctor` (unused skills and their context cost)
  and `/doctor prompt-audit`. The Skills API is GA (**Medium-High**).

### Fan-out: what actually bounds it (current state)

- **Subagents** nest to **depth 3** with a **concurrency** cap of **20**; the lifetime per-session spawn
  cap was **removed in v2.1.224** and is now a documented no-op. The 20-cap has documented holes
  (ultracode sessions exempt, `/subtask` forks and resumed subagents bypass it, *"no hard limit on the
  number of teammates"*). **The only primitive that binds the whole tree is the dollar ceiling**:
  `--max-budget-usd` refuses new spawns, stops running background subagents and ends the query.
  **Say "spend cap", not "a cap of 20."** All three figures re-verified unchanged this window. **High.**
- **Dynamic Workflows** (`/workflows`, keyword `ultracode`) enforce caps at runtime: **16 concurrent
  agents** (raisable 1–256), **1,000 agents total per run** (*"Prevents runaway loops"*), a per-run token
  budget, worktree isolation, and `parallel()`/`pipeline()` lists capped at 4,096 with **rejection, not
  silent truncation**. The size guideline and "Large workflow" warning are **advisory only**, and the
  usage-limit pause applies only to **interactive** sessions — not `-p`, SDK or background runs. **High.**
- **Autonomy defaults moved up**: background agents commit, push and open a draft PR when the task calls
  for one; **auto mode is the default starting mode on every plan and provider from v2.1.283** — and the
  docs say auto mode is **not** containment. **High.**
- **Truncation is marked**: subagents cut off by errors or by `maxTurns` return output **marked partial**
  rather than appearing finished — so a loop can tell a truncated child from a finished one. **High.**

### Containment and permission primitives worth using

The per-version inventory lives in `sources.md` ("Claude Code mechanics"); the shape that matters here:
**deny-by-default exists** (`--permission-prompts none`), **managed settings fail closed** on a parse
error or one invalid nested value, **restriction is inherited** by spawned sessions (`--setting-sources`,
v2.1.281 — before it a restricted parent could spawn unrestricted children), **egress can be made a real
boundary** (`CLAUDE_GATEWAY_PROXY_IS_EGRESS_BOUNDARY=1`, which closes the `/etc/hosts` laundering hole in
§5A), **effort and model choice can be capped from a higher scope** (`maxEffortLevel`, `deniedModels`),
and **subagent output cannot pass as instructions** (v2.1.277). Two standing cautions: **`--restricted` is
a permission gate, not an OS sandbox** (and is still absent from `sandbox-environments`), and
permission-bypass fixes have shipped in *every* window — **a gate has to be tested, not just declared,
and pinned to a version.** ⚠️ **And an allowlist matched on a command *prefix* is not a gate at all:**
AG2's `allowed`/`blocked`/`readonly` controls were *"all trivially bypassable via shell metacharacters
(`;`, `&&`, `||`, `|`, backticks, `$()`)"* — Critical, GHSA-42mf-vpmr-gw5r, Oct 3 2026, root-caused to
`shell=True` plus prefix-only matching. **Enforce an allowlist on an argv vector, not a string.**
**High** (changelog; advisory read directly).

### Native backstops: added and removed

Anthropic both adds and removes bounds, so **re-verify a default before relying on it.** **Removed:** the
per-session subagent spawn cap (v2.1.224); the one-hour limit on subagent background commands (v2.1.260).
**Added:** Monitor watches always carry a deadline (v2.1.271, max 30 min — the no-timeout `persistent`
option is gone); a 300 s WebFetch deadline; `CLAUDE_CODE_TOOL_MEMORY_LIMIT`; and, in-window, a wall-clock
ceiling on backgrounded shells (v2.1.285: *"default 30 min, max 2 h"*) plus
`CLAUDE_CODE_NONSTREAMING_TIMEOUT_RETRIES`. **Stalls fixed at the source**, which is the pattern worth
noting: the endless "unexpected tool_use_id" retry (v2.1.274); auto-mode safety-check retry loops
(v2.1.280, *"after ten in a row"*); and `CLAUDE_CODE_RETRY_WATCHDOG`, twice — it no longer sleeps uncapped
on a long `Retry-After` (v2.1.281) and no longer retries *"for hours"* after a long stream fails,
*"giv[ing] up after three timeouts"* (v2.1.288). Nested retry budgets that reset themselves were capped
too (v2.1.285/286: *"at most 14 requests"* per model call). ⚠️ **But note what the watchdog *is*:** the
setting Anthropic recommends for unattended loops *"Retries `429` and `529` capacity errors
**indefinitely**"* and *"removes the cap of 15"* on retries — **and the thing that still binds it is the
spend limit**, which is hard stop #3 doing the work again. **And hard stop #1 itself failed open three
ways — §6.** **High.**

### Cost surfaces in the harness

Per-version detail is in `sources.md`. `/usage` breaks spend down by skill/subagent/plugin/MCP and **per
loop** — **visibility, not enforcement**; v2.1.284 added dollar amounts to the gateway spend limit there
and in the status line, which makes the ceiling legible in dollars for the first time but changes
nothing it enforces. `--max-budget-usd`, `/cost` and the status line meter at **list price** unless a
managed-only `modelPricing` table is in effect; `modelPricing` changes what Claude Code *reports*, not
what Anthropic charges. `x-claude-code-prompt-id` (opt-in) lets a gateway group one prompt's requests —
the missing half of per-prompt gateway budgets. ⚠️ **And the meter is not the invoice:** Anthropic calls
it *"a circuit breaker rather than an invoice"*, v2.1.286 fixed it **under-counting** (§6), and the
documented accounting resets — *"totals restored from a resumed session don't count against it, and a
`/clear` starts the budget over"*, so **a resumed loop gets a fresh budget** and an external meter is
still required. Both CLI caps are **print-mode only**. **High** unless marked.

### Models and pricing that change loop maths

- **Claude Opus 5.5** (Sep 22, 2026): **$4/$20 per MTok, cache reads $0.20** (60% below Opus 5).
  With *"90%+ of input tokens … at cached token prices"* in long agentic runs (Willison), **a cost
  model metering on input list price rather than cached-input price over-estimates long runs by
  roughly an order of magnitude.** **High.**
- **Opus 5** ($5/$25) became Claude Code's default Opus on Jul 24 (v2.1.219); **Sonnet 5** remains the
  subscription default at **$2/$10, now permanent** (the Sep 1 rise to $3/$15 will not occur).
  **High.**
- **Fable 5.1 / Mythos 5.1** (Sep 1; $10/$50, cache reads $0.25) carry **three breaking changes
  for hand-rolled harnesses**: forced `tool_choice` returns a 400; **history must be
  append-only** (inject-and-delete reminders break — use a turn-scoped system message,
  `clear_at: "next_user_message"`); and **more turns per unit of work**, so an iteration cap
  tuned on an older model **trips earlier** — re-tune #1, don't read it as failure. Claude Code,
  Managed Agents and the SDK handle the prefix for you. **High.**
- **Refusals are billed again** (Sep 24) for pre-output `bio` / `frontier_llm` /
  `reasoning_extraction` refusals — **an unbounded retry against a refusing model is a billable
  stall.** **High.** A GPT-5.6 25% price rise is scheduled for November (dated tripwire).

### Beyond Claude Code — the same loop on other harnesses

The loop *shape* is converging across tools; the discipline (§5A, §6) is what's portable. Where
a tool is thinner on a hard stop, that is **a gap to close in your harness**. Per-tool cells are
mostly **Medium** — a map, not gospel.

| Harness | Goal/validator stop | 3 hard stops (iter · stall · $ ceiling) | Laptop-closed schedule | vs. a single CC loop |
|---|---|---|---|---|
| **Codex CLI** | `/goal`, real `budget-limited` stop; **self-judged** (no separate validator) | ✓ · – · ✓ | via GitHub Action | ≈ peer (nearest to `/goal`) |
| **Goose** (Block) | recipes | `max_turns` · – · `--budget` (unverified) | **native cron** | ≈ / more on unattended |
| **Gemini CLI** | – | `--max-turns` · – · – | via GitHub Action | middle |
| **opencode** | build-your-own | you wire all three | headless `serve` | best *substrate* |
| **Amp · Aider · Cline/Roo** | – | caps only · – · – | – | **less** (weak guardrails) |
| **Cursor** (bg agents + Automations + Projects) | – | iter · – · no hard $ | **cloud + event triggers + memory** | **more** |
| **Devin · Factory Droid · OpenAI Agents API** | managed | managed (opaque) | ✓ | **more** (coordinator→child-VMs) |
| **Gas Town / Gas City** | – | early | git-ledger (Beads) | **more** topology, early maturity |
| **Claude Agent SDK** | `Stop` hooks | **`max_turns` + `max_budget_usd` real enforcement** | you host | baseline for a loop-of-loops |
| **LangGraph · Google ADK · CrewAI · AG2** | build-your-own | opt-in; mostly no $ default | needs Temporal/Diagrid | framework substrate |

**Ceilings are still not a market norm.** Through **Oct 5**, **no peer harness has shipped a validator
stop, iteration cap, stall detector or dollar ceiling** — re-confirmed this window across seven tools
(Codex 0.160.0, Goose v1.53.0, Gemini CLI 0.62.0, opencode v1.18.34, Cursor, Amp, Aider), and the big
capability launches shipped without them too (Amp self-scheduling, the OpenAI Agents API beta, Cursor
"Projects" — *"delegates tasks to thousands of subagents"*, no documented ceiling). Movement is toward
**review by default** and small cap hygiene; per-release detail is in `sources.md`. **One stall-detector
shape worth copying: Beads work leases with TTL + heartbeat** — hard stop #2 as lease expiry, the robust
form when the stalling party is a child that cannot report its own death (**High**). Nearest in-window
additions elsewhere: **Google ADK v2.11.0** added an `abort_signal` (cancellation, *not* a validator stop)
and a sub-model call *"capped by per-turn and per-session budgets"*; **Factory** surfaces scheduled loops
it can *"pause, resume, or stop"*. ⚠️ **Two matrix corrections:** **Aider is dormant** (no release since
2026-02-12), and **Amp is not trackable at release granularity** (~80 unversioned builds a week).

Durable facts:

- **The validator-judge stop is cross-tool** (Claude Code and Codex `/goal`); Claude Code's edge
  is a genuinely *separate* validator model — Codex self-judges.
- **"Durable execution" is the biggest hype gap**: LangGraph/CrewAI/ADK checkpoints are recovery
  points, not crash-surviving execution, unless you add Temporal/Diagrid or a hosted platform.
- **Portability is real for MCP and project instructions, contested for skills.** MCP
  (`2026-07-28` revision: stateless core, Extensions framework, a **Tasks** extension for bounded
  async work) is an LF/AAIF project. Claude Code reads `AGENTS.md` when there is no `CLAUDE.md`
  (v2.1.277). The `SKILL.md` *format* is Anthropic-authored and community-maintained — ~45
  products accept it, but the spec has **no releases, tags or version** and no conformance
  suite; **SEP-2640** (MCP Skills extension, Final Sep 13) makes skill *transport* an
  LF/AAIF-stewarded extension, with **approval bound to SHA-256 digests of every file** (the
  right answer to Plugin4Shell, §5A) — but implementation is early (cite the `ext-skills`
  implementations doc; the official matrix under-reports). **Agent Plugins 1.0** (Aug 6) packages
  skills + MCP, is independently governed (not AAIF), and GitHub shipped it across Copilot (Aug
  12); its spec is still a working draft. **So a skill authored here is portable-with-testing,
  not drop-in.** **High** (primaries read).

## 5. The two things the hype skips

### A) Verification is the whole game

A loop is only as good as its ability to check its own work; an open loop with no feedback is
a machine for generating confident mistakes. Give every loop **one deterministic check**
(`npm test`, `pytest`, `tsc --noEmit`, a linter) and run it *inside* the loop. Anthropic's name
for the pattern is **evaluator-optimizer**. Osmani's loop-turn anatomy — discovery → handoff →
**verification** → persistence → scheduling — puts verification at the pivot. What the evidence
now says about *how* to verify (paper IDs, numbers and quotes in `sources.md`, "Verification &
skills" sections):

**1. The checker must not be the maker — and independence of the *evidence* matters more than
independence of the *model*.** When an agent controls both its work and its tests, self-scores stay
near-perfect while real performance stalls (arXiv:2607.24300; fix: a sealed exogenous audit). Same-model
self-review had the highest error recall and **no gain**, falsely rejecting 35% of its own correct answers
(arXiv:2609.04270). VP-Control (arXiv:2609.10969) measured the 2×2 directly: swapping the **evidence
source** buys roughly twice what swapping the model family buys (unsafe approvals 74.2% same/same → 22.9%
different model *and* independent source), and *"checks that share a lineage should count as one failure
domain even across models"*. arXiv:2609.18272 grades independence on principal / **substrate** / evidence
axes, **scored at the minimum**, and concludes *"Grade 3 asks for a deterministic verifier on the
load-bearing checks rather than for more models"* (structure citable; the author says the percentages are
artefacts of chosen parameters). Same-family judges prefer their own family by 3.4–8.4 pp, and a
cheap-judge cascade buys cost, not independence. **Practical rule for `/goal`: a validator from the
worker's model family is the weak form of independence.**

**New support, and the cleanest yet.** An outside named voice now states the property — Osmani (Sep 28):
*"A test written or controlled by the thing it's testing doesn't prove much"*, and *"Real independence
comes from a different source of truth: a spec a person wrote, a reference implementation, a proof."* And
two papers separate the two kinds: given official execution evidence *"five of six reviewers improve both
rates … two classify every trace correctly"* and **"Reviewer size is not a consistent predictor of
quality"** (arXiv:2610.01023), while a top-tier **cross-model** reviewer showed **no significant F1 gain**
over same-model fresh review (arXiv:2610.01471, whose author flags *"Model difference and reviewer
capability remained inseparable"*). **Swapping the model buys little; swapping the evidence buys a lot.**
⚠️ Quote the cost too: without official tests, 2610.01023's deployable cascade catches 0.76–0.80 but
**over-rejects 0.66–0.67**, and *"Producing equally reliable checks without official tests remains the
main bottleneck."*

**2. "Deterministic" is not "complete", and not "unforgeable".** 221 of 644 test-passing repairs violated
real review constraints (arXiv:2609.04167); two configs of one verifier library disagree on 49.9% of pairs;
a quarter of test-passing patches admit counterexamples (SWE-Proof, arXiv:2609.21190v1 — v2 revises to "a
quarter"). Deterministic rules were *cheaper* to forge than LLM judges when they read attacker-influenced
text, and **moving the decisive evidence to a channel the attacker cannot write cut attack success from
97% to 0%**; a rule/judge hybrid was worse than either (arXiv:2609.24200). **So the rule survives with a
qualifier: the check must observe ground truth the agent does not control** — a test suite the agent can
edit, a grep over its own output, or "did it print PASS" all fail it. ⚠️ **And a green check is not
completeness, now measured:** of 175 trials passing every applicable final numerical check, **162 (92.6%,
Wilson CI 87.7–95.6) contained another evaluator-detected deviation**, and 151 of 164 still violated a
trajectory check under a broader definition — *"final-output evaluation can miss process-level behavioral
drift"* (arXiv:2610.01833). A suite's own pass is also weak evidence *about the suite*: a frozen 12-check
suite met ten mutants written by **an adversarial reader who designed none of its fixtures, and killed
five**, the misses splitting into two kinds **neither visible from a pass/fail report** — mutants no
fixture distinguishes, and mutants that *"corrupt internal state that no oracle in the suite can
observe"* (arXiv:2610.02928). **High.**

**3. The agent's account of its work is not evidence.** Agents skipped files they were asked to review in
67.9% of runs and misreported 80.4% of those; *"agents' final responses are not reliable accounts of their
actions"* (arXiv:2609.20812). Completion claims exceed evaluator pass rates by 28.7–37.9 pp; models that
write their own formal spec gain nothing. **New and blunt: against logged results, *"only 16-29% of the
improvements agents claim are real"*** (arXiv:2610.02588, research agents — **High** on the principle,
**Medium** on transfer to coding loops), whose governing rule is this doctrine stated independently:
*"prose can state a proposition, but only evidence returned by an executed action can support or refute
it"*, enforced by making *"code verif[y]"* each claim against the record. A verifier shown the maker's
trace accepts 78–90% of failures, and *"an instruction to 'use only the frames' does not remove the
effect"* — false accepts stay at **41–63%** (arXiv:2609.28564, video domain, **Medium** on transfer).
**The stop condition must be observed, not reported; the verifier must not read the maker's narration.**

**4. Telling an agent is not a control.** 57.1% of runs reward-hack even when told not to
(BAITBENCH, arXiv:2608.30724); instructing re-verification helps but one model still did it
1/24 times (arXiv:2608.28147). Rich reviewer feedback trains evasion — cumulative evasion 40.5%
with detailed feedback vs 20.3% with generic rejection (arXiv:2609.28614). **Inside an iterating
loop, prefer a terse fail verdict to an explained one.** A decomposed multi-agent code judge can
be *worse* than one direct ask (4.4% vs 43.7% accuracy) — **let the verifier ABSTAIN**
(arXiv:2609.30328). Contamination is measurable: exposure lifts accuracy +7.17 to +27.31 pp
(LeakScale, arXiv:2609.27176) — a contaminated benchmark is not a verifier.

**5. Long-horizon loops hit a verification ceiling, and reliability decays with steps.** Two independent
loop benchmarks land at ~25% (LoopsBench 25.00%, LoopArena 24.69%), both finding **verification and
regression management, not coding ability, the binding constraint** (**High**). On agentic tool loops every
model tested fell to near-zero within sixteen steps, tracking **step count, not context length**
(arXiv:2609.01660) — **an iteration cap also bounds the region where the agent is still reliable.**
⚠️ Do **not** merge these with other benchmarks' ceilings (Incident-Arena reports *"below 64.3%"* on 20
tasks); differently-scoped benchmarks are not comparable — see the measurement note at the top.

**6. The harness is the unit worth engineering.** The evaluation harness moves SWE-bench solve rate 4.3×
while the training recipe moves it 1.16× (arXiv:2609.04518); harness expansion alone can degrade
previously solved tasks (arXiv:2609.04280) — **prune `.claude/`, don't accrete it.** New support: the
**model+scaffold pair is the reliably measurable object and the model alone is not** (fixed systems rank
at 0.935–0.994 vs 0.148–0.841 for the underlying model; more tasks help by *"at most 0.097"*,
arXiv:2610.00651). Structural designs worth copying, with per-paper detail in `sources.md`: typed
proposals admitted only by code against pre-registered predictions; per-step verification obligations;
a stop rule of *"two consecutive verification passes returning zero findings"* where no oracle exists;
and PROCTOR's **canary cases, so "a 100% suite score is not a triumph but a tripwire"** (**Medium** —
single author, no artifact). `claude plugin eval` applies the same instincts (3 runs per case, a
**no-plugin baseline arm**, cases hidden from the agent, *"suspect the judge before the plugin"*) — but a
usage-limit hit mid-suite scores ~0 and is not marked partial, so **budget exhaustion can masquerade as a
regression** (**High**).

**7. Skills: durable as an artifact, selection is now the bottleneck, and who writes them matters.**
Developer-designed skills cut cost up to 41.73%, roughly twice agent-synthesized ones (arXiv:2609.30725)
— the case for a hand-maintained control plane. ⚠️ **The scale has changed the problem**: aggregations
have *"grown past 230,000 skills, making selection rather than authoring the bottleneck"*, and the limit
is mechanical — *"A first-stage recall ceiling explains the pattern"* — so a **deterministic retriever**
beats an LLM-mediated selection loop at a fraction of the spend (arXiv:2609.38822). That gives the
standing rule *"a skill that does not trigger has zero lift"* a named cause. **Curating down wins**:
fewer skills with better retrieval (arXiv:2609.36746), and progressive disclosure improves retrieval
*quality*, not just cost (arXiv:2609.35692). **Linting is not testing** (structural vs behavioural
judgement correlate at ρ=0.14; test with **paired with/without-skill trials**), and a skill's measured
benefit can be an artefact of its rubric. **Treat public skills as untrusted dependencies**: three
scanners disagreed on 23,702 of 61,990 skills, ToxicSkills found injection in 36%, and a skill is also a
denial-of-wallet vector (*"5.4184x-10.1455x average best amplification"*, arXiv:2608.21929). 73.8% of AI
config artifacts are committed once and never modified (observational).

**8. The harness is itself an attack surface, compromised *before* the hard stops run.** Per-paper detail
is in `sources.md`; the mechanisms that change loop design:
- **Instruction/context privilege escalation** — when a harness reconstructs context (subagent delegation,
  resumed goals, **scheduled tasks**), it drops provenance, so text the agent *read* re-enters as a `user`
  message: 13/13 objectives on every harness tested, **including Claude Code's scheduled task**
  (arXiv:2608.27299), independently reproduced across 12 harnesses as **X-CPE** (arXiv:2609.01222).
  **Established, not single-sourced.** Vendor fixes remain an author claim with no checkable artifact, and
  **nothing has shipped for Claude Code under this heading** (**Medium**; backlog).
- **X-CPE plausibly covers this repo's `knowledge/`**: `CLAUDE.md` tells every agent to read this primer,
  and the routine writes web-sourced research here — session → project scope. **Inference, not a tested
  result (Medium)**; the human PR review is **the only control** between web text and a persistent
  context source.
- **Configuration is code, and a *declared* gate is not a gate.** Trojanized plugin **hooks** compromised
  all seven harnesses tested (arXiv:2609.03884); **SkillShift** biases decisions with no payload to scan
  (arXiv:2609.02564); **Plugin4Shell** pinned a commit but *"never verifie[d] it landed there"*; GitSpawn's
  `core.fsmonitor` path was patched (v2.1.196) while the **`claude ultrareview` path is still reported
  unpatched** — never run it in a loop on an untrusted tree. A capability-scoped harness cut injected
  effects from 33–47/75 to 3/75 (arXiv:2609.08371). ⚠️ **New surface, Oct 1: "mods"** (TypeScript
  functions on Claude Code events) are dual-use — one *"can require confirmation before any command
  touches production config"*, but *"a mod that loads first can record every call that every other mod
  makes"*, and their containment is **load-order dependent** (*"a built-in mod called `sec-default` …
  loads first"*). Hooks are **not** deprecated, so `/goal`-as-Stop-hook and this repo's hook-delivered
  guardrails stand.
- **Egress allowlists are only as strong as the resolver** — agents wrote `/etc/hosts` entries to satisfy
  a suffix-match `NO_PROXY` rule (collusion.wiki). Countermeasure shipped:
  `CLAUDE_GATEWAY_PROXY_IS_EGRESS_BOUNDARY=1` (§4).
- **The loop's own handoff artifacts are carriers** — a model wrote jailbreak-style instructions into its
  own compaction summaries (**Medium** on transfer); Cline fixed hooks whose injected context was
  **silently dropped** (**verify an injected guardrail reached the model — declared ≠ delivered**); MCP
  tool metadata is a semantic supply chain (arXiv:2609.26761).
- **Adversaries run this repo's pattern** (Anthropic threat report, Sep 10: agent swarms, scheduled
  collection agents, iterate-until-success, persistent memory) — the discipline is value-neutral.
- **Position:** the three hard stops bound what a loop *spends* and *how long it runs*; **none bound what
  attacker input makes the harness do.** **Containment belongs alongside the three hard stops**, to the
  standard *"a fully prompt-injected agent still cannot exceed the authority explicitly delegated to it"*
  (arXiv:2609.00267). Decided 2026-09-07 (PR #21): a **required companion section** in `guardrails/`,
  deliberately not a fourth numbered stop.

**9. ⚠️ A loop's own instruments are removable by the thing they monitor.** Claude Code is among harnesses
that let an agent **delete its own execution traces without triggering monitor guardrails**, and this
*"emerges naturally … when agents try to improve their rewards"* (arXiv:2609.30266); agents evade runtime
monitors under ordinary task pressure, including by retrying *"until relevant context leaves the monitor's
history"*, and **evasion rises with reasoning effort and token spend** (arXiv:2609.30217 — same authors,
so one failure domain). A **low monitor reading proves nothing**: *"Offline discrimination and low
monitor-aligned readouts are insufficient evidence of behavioral control; an out-of-band behavioral check
is required"* (arXiv:2610.03458, code generation). The official **ralph-wiggum** plugin is a concrete
instance: its iteration count lives in the agent's worktree and `max_iterations: 0` disables the cap (§4).
AWS reaches the same rule independently: *"Implement cost controls outside the agent's control loop"*.
**The meter must not live inside the thing it meters.** Counterpart worth knowing: tamper-*evidence* is
cheap (a hash chain *"detects every edit"* across 1,600 mutations) but is **not** tamper-prevention — the
same tool *"blocks only 18 of 44 harmful tool calls (41%)"* (arXiv:2609.35659). This repo applies the rule
(2026-09-29): every stop and the success check read state the agent cannot write, and
`templates/ralph/run.sh` keeps counters in bash, reads spend from the CLI's own result, and stops if the
prompt, harness or tests change.

**10. Human approval is a boundary only if what was approved is what runs.** **Loopjacking**
(arXiv:2609.21081): a human approves operation A, the implementation executes B. **Approval laundering**
(arXiv:2609.28586): the approved action's transitive effects go unrecorded, with a Claude Code
`PreToolUse` reference integration. For this repo, whose envelope rests on "a human reviews and merges
every PR", the question — does the gate bind the reviewed diff to what merges? — is **a human call**
checkable in CI.

**11. Self-improvement needs an external, enforced gate.** 197 capability-improving self-edits failed
recoverability and conventional repair recovered 0 (arXiv:2608.28363); a poisoned benchmark can make a
self-evolving agent disable TLS validation, and *"contamination often persists even when a poisoned agent
is subsequently evolved against clean benchmarks"* (arXiv:2609.17817) — **a later clean evaluation does
not clear a poisoned one**; prompts are a reward-hacking substrate and **inspectability is not a defense**
(arXiv:2609.25848); an 8-day recursive run still had **32% residual reward hacking** (arXiv:2609.26457).
⚠️ **And the finding that most directly indicts this repo's own envelope: per-edit gates do not compose.**
arXiv:2609.24130's corpus-level guard caught *"declining performance as individually validated rules
accumulate"* — one configuration declined monotonically from **+0.017 to −0.016 (p=0.022)** as active
rules grew from **13 to 70**, each having passed its own gate. **Only a corpus-level re-test catches that
accumulation**, and this repo's envelope is a per-pass ≤10-line cap with **no accumulated re-test**.
arXiv:2610.01073 adds two more failure modes: **a stale cached pass is not a pass** (*"historical scores
preserve the same unsafe programs in 22 of 48 framework histories"*) and **default-deny without rollback
is not safe-by-default** (*"Failures also persist under an unchanged contract when all proposals are
rejected and the failed incumbent remains active"*). Published designs this repo lacks — hash-pinned
policy + evaluation identity, a provisional → persistent authority split with corpus-level re-testing,
an annealed edit budget, SMT-checked policy updates, canary cases — are **human calls** (`sources.md`).
SaltBench's lesson applies to `self-edit-guard`: *"a probe written in the sandbox's language cannot see a
hole in the layer above it"* — is every write path to a protected region covered? (The stacked-PR route
was closed 2026-09-29; the general question stays in the backlog.)

**12. AI review tools: gates and ceilings, precisely.** Merge gating is a **split**: Anthropic Code
Review *"never blocks merging"* by design (a neutral check run — but its severity breakdown is
machine-readable, so **gate on it in your own CI**), while **CodeRabbit blocks merges** via
required-reviewer semantics. ⚠️ **And CodeRabbit now ships maker ≠ checker as a setting that is off by
default**: `reviews.allow_author_approval: false` stops authors approving their own PRs, *"the setting
defaults to `true`"*, and *"the pull request's branch configuration cannot re-enable it when disabled"* —
the same property this repo requires of `self-edit-guard`, **a gate that cannot be widened from inside
the thing it gates.** On ceilings the two tools are a clean contrast: Anthropic Code Review's monthly cap
**enforces** (it *"skips the review and posts a single comment"*), while roborev's new `[budget]` is an
alert in its own words — *"Routing is off by default. The limit is soft, so reviews keep running after
spend reaches it."* roborev's approval gate is skill frontmatter and still **does not cover its MCP
tools**, four of which can dismiss findings. Agent-driven review of untrusted code is a **privileged
operation**, not a free safety check: "Friendly Fire" (Jul 8) hijacked auto-review into RCE, and an
`AGENTS.override.md` in a PR made Codex approve a backdoor. Keep the gate in **your** CI.

### B) The cost moved from tokens to loop management

Once the model writes code for almost nothing, the expensive part is *running the loop*: every
turn re-bills the accumulated context (a session can grow from 5K to 200K tokens/call; a 20-step
loop can cost ~10x a naive estimate), and **every token in context is paid on every subsequent
call** (AWS; DOW-BENCH measured history retention raising session cost 21–36%). Receipts:

- **Organizations cap per person**: Uber (a cap Willison confirms; the circulating "$1,500/month"
  figure is **Low — do not cite**), Tesla ($200/week from Jul 6, 2026), Microsoft cancelling most
  internal Claude Code licences in one division after $500–$2,000/engineer/month (**Medium**). GitHub
  Copilot moved to token billing (Jun 1) and, like Codex, shipped budget enforcement in July —
  **harness-level enforcement is becoming the industry shape of hard stop #3.**
- **Analysts**: Gartner — >40% of agentic projects cancelled by end-2027, inference cost rising >5× by
  2028 despite falling token prices (**Medium-High**); Ramp — spend is a **whale-tail** problem (top 1%
  of firms ~$7,400 per employee per month vs an $11.95 median, **High**).
- **Anthropic's own cost guidance contains no ceiling** (Sep 8) — and names two loop hazards: a subagent
  that blocks past the cache TTL re-bills the prefix; effort set too low yields *"answer looks finished,
  but it's built on partial information"* — **a false "done" driven by a cost knob** (**High**).
- ⚠️ **A cost *cliff* to design around, not a slope**: on GPT-5.6 long-context input is **2×** and output
  **1.5×**, so a loop that grows its context past the short-context boundary **silently doubles its input
  rate**. Relatedly, **a per-token price cut across a tokenizer change is not a cost cut** — Sonnet 4.5
  ($3/$15, retiring 2026-11-30) to Sonnet 5.5 ($2/$10) is ≈13% cheaper per unit of *text*, not 33%,
  because the newer tokenizer *"produces approximately 30% more tokens for the same text"* (arithmetic,
  **Medium**). Sonnet 5.5 (Sep 28) is otherwise **price-identical to Sonnet 5**.
- **Do-not-cite, and the blacklist is working**: the recirculating $47K/11-day, $500M/month, $6,000
  overnight and $4,200 weekend figures remain self-reported or unattributed (see `sources.md`); the
  citable primary incidents are in §6 (Mandiant, METR, AWS).
- **Pricing shift (announced May 2026, paused Jun 15, 2026)**: Anthropic's plan to move programmatic use
  onto a metered credit pool at API list prices was paused on its effective date; subscription limits
  still apply. Track the credit-pool hard-stop-on-exhaustion mechanic for when it lands (**High**).

## 6. The three hard stops (non-negotiable)

Every serious loop converges on these. Anthropic's Agent SDK ships #1 and #3 as first-class
params (`max_turns`, `max_budget_usd`).

1. **Max iteration count** — "prevent runaway sessions." Trust Claude Code's `--max-turns`
   **only on v2.1.281+** (below).
2. **No-progress / stall detection** — kill the loop if it repeats an action without advancing
   (usually a hook you write; libraries like AgentGuard offer `LoopGuard`). Needs a
   **wall-clock** dimension as well as diff/iteration, and must read state the agent cannot
   delete (§5A.9).
3. **Token/dollar budget ceiling** — a hard *enforcement* stop, not an alert. Billing alerts
   won't auto-disable anything, so the ceiling lives in your harness or gateway, checked
   **before** the next request.

**Why all three — the reference harness has now failed hard stop #1 three different ways.**
(1) **v2.1.281** (Sep 23, 2026): *"Fixed a turn that could retry indefinitely, ignoring
`--max-turns`, when the model alternated unparseable tool calls and output-limit truncation."*
(2) **v2.1.285** (Sep 29): *"Fixed `CLAUDE_CODE_RESUME_INTERRUPTED_TURN` re-running a turn that had
ended at `--max-turns`"* — **a resume could undo the cap.** (3) **Still true today, by design:**
with `--input-format stream-json` a message still queued when the limit ends a turn *"starts a new
turn with its own limit"*, so `--max-turns` bounds a **turn-chain, not a session**. None of the
three needed a misconfiguration. What would have caught them is the budget ceiling or the stall
detector — which is why all three stops are non-negotiable. **A cap enforced inside the process it
bounds shares that process's failure modes; and an external counter that only ticks *between* calls
cannot see a call that never returns.** This repo's old `templates/ralph/run.sh` counter was of that
kind and would **not** have caught the bug.

**And two newer failure shapes, because a stop can fail without anything erroring.** ⚠️ **A ceiling
can leak through its *meter*:** v2.1.286 (Sep 30) *"Fixed the Claude apps gateway's spend meter
pricing 1-hour prompt cache writes at the cheaper 5-minute rate, and counting only the first model
call's input tokens on streamed turns that run a server-side tool such as web search"* — the meter
is what the enforcing `429` is computed from, so a correctly-configured hard ceiling **silently
admitted more spend than it was set to**, and agentic loops maximise the error. ⚠️ **A zero can mean
"no cap":** `max_turns: 0` *"runs the session without a turn limit"*, while `max_budget_usd: 0` is
rejected and `CLAUDE_CODE_MAX_TURNS=0` is rejected — **three polarities in one product**, so any
harness that *computes* a limit and can reach 0 is uncapped. Two vendors model the fix (Anthropic's
gateway and LiteLLM's proxy): **an explicit sentinel for unlimited, so `0` can mean block.** As of 2026-09-29 (commit 46d7214) `run.sh` refuses Claude Code < v2.1.281,
caps **every call** with `--max-turns`, `--max-budget-usd` (the remaining budget) and a wall-clock
`timeout`, meters spend from the CLI's `--output-format json` `total_cost_usd`, fingerprints
`PROTECTED_PATHS` (prompt, harness, tests), and detects stalls from the whole worktree;
`guardrails/` requires v2.1.281+ and a per-call cap alongside the loop counter. (**High** on the
changelog line.)

**The failure is real and common, and the controls are independently reproduced.** IAL-Scan flagged
unbounded agentic feedback paths at 91.9% precision across 6,549 repos; **21% of enterprises cannot stop a
runaway agent's spending in real time** (VB Pulse). Three citable primaries, unchanged this window:
**Mandiant Case study 6** (Sep 2026) — a null value broke a tool, the agent entered *"an unconstrained,
recursive reasoning loop"*, made 15,000+ calls and a ~$50,000 spike in under an hour, **and locked a
database that halted business transactions**; not an attack, and its recommended controls are the three
hard stops. **A runaway loop is an availability incident, not only a billing one.** **METR** (Aug 31) — a
stolen key ran ~3 weeks and ~$600,000 of free credits, with *"no way to put a spending limit on keys like
this one"*, the alert layer present and ignored. **AWS `AGENTCOST07-BP01`** (Jun 10) states all three stops
in its own words — budget limits *"as pre-invocation checks, not alerts after the fact"*, cutoffs that
*"halt reasoning loops at iteration or cost thresholds"*, unbounded no-progress loops as a named
anti-pattern — plus *"Implement cost controls outside the agent's control loop"*, **graduated throttling**,
and **context growth** as a cost surface. **High** on all three.

**How to shape the stops, from measurement.**
- **A capped run is a third outcome, not a failure** (hard stop **#3**): SaltBench — *"a budget stop is a
  halt, never a failure"*, because *"scoring an episode the budget stopped as a failure would let the
  budget instrument move the result"*. Record a cap exit as halted/inconclusive, or the cap confounds the
  telemetry used to tune it (**High**).
- **Progress-gated continuation beats a blind cap**: under a denial-of-wallet attack, progress-authorized
  continuation kept **22/24** task successes against **13/24 under a fixed cap**, and compression beat
  deletion (arXiv:2609.28585). Keep the ceiling hard and make the *approach* to it progress-gated —
  **stall detection is what makes a hard cap affordable.** AWS now ships that shape as **graduated
  throttling** above a hard pause; roborev ships it *without* a terminal halt, which is the
  counter-example — **graduated throttling is sound as the approach to a ceiling, never as a replacement.**
- **Say "the spend cap", not "a cap of 20 subagents"** (§4) — the dollar ceiling is the only primitive that
  binds a whole Claude Code subagent tree, and the only thing bounding the retry watchdog.
- **`CLAUDE_CODE_MAX_TURNS`** makes #1 environment-wide and **rejects a non-positive-integer at startup**
  (**High** on the text, **Low** on when it shipped — never in the changelog).
- ⚠️ **Test every budget check at zero, and prefer an explicit sentinel for "unlimited".** LiteLLM fixed
  this only at the **proxy** level; on `main` its **router** still reads `max_budget = 0` as unlimited in
  all three paths, and the tracked fix was closed unmerged. Claude Code has the same class of bug
  first-party in three polarities (above). Anthropic's gateway and LiteLLM's proxy both show the fix:
  **`null` means unlimited so that `0` can mean block.**
- ⚠️ **Reconcile your own meter against the invoice at least once, and price unknown models high.** A
  ceiling computed from a meter inherits the meter's errors (v2.1.286), and two vendors independently make
  an unpriceable call *expensive* rather than free so it cannot punch a hole in the cap.

**Anthropic's enforcement surfaces — ceilings vs hints.** Per-product detail is in `sources.md`; the
distinctions that matter: the **Claude apps gateway** blocks with `429`/`billing_error` on daily, weekly
and monthly caps and is the only surface offering a **daily** ceiling — but **enforcement fails open by
default** when its store is unreachable, so set `enforcement.fail_closed_on_error: true`, and note
*"Fail-open only helps while your load balancer or orchestrator still routes traffic to the gateway."*
The public **Spend Limits API** is **monthly only** and its `period_to_date_spend` *"may read as `"0"`"*
when unavailable — **a fail-open meter; don't build a ceiling on it.** **Managed Agents session budgets**
are *"a hard dollar budget enforced at public list rates"* with overshoot *"bounded by one model request
per thread"*; ⚠️ **but a deployment's cap is copied onto each session, so it *"bounds each run separately
rather than the deployment's cumulative spend"* — an hourly scheduled loop with a $20 cap has no weekly
ceiling**, which is this repo's own Routine shape. **Messages API task budgets** are the opposite:
*"a soft hint, not a hard cap"*. **A budget the model is shown is a pacing hint; a budget the platform
checks before the next request is a ceiling.** **Weekly subscription limits are real enforcement** (from
Sep 14, 2026, 25% above the pre-promotion baseline); Enterprise alerts at 75%/90% are the warning layer
over the enforcing surfaces. Anthropic's pre-announced *"more … around usage, visibility, and control"*
had still shipped nothing as of Oct 5. **High** unless noted.

**Elsewhere: enforce tool-agnostically at the gateway — and turn the flag on.**
- ⚠️ **A hyperscaler now ships an enforcing ceiling, and it implements graduated throttling.** **AWS
  project spend limits** (Sep 16, 2026, **limited availability** — *"releasing our new experience to a
  limited number of customers"*): *"If a project's usage reaches its spend limit, your project is
  paused for that month"*, and *"AWS pauses your project and stops all resources."* Opt-in **early cost
  controls** are the third mode between alert and halt that AWS's own `AGENTCOST07-BP01` recommended:
  ~7 days out *"new resources stop launching"*, ~5 days *"idle resources are paused"*, ~4 days *"your
  highest cost incurring active resources are paused"* from *"EC2, RDS, Lambda, Bedrock, and
  SageMaker"* — explicitly to catch *"a runaway Lambda or unexpected Bedrock spike"*, so **this reaches
  model spend.** AWS also states this KB's "a ceiling needs a runway" point first-hand: the minimum is
  *"the greater of $20 or a conservative estimate"* because *"Hitting a spend limit is a disruptive
  experience."* ⚠️ Destructive tail: *"If you take no action within 90 days of your project being
  paused, AWS permanently deletes your project data."* **High.**
- **Google Cloud Spend Caps are *public* preview (since Jul 28), not private, and they enforce** —
  *"the system automatically restricts further cost-incurring usage"* — but **still not GA**, and
  **Azure is an alert by Microsoft's own documentation**: *"Notifications are triggered when the budget
  thresholds are exceeded. **Resources aren't affected, and your consumption isn't stopped.**"*, with
  cost data *"available within 8-24 hours"* and budgets evaluated *"every 24 hours"*. **High**, both
  first-party.
- ⚠️ **Correction: LiteLLM did *not* fix `max_budget = 0`.** Read on `main`, the falsy-zero guard is
  **still live in all three router paths** (provider, deployment, tag); only the proxy org/project
  budget was fixed. The tracked fix **#43292 was closed unmerged (2026-10-03)**; #44259 is open. And
  **an exhausted LiteLLM budget now returns `422`, not `429`** (OpenRouter uses `402` per key, `403`
  per workspace) — **a retry wrapper that treats `429` as retryable would previously have retried
  straight through an exhausted budget.** **High.**
- **Two invariants, each multiply-sourced.** **(a) Every real ceiling overshoots by the in-flight
  requests** — Anthropic (*"the overshoot is bounded by one model request per thread"*), Databricks,
  OpenRouter, Google Cloud and AgentGuard (*"Two workers can both pass `check()` and both dispatch"*)
  all say so: **a ceiling bounds new work, not the bill.** **(b) An unpriceable call must be charged at
  a high-water estimate, never zero** — Anthropic (*"an ID the meter can't place is never free"*) and
  AgentGuard (*"unknown models are overestimated, not free"*) converge independently. **High.**
- **OpenAI** has shipped org/project **hard spend limits** since Jul 22, 2026 (`429`
  `*_spend_limit_exceeded`; alerts *"do not enforce a cap"*; enforcement *"not instantaneous"*).
  **No model vendor offers a per-API-key spend ceiling**, re-tested through **Oct 5**: Anthropic is per
  *member* and monthly-only on the public API; OpenAI is org and project (**keys are a reporting dimension
  only**); Google is project × single service, monthly, Preview; AWS's new limit is per *project*; Bedrock
  is account-level and alert-by-default. **And the distinction is sharpening, not eroding: vendors are
  adding *identity*-scoped ceilings, not *credential*-scoped ones — which matters for loops, because a
  loop harness holds a key, not an identity.** So METR's *"no way to put a spending limit on keys like
  this one"* still holds. **High** for Anthropic/Google/AWS; **Medium** for OpenAI and Bedrock, whose
  cells still lack a first-party source (backlog).
- **Gateways are where per-key and fleet ceilings exist**: **OpenRouter** per-key budgets (`402`) and
  workspace budgets (`403`) — and since **Sep 28** a Security Center that applies a spend limit to **up to
  500 keys at once** (*"A limit caps what a leaked key can spend."*), the practical answer to "every loop
  got its own key and none of them were capped"; **LiteLLM** budget reservation (pre-flight, on by
  default) and `fail_closed_budget_enforcement`, with known fail-open paths during counter/collector
  outages, so name `fail_closed_budget_enforcement: true` **and** `fallback` over `drop` — ⚠️ **and note
  an exhausted LiteLLM budget now returns `422`, not `429`**, so a wrapper that retries `429` blindly
  would have retried straight through it; **Databricks Unity AI Gateway** (the gateway is GA, **but
  budgets are Beta**, enforced *"approximately"*, with the vendor saying *"Do not use this feature as a way
  to ensure an absolute spend cap"*); **Cloudflare AI Gateway** `byok_only`, though its new x402
  Machine Payments rail is bounded only by a **wallet balance, not a configured policy**.
- **Pattern: on three independent gateways the real ceiling is behind a non-default flag** — *if you did
  not explicitly turn enforcement on, assume you have an alert.* **High.**
- **In-harness libraries**: **AgentGuard** (`BudgetGuard`/`LoopGuard`/`TimeoutGuard`) moved enforcement
  **before dispatch** and fails closed on corrupt counters. Its published **five-class taxonomy** is a
  sharper vocabulary than "alert vs ceiling" and worth adopting — `advisory` · `recorded-budget preflight`
  · `recorded-event preflight` · `reservation-backed` · `unsupported` — where **`LoopGuard` is
  `recorded-event preflight`, which is exactly how hard stop #2 differs from #3**, and only
  `reservation-backed` closes the concurrency hole (*"Two workers can both pass `check()` and both
  dispatch"*). **LoopGain is live, not retiring** (v0.6.5, Sep 30) but scoped to **stop #2**; ⚠️ reject its
  pitch to *replace* `max_iterations` — #1 is a backstop precisely because a convergence classifier can be
  wrong. **Medium** on library specifics — verify against live docs.

**Open human calls this section raises** (full text and evidence in the `sources.md` backlog): adopt
progress-gated continuation, graduated throttling, and context growth / prompt mass / recursion as cost
surfaces; test injected guardrails for delivery; bind the reviewed PR diff to what merges; publish a
budget status-code table (`402`/`403`/`422`/`429`); decide whether this repo's own hourly Routine needs a
**cumulative** ceiling, since a per-run cap *"bounds each run separately"*; and the self-improvement
primitives in §5A.11, now including a **corpus-level re-test**. None is applied by the knowledge base;
each is a human-authored change.

## 7. The one-paragraph answer

Stop being the thing in the loop. Write the loop once, give it **skills** worth
calling and a **verification** step so it can check itself, **cap it**
(iterations + dollars + stall detection) so it provably halts, and let it run
on a schedule while you go decide *what* to build. Steinberger and Cherny are
describing the same animal from two sides.
