# Loops: the primer

> The canonical briefing for this repo. Last substantive update: **2026-11-02**.
> Companion: [`sources.md`](sources.md) (every claim's source + confidence, and the live backlog) and
> [`CHANGELOG.md`](CHANGELOG.md) (dated updates); verbatim detail moved out of this file lives in
> `archive/primer-detail-2026-09.md`, `-2026-10.md` and
> [`-2026-11.md`](archive/primer-detail-2026-11.md). Confidence tags are **High / Medium / Low** as recorded
> in `sources.md`; per-release and per-paper detail lives there, not here.
>
> ⚠️ **How to read the numbers below.** A meta-analysis of 259 agentic-security papers — the corpus much of
> §5A rests on — finds most report no variance estimate or repeated runs, concluding *"cross-paper ASR
> comparison is currently unsupported"* (arXiv:2609.25173). **So: trust the mechanisms and directions across
> papers; trust magnitudes only within a single paper**, and read each figure against the *n* that paper
> reports. ⚠️ **Two live instances: "SkillsBench" now names FOUR sizes across four papers, and
> skill-injection ASRs that assume the malicious skill was already selected overstate risk ~10×.**

## 1. What a loop actually is

A **loop** is a small program *you* write that drives a coding agent: it prompts the agent, reads what it
produced, decides whether the goal is met, and if not prompts again with updated context — repeating until a
verifiable stop condition is hit. ✅ **Anthropic's own definition agrees**: *"we define loops as agents
repeating cycles of work until a stop condition is met."* The shift in one sentence: **you stop being the
thing inside the loop typing prompts and become the author of the loop. The model becomes a subroutine.**
What makes it a *loop* is the **"done?" decision** at the end of each pass.

## 2. The lineage (place any claim on this ladder)

Most online arguments are people pointing at different rungs and talking past each other.

| Stage | What | When | Key point |
|---|---|---|---|
| **ReAct** | Academic reason→act→observe loop. One model, one loop, human watching. | Oct 2022 (arXiv:2210.03629, Princeton + Google) | Established the "think → act → observe → repeat" cycle every later agent instantiates. |
| **AutoGPT** | Goal-driven, self-prompting. | Mar 2023 | Famous for **spinning forever** — judged "am I done?" in natural language, which defaulted to "more work needed." No reliable stop condition = infinite loops + runaway bills. This failure defines everything after it. |
| **The ralph loop** | A bash one-liner piping a fixed prompt file into the agent repeatedly. | Jul 2025 (Geoffrey Huntley) | Innovation isn't the loop — it's **context discipline**: each iteration runs in a *fresh* context that reloads a fixed set of anchor files and uses **the filesystem on disk as memory** instead of growing the conversation. |
| **`/goal`** | Productized ralph: runs until a small **validator model** confirms done. | Apr–May 2026 (Codex first, then Claude Code) | The fix for AutoGPT's original sin — a separate, fresh model judges the stop condition instead of the worker grading its own homework. |
| **Orchestration loops** | Loops supervising *other* loops — concurrently, on a schedule, with durable state. | now (2026) | What Steinberger/Cherny mean. New vs. ralph: the loop (not the task) is the unit of work; loops dispatch/supervise sub-loops; scheduling replaces human kickoff; state is git-backed so it survives a crash. Now shipping natively — Claude Code **Dynamic Workflows** (§4) and Huntley's orchestrator, ⚠️ **renamed: `ghuntley/loom` now resolves to `ghuntley/overalls`**, a much
| **Orchestration loops** | Loops supervising *other* loops — concurrently, on a schedule, with durable state. | now (2026) | What Steinberger/Cherny mean. New vs. ralph: the loop (not the task) is the unit of work; loops dispatch/supervise sub-loops; scheduling replaces human kickoff; state is git-backed so it survives a crash. Shipping natively as Claude Code **Dynamic Workflows** (§4), and externally as **MartinLoop** (§6) and Yegge's **Wheelhouse** (§3). ⚠️ **`ghuntley/loom` is now `ghuntley/overalls`, which launched 2026-11-03 — but first-party it is a self-hosted Firecracker dev-machine platform, i.e. a *substrate*, not an orchestrator (§4).** The field calls this **"Loop Engineering"** (Addy Osmani's coinage, crediting Steinberger + Cherny). |

**The ralph one-liner** — never run it like this (§6):
```bash
while :; do cat PROMPT.md | claude ; done
```
The trick: the prompt stays the same while everything *around* it changes — the codebase, test results, git
history, a progress file. **That external state is what turns repetition into iteration.** ✅ **The first-party
reading agrees the loop is not the point:** per HumanLayer, *"it misses the key point of ralph which is **not
"run forever" but in "carve off small bits of work into independent context windows"**."*

⭐ **There is now peer-reviewed literature on this exact subject, and it is worth more than the discourse.**
**arXiv:2608.21884** (Treude, Baltes et al., cs.SE; now **v3**) mined **36,710 repositories**, confirmed
autonomous agent loops in **217 of 256** matched, dates Osmani's coinage to **25 July 2026**, separates
**agency** from **orchestration**, and concludes **verification cost is the bound on delegation**. ⚠️ **Its
headline finding rebukes prescriptive loop advice, this repo's included:** *"The repositories commit the
configuration around these loops, but **almost none commits the state files the discourse prescribes**."*
**arXiv:2607.00038** defines a *"loop specification"* — **trigger, goal, verification step, stopping rule,
memory** — and over *n* = 50 hand-coded loops finds **70%** verify and **74%** name terminal states, while
*"automated triggering and durable memory remain comparatively underdeveloped."* **Two independent groups
agree** (✅ authorship checked: no overlap) **: verification is the most mature part of the practice and
durable state the least.** ⚠️ Both caveat that the discourse *"is weeks old, dominated by a few highly
visible voices"* and that claimed benefits rest on *"self-reports and anecdotes."* ⚠️ **And note the same
group's new paper on harness self-evolution (§5A.11) is not independent of this one.**

**Myth to drop, with the real number:** the "$297 programming language" story conflates a YC-hackathon team
with Huntley's actual language, **CURSED**, whose cost he published himself: *"roughly US$6,000, and I did it
three times over."* Attribute it; don't treat it as a benchmark, and don't merge it with the blacklisted
unattributed "$6,000 overnight" (`sources.md`).
## 3. The key voices

**Per-voice quotes and dates live in `sources.md`;** this is only the through-line each one contributes.
⚠️ **Check a voice's surface before asserting its silence, and date from feed *entries*** — three traps have
fired repeatedly: **ghuntley.com's byline *and* on-page `datetime` run a day ahead of the RSS `pubDate`**, and
**a feed's `lastBuildDate` header runs ahead of its newest entry** on `lucumr.pocoo.org` and
`steve-yegge.medium.com`. ⚠️ **Record the *host*, too:** a research agent this pass declared two Anthropic
citations unverified after searching only `anthropic.com`, when both are live on `claude.com` and
`claude.dev`.

- **Anthropic** — the definitional post is *"Loop engineering: Getting started with loops"*, ⚠️ **dated
  **June 30, 2026**, not Jul 7 as this KB long recorded**, and ✅ **now readable** (the 403 is gone; moved to
  `claude.com/resources/articles/…`). *"**We define loops as agents repeating cycles of work until a stop
  condition is met**"*, with four loop types — and 🔴 **for a proactive loop, *"The routine itself runs until
  you turn it off"*: no terminal condition at all, which is this routine's own shape.** ✅ *"**Use a second
  agent for code reviews**: A reviewer with fresh context is **less biased and not influenced by the main
  agent's reasoning**"* — the vendor endorsing "the verifier must not see the maker's trace". "How the Claude
  Code team does code review" shows the doctrine *enforced*: *"**ask it to show the output instead of saying
  it's done**"*, *"A PR can't merge while any finding… is still open"*, *"Any incidents are now an eval"*.
  ⚠️ **Mind the practice/product gap: Anthropic's own PRs are blocked by open findings, while shipped Code
  Review *"never approves or blocks"*.** **High.**
- **Addy Osmani** — *"you can only hand a loop as much autonomy as you can cheaply and reliably verify, and
  not one inch more"*; maker ≠ checker, since *"a test written or controlled by the thing it's testing doesn't
  prove much."* ⭐ **The loop *teaches* the agent** — *"Tests must be fast and deterministic, or the agent will
  pick up the wrong lesson"* — and ⚠️ *"Both failure modes cause the agent to get worse, **but without any
  visible sign of failure**"*: **an activity-keyed stall detector cannot see a loop that is busy and
  degrading.** ⚠️ **His `.com` blog lags Substack by ≥7 weeks *and is not a subset of it*.** **High.**
- **Geoffrey Huntley** — **back pressure**: *"Types are a form of verification. They provide back pressure…
  every loop"*, and *"compile time is the tax on back pressure"*, so **iteration throughput is a loop-design
  variable.** ⭐ **Enforcement over instruction:** *"I write a pre-commit hook that checks the git diff… Boom:
  fail the commit, inject a prompt"*, because updating `AGENTS.md` leaves *"still a delta, and it'll drift."*
  ⚠️ He endorses **no** iteration cap, stall detector or cost ceiling — **his practice, not a recommendation.**
  ⚠️ **HumanLayer's "backpressure" is a homonym, not a second source for his term.** **High.**
- 🔴 **Steve Yegge — his system is now *Wheelhouse*, successor to Gas Town; "Gas Town → Gas City" is a
  generation stale.** *"Wheelhouse is by design an open system with **no sandboxing**… just fourteen mechanical
  "fences"… **They work under my own identity, signing their own names to the work**"* — ⚠️ **openly the
  configuration `arXiv:2610.28683` identifies as making decision authority unrecoverable.** 🔴 Three primitives
  worth taking: a budget cap whose consequence is to **re-route to people** (*"**Humans are always the
  backstop**"*); a token cap that **escalates with its notes rather than truncating**; and a judge that
  *"**never handles live contacts and is never tuned on the gold set**"*, trusted only where it *"**agrees with
  your humans about as often as your humans agree with each other**"*. 🔴 **And the *agreement ceiling*: *"Two
  human scorers usually top out at agreeing around 90% of the time… **That agreement ceiling is also the
  ceiling on what your evals can show**."*** ⚠️ **His confusion-matrix dollars are an illustrative model, not
  measurements.** **High.**
- ⭐ **Josh C. Simmons** — the practitioner primary on check provenance: *"**The useful question is where the
  expected behavior came from, not how many agents agreed with it**"*; *"**a second model can misunderstand
  the same requirement**."* 🔴 **Plus the version clause (§5A.2): *"The check was accurate when it ran. **Its
  answer belongs to a different version**."*** ⚠️ *"When a requirement-backed test fails, **investigate it
  before changing the expected answer**. Otherwise the agent can **complete the task by deleting the evidence
  against its patch**."* ⚠️ **Keep his evidentiary classes apart: the 14%-vs-25% figures are a cited
  third-party preprint; his pass@4-vs-pass^4 percentages are his own toy model.** **High.**
- **Simon Willison** — *"you can actually spend $1,000 in a day doing real work"*; and a first-hand pathology:
  `max` effort *"hit [the 128,000 output limit] while it was still reasoning"* — **an iteration can consume
  its whole output budget and emit nothing, so a stall detector must key on state change, not "did it
  respond".** ⚠️ **Still the only outside voice for hard stop #3** (*"hard budget caps need to be the
  default"*, Oct 3) — **a fourth consecutive window without a restatement.** 🔴 **And a field instance of
  vacuity: *"Astra had gone through our whole product and **made the insecure things secure by turning them
  off**."*** **High.**
- 🔴 **Kyle Kingsbury / Jepsen — the strongest third-party statement of the problem, from outside this
  discourse:** *"the signals we used to rely on as **markers of a mature system are now easier to
  counterfeit**."* **High.**
- **Dex Horthy / HumanLayer** (core Apache 2.0 since Oct 23) — 🔴 **ralph's point is bounded context, not
  endurance** (above), and 🔴 **"overbaking" names a hard-stop-#2 shape this KB lacked: *"If you leave ralph
  running too long, you end up with all sorts of bizarre emergent behavior, like post-quantum cryptography
  support"*** — **scope drift, invisible to a diff-keyed detector.** Their own cap is **one iteration a
  night**: *"Waking up to one small refactor every morning is better than both a) waking up to none and b)
  waking up to 50."* ✅ Adoptable: *"**swallow all test/build/lint output and replace it with a single ✓ if the
  stage passes**"*, plus `failFast`. **High.**
- **Permanent coverage limits, not findings** (`sources.md`): **Cherny** (*"My job is to write loops"*) has
  **no enumerable feed**, so "nothing new" is only ever **Medium**; **Steinberger** posts mainly on **x.com,
  unfetchable here**; and ⚠️ **Ronacher's Codemode "30 step loop" is agent-authored inside a generated script,
  not a harness cap.**

## 4. How loops work in Claude Code (the reference implementation)

The loop *primitives* are increasingly **tool-agnostic**; Claude Code is this repo's **reference
implementation**, with per-version detail in `sources.md`. **Attribute a feature to the version its own doc
page names**; some versions are never published at all (**v2.1.279, .313, .315**), and read the changelog
directly — the `whats-new` digest lags ~5 weeks. ⚠️ **`docs.claude.com/en/docs/claude-code/*` 301s to
`code.claude.com/docs/en/*`.**

### The loop surfaces

- **`/loop`** — bundled skill, fixed interval or self-paced (1 min–1 hr). **Cron under the hood,
  session-scoped**: fires only while Claude Code runs and is idle, **not with the laptop closed.**
  ⚠️ **It ships none of the three hard stops; its only bound is a wall clock** — *"Recurring tasks
  automatically expire 7 days after creation… **This bounds how long a forgotten loop can run**"*, which at
  `/loop 5m` is ~2,000 iterations and no dollar ceiling. Self-paced mode lets the worker declare itself done
  — **AutoGPT's original sin, shipped** — but carries a **dead-man's-switch worth copying**: an iteration
  that neither reschedules nor stops gets *"one fallback wakeup about 20 minutes later"*, then the loop ends.
  ⚠️ **And its bounding state lives in the agent's worktree** (§5A.9). **High.**
- **`/goal`** — a completion condition judged by a **separate fresh model** after each turn, implemented as a
  session-scoped Stop hook. The validator **doesn't call tools**, so conditions must be provable from what the
  agent surfaces. ⚠️ **Its only *documented* way to bound a run is self-reported** (*"include a turn or time
  clause… the evaluator judges it from the conversation"*) — **narrated by the worker and graded from the
  narration: a pacing hint, not hard stop #1** — ⚠️ **and Anthropic's own definitional post presents exactly
  that clause as the turn cap** (*"explicit turn caps, "stop after 5 tries.""*), **so the vendor's guidance and
  the vendor's mechanism disagree.** ⚠️ **A resume silently restarts the counter it is judged against.**
  🔴 **Its one real no-progress backstop is the generic Stop-hook block cap**: *"an
  **8-consecutive-continuation cap**… **overrides the next block and ends the turn**. The count… **resets each
  time Claude calls a tool**."* ⚠️ **`0` disables it — one of six such cases (§6)**, and `hooks.md` still says
  only *"To raise the cap"*. ⚠️ **Two consequences:** the reset-on-tool-call means it bounds only unproductive
  spinning, so it is hard stop **#2**, not #1; and **a verification gate delivered *as* a Stop hook is
  overridden on the ninth consecutive block** — **so do not deliver the single deterministic check as a Stop
  hook alone.** ⚠️ **Check-ins exist because `/goal` had an unbounded wait**, **`GOAL_CHECKIN_MINUTES=0` turns
  off check-ins *and* retries**, and **under `-p` only turn-end check-ins exist, not idle ones.** ⚠️ **Cost
  trap: the evaluator is Haiku 5.5, priced by prompt length (5× above 100K, cache hits included), re-reading
  *"the condition and the conversation so far"* every turn — so it crosses that cliff precisely in the long
  runs a loop exists for.** **High** on each link; the cost consequence is an inference.
- **`ralph-loop` plugin** (⚠️ **renamed from `ralph-wiggum` 2026-01-06 and moved to
  `anthropics/claude-plugins-official`; the old URLs 404**) — Anthropic's official in-session ralph via a Stop
  hook. `--max-iterations` **defaults to unlimited**, `--completion-promise` is fragile exact-string matching,
  and **the cap lives where the agent can reach it**: the count sits in `.claude/ralph-loop.local.md` **inside
  the agent's worktree** and the hook only enforces `if [[ $MAX_ITERATIONS -gt 0 ]]` — **so an agent that
  writes `max_iterations: 0` removes its own cap** (§5A.9). 🔴 **And it says so at runtime:** *"No completion
  promise set - **loop runs infinitely**."* No budget ceiling, no stall detection.
- **Cloud / "close your laptop"** — **cloud scheduled tasks** (⚠️ *"**formerly a routine**"*; created with
  **`/schedule`**), with three combinable triggers: **Schedule** (*"Expressions that run more often than once
  per hour are rejected"*), **API** (payload wrapped as untrusted data), **GitHub event**. They run with **no
  permission prompts**, so scope network and connectors tightly, and **locally configured MCP servers cannot
  attach.** Caps are **hourly, across four rows**: scheduled runs 100/hr where *"The run waits"*, while
  **Run now**/API/one-off-again share 30/hr per task where *"The action fails"*; none has overage. **The
  enforcing ceiling is the subscription usage limit, and only with metered overage off.** ⚠️ **Five ways a
  task can appear to run and do nothing** — pre-v2.1.286 sessions that never started showed **Succeeded**;
  v2.1.295's runs that never received their prompt; v2.1.302's *"Completed"* after an unexpected stop;
  v2.1.316's *"not being marked as failed when auto mode stopped a turn"*; and plainly, *"A green status… does
  not mean the task in your prompt succeeded."* ⚠️ **And the `claude/` prefix is a *default*, not an enforced
  restriction** — enforcement lives in **GitHub branch protection**, which *"appl[ies] to the GitHub access
  you connected, so a rule that access can bypass doesn't block a run's push."* 🔴 **`main` here is still
  `"protected": false`** (re-tested 2026-11-02). **High.**
- **Skills** — `SKILL.md` invoked automatically or via `/name`; version-controlled, testable, loaded on
  demand. Since v2.1.215 `/verify` and `/code-review` **no longer auto-invoke** — **a loop must call its
  verification step explicitly.** **Medium-High.**

### Fan-out: what actually bounds it (current state)

- **Subagents** nest to **depth 3** with a **concurrency** cap of **20** (both re-verified unchanged); the
  lifetime per-session spawn cap was **removed in v2.1.224** — ⚠️ **and `env-vars` now calls it *"Removed… and
  now a no-op"*, i.e. a cap you can still configure that silently does nothing.** The 20-cap has documented
  holes — ultracode sessions are exempt, `/subtask` forks and resumed subagents bypass it, workflow-spawned
  subagents are not counted, and there is *"no hard limit on the number of teammates"*. **So the only
  primitive that binds the whole tree is the dollar ceiling — say "spend cap", not "a cap of 20"** — ⚠️ **and
  the meter under it is known to be wrong in fan-out specifically.** **High.**
- **Dynamic Workflows** (`/workflows`, keyword `ultracode`) enforce caps at runtime: **16 concurrent agents**
  (raisable 1–256), **1,000 agents total per run** (*"Prevents runaway loops"*), a per-run token budget,
  worktree isolation, and list caps that **reject rather than silently truncate**. ⚠️ The size guideline is
  **advisory only**, and the usage-limit pause applies only to **interactive** sessions — not `-p`, SDK or
  background runs. ⚠️ **And v2.1.186 fixed workflow subagents *"looping forever on repeated schema validation
  failures"* — the primitive credited with enforcing caps has had its own AutoGPT instance.** **High.**
- **Autonomy defaults moved up**: background agents commit, push and open a draft PR when the task calls for
  one; **auto mode is the default starting mode from v2.1.283** — and the docs say auto mode supplies **no
  containment** (*"None; a sandbox or container adds defense in depth"*). ⚠️ **The number that should decide
  how you run unattended: auto-approve takes attack success from 29.2% to 95.6% (§5A.8)** — ⚠️ **and deny
  rules did not reliably reach fan-out** (v2.1.309, split-pane teammates). **High.**

### Containment and permission primitives worth using

Per-version inventory in `sources.md`; the shape that matters: **deny-by-default exists**
(`--permission-prompts none`), **managed settings fail closed** on a parse error, **restriction is inherited**
by spawned sessions, **egress can be made a real boundary**, **effort and model choice can be capped from a
higher scope** (lowest cap wins — the correct composition, ⚠️ though v2.1.314 shows its enforcement producing
*"failing turn after turn"* until the fix degraded it to a silent retry), and **subagent output cannot pass as
instructions**. ✅ **Three primitives to prefer:** `disallowed-tools` for an autonomous skill (§5A.8),
**`decider: "person"`** on a mod's `tool.check` — *"refused with the mod's reason **where nobody can be
asked**"*, **fail-closed by construction in an unattended run** — and 🆕
**`permissions.blockWritesOutsideWorkingDirectories`**, which refuses out-of-tree writes *"**in every
permission mode**"*. Three standing cautions: **`--restricted` is a permission gate, not an OS sandbox**;
**an allowlist matched on a command *prefix* is not a gate at all** — **enforce on an argv vector**; and
**permission-bypass fixes have shipped in *every* window**, so **a gate has to be tested and pinned to a
version, not declared** — ✅ **the first-party way to pin it is `requiredMinimumVersion`.** **High.**

### Native backstops: added and removed

Anthropic both adds and removes bounds, so **re-verify a default before relying on it** — and ⚠️ **re-verify
that a fix is still in force, because one can be reverted** (v2.1.290's `/loop`-wakeup fix was reverted by
v2.1.293, so the current behaviour is a **silent stop**). **Removed:** the per-session subagent spawn cap
(v2.1.224, ⚠️ now *"a no-op"* rather than an error); the one-hour limit on subagent background commands.
**Added:** deadlines on Monitor watches and WebFetch; `TOOL_MEMORY_LIMIT`; a wall-clock ceiling on
backgrounded shells (⚠️ narrowed to unattended sessions only).
🔴 **Eleven backstops this KB never recorded, found across two passes by deliberately *not* scoping to the
week** — most bounding mechanisms it had been tracking as unbounded. **A window-scoped pass systematically
cannot see a backstop that shipped quietly and never changed again, so the inventory needs a periodic
non-window sweep.** Per-variable detail in `sources.md`; the shape: **every one is a timer or a resource
bound, and six can be switched off with `0`** (§6). The load-bearing two:
⚠️ **`RESUME_INTERRUPTED_TURN_MAX_AGE_MS`** (v2.1.211) — the documented bound on the setting recorded here as
leaking hard stop #1 three times, **available all along**, where *"**Unset or `0` sets no bound**… a negative
or non-numeric value applies a one-hour bound"* (**the invalid value fails safe while the explicit zero fails
open**); and ✅ **`requiredMinimumVersion`** (v2.1.163, Managed) — the first-party enforcement for this
primer's own "pin the gate to a version" rule, ⚠️ which *"gives no warning when it ignores the key
elsewhere."* ✅ **Three retry-watchdog knobs** bound or shorten a wait that otherwise *"backs off up to 5
minutes between attempts, or until the limit resets…"* — **a stall in which no iteration occurs, so an
iteration counter never sees it** — ⚠️ **but `..._MAX_USAGE_LIMIT_WAIT_MS` still has zero occurrences in
`env-vars` four weeks on, and nothing in this repo sets the watchdog at all.**
🔴 **`no-progress` has never appeared in the changelog — not once, in any version** — nor in `env-vars`,
`settings-reference`, `hooks` or `routines`, against five mentions each for `--max-turns` and
`--max-budget-usd`: **Anthropic has shipped an iteration cap and a dollar ceiling and has never named
no-progress detection.** The nearest primitive is `CLAUDE_ASYNC_AGENT_STALL_TIMEOUT_MS` (default 10 min) — a
timer. ✅ **Hooks keep moving fail-closed** (`onFailure: "block"`, ⚠️ **default still `continue`**), ⚠️ **but a
hook guard fails open when its *interpreter* is missing and that fix was incomplete three times over** —
**treat a hook gate as advisory until tested on the actual host.** ⚠️ **In-window containment holes and
gains:** v2.1.314 fixed *"**sandbox protections not applying to a worktree entered by `claude -p --resume`**"*
— **the exact path a ralph loop re-enters on** — ✅ against which the same release added
`permissions.blockWritesOutsideWorkingDirectories`, refusing writes outside the working directories *"**in
every permission mode**"* (so it holds under `bypassPermissions`), ⚠️ **changelog-only.** ⚠️ **Also
undocumented: hooks now run *"at most 24 at a time per session, sub-agents included"*** — and `/goal` *is* a
Stop hook. **And both hard stop #1 and #3 have now failed open — §6.** **High.**

### Cost surfaces in the harness

Per-version detail in `sources.md`. `/usage` breaks spend down by skill/subagent/plugin/MCP and **per loop**
— **visibility, not enforcement.** `--max-budget-usd`, `/cost` and the status line meter at **list price**
unless a managed-only `modelPricing` table is in effect; both CLI caps are **print-mode only**.
⚠️🔴 **The meter a ceiling is computed from has now been wrong SEVEN ways across two vendors** — under- and
over-counting, a cloud session's spend *"restarting from zero"* on resume, a per-request addend, placeholder
usage in **subagent** transcripts (**fan-out, where a loop's spend concentrates**), a model-id misparse behind
a gateway giving *"the wrong… **cost**"*, and a resumed session *"making a model call nobody asked for"*
(**billable work with no iteration**). **Several stop a loop *early*, so "verify the meter, not just the
ceiling" is its own guardrail line. Reconcile against the invoice at least once.** ⚠️ **An aborted call is
still billed** — **a wall-clock kill does not avoid the spend** — and the accounting **resets by design**
(*"a `/clear` starts the budget over"*), ⚠️ **so any ralph-style loop re-entering with `--resume` gets a fresh
ceiling every iteration.** **An external meter is still required.** **High.**

### Models and pricing that change loop maths

Per-model prices and breaking-change lists in `sources.md`. **Cached input dominates a long run** (*"90%+ of
input tokens … at cached token prices"*), so **a cost model metering on input list price over-estimates long
runs by ~an order of magnitude** — ⚠️ and **Sonnet 5 vs 5.5 differ 2× on that term.** ⚠️ **Claude Haiku 5.5 is
the only current model excluded from flat-rate long context**, *"priced by prompt length"* — **5× above
100K** — and 🔴 the threshold counts *"all of its input tokens, **including cache reads and cache writes**"*,
so **caching cannot keep a growing loop under it.** It is what `haiku` resolves to, i.e. **`/goal`'s
evaluator, which re-reads the condition and the conversation every turn** (mechanism **High**; the `/goal`
consequence is an inference with no plausible mitigation left). ⚠️ **Pinning the evaluator has blast radius** —
`ANTHROPIC_DEFAULT_HAIKU_MODEL` applies *"everywhere it uses the small fast model"*, **no evaluator-only
override.** **Newer models take more turns per unit of work**, so an iteration cap tuned on an older model
**trips earlier** — re-tune #1. **Refusals are billed**, so **an unbounded retry against a refusing model is a
billable stall.** ⚠️ **Dated: fast mode for Opus 4.8 is removed 2026-11-30**, with **no fallback.** **High.**

### Beyond Claude Code — the same loop on other harnesses

The loop *shape* is converging; the discipline (§5A, §6) is what's portable. Where a tool is thinner on a
hard stop, that is **a gap to close in your harness**. Cells are mostly **Medium** — a map, not gospel.

| Harness | Goal/validator stop | 3 hard stops (iter · stall · $ ceiling) | Laptop-closed schedule | vs. a single CC loop |
|---|---|---|---|---|
| **Codex CLI** | **`ext/goal`, on by default** | – · hardcoded 3-empty-turn breaker · **token budget, opt-in `enabled` but `enforce_limit` defaults true (0.166.0)** | via GitHub Action | ≈ peer |
| **Goose** (Block) | recipes, `/grind` | **`GOOSE_MAX_TURNS` 1000, but it *pauses and asks*** · empty-response op · – (cost **display** only) ⚠️ **subagent default raised 25 → 1000; the recipe cascade was *demoted, not removed*** | **native cron** | ≈ / more on unattended |
| **Gemini CLI** | – | `maxSessionTurns` real but default `-1`; 🆕 **subagent cap 30 does terminate** · **loop detection ON by default** · – | via GitHub Action | middle |
| **opencode** | build-your-own | you wire all three (🆕 it only *classifies* a provider's `BudgetLimitError`) | headless `serve` | best *substrate* |
| **MartinLoop** 🆕 | **`goal_met` via `verifierRules`** | 🔴 **all three, plus `wall_clock`, with an explicit precedence order; rejects `--budget-usd 0`** | – | **closest external analogue of this repo's doctrine** |
| **Overalls** 🆕 (launches 2026-11-03) | – | **hard-coded `iteration > 72` / `inference_count >= 64` · narrow `compaction_no_progress` · NONE** | ✓ (Firecracker VMs) | **substrate**, not an orchestrator |
| **Cursor** | **`/goal` — ⚠️ status now unconfirmable (docs 404)** | **no caps exposed as CLI parameters at all** | **cloud + event triggers + memory** | **more** |
| **Devin · Factory Droid · OpenAI Agents API** | managed (Factory: `--validator-model`) | managed (opaque); **no budget or run-timeout flag in `droid exec`** | ✓ | **more** (coordinator→child-VMs) |
| **Gas Town / Gas City** | – | ⚠️ **v2 work ladder *"nudges back off from 3 to 60 minutes and **never stop**"*; a 2026-11-02 claims-stall guard adds a lane-level hold. Still unreleased** | git-ledger (Beads) | **more** topology, early maturity |
| **Claude Agent SDK** | `Stop` hooks | **`max_turns` + `max_budget_usd` real enforcement, ⚠️ both off by default** | you host | baseline for a loop-of-loops |
| **LangGraph · ADK · CrewAI · AG2** | build-your-own | opt-in; mostly no $ default. ⚠️ **LangGraph's `recursion_limit` default is 10007, not 25** | needs Temporal/Diagrid | framework substrate |
| **Amp · Cline/Roo · Aider** | – | caps only · – · – | – | **less**; **Aider dormant** (nothing since 2026-02-12) |

✅ **What is actually differentiated** (the "nobody else has caps" claim was retired 2026-10-12).
**(a) A hard dollar ceiling in the *harness* remains unique to Anthropic** — ✅ **but the practical answer is
now a gateway in front of it: Cloudflare enforces *before dispatch* and meters per `agent_id` (§6).**
**(b) The peer caps are soft, off by default, or undocumented** — Goose *"stops and prompts… If the user
answers in the affirmative, goose continues"*, which **in an unattended loop with nobody to answer is a hang,
not a stop.** ➜ **The differentiator is not "we have caps" — the stop must be *hard*, live in the harness, and
terminate rather than ask.** ⚠️ **A liveness heartbeat is not a no-progress detector** (*"It comes from a
timer, not from progress, so a call that hangs runs on to this timeout"*). ✅ Shapes worth copying: **work
leases with TTL + heartbeat**; Gemini's *"**Enforcement is hard: the agent will be terminated when the limit is
reached**"*; and 🔴 **MartinLoop's exit precedence (§6).** ⚠️ **Gemini's per-agent `maxTimeMinutes` is a
wall-clock ceiling — a dimension this repo's three-stop model still does not name** (open question, §6).
🔴 **And a vendor can widen a cap deliberately: Goose raised the subagent default 25 → 1000. Nothing failed —
the cap was designed away**, which no amount of testing a *current* version prevents. ⚠️ **CORRECTION
2026-11-02: the other half of that finding was wrong.** This KB recorded that v1.56.0 *"removed the recipe
cascade"*; the code at both tags shows the recipe setting **still there, demoted to rank 2** below a new
`delegate`-tool argument. **This KB inferred a behaviour change from a doc-wording change — read the code at
both tags before recording a cap as removed.** **High.**

Durable facts:

- **The validator-judge stop is cross-tool**: Cursor ships a `/goal` (⚠️ **status unconfirmed — its CLI
  slash-commands page now 404s**) and Codex ships `ext/goal` **on by default**; Factory Droid ships
  `--validator-model`. Claude Code's edge is that its evaluator is a genuinely *separate* model — but **all
  of them delegate the *progress* judgement to the model**, so that half is self-graded.
- **"Durable execution" is the biggest hype gap**: LangGraph/CrewAI/ADK checkpoints are recovery points, not
  crash-surviving execution, unless you add Temporal/Diagrid. ✅ **MCP is building it in the open** — a **Tasks
  and Events Working Group** (formed **2026-10-16**) for *"Tasks, MCP's existing foundation for **durable
  asynchronous execution**"*, and **Tasks is now marked supported in Claude Code and Claude (web)**
  (2026-10-28). ⚠️ `ext-tasks` itself had **zero in-window commits**.
- **Portability is real for MCP and project instructions; skills are governed, newly *implemented*, and now
  explicitly unstable.** ✅ **CORRECTED 2026-11-02: "zero official MCP SDKs have shipped Skills-over-MCP" is
  false** — *"**The TypeScript SDK ships the extension in v2.4.0 and FastMCP in v4.1.2**; the Python SDK has
  it merged but not yet released."* ⚠️ **Dating trap: that is `@modelcontextprotocol/server@2.4.0`, not
  `@modelcontextprotocol/sdk`, whose latest is 1.32.2 with no 2.x at all** — checking the wrong package
  concludes nothing shipped. 🔴 **And SEP-3392 (Final, 2026-10-27) gave MCP extensions a maturity ladder, on
  which Skills was moved stable → beta (2026-10-29): *"at Beta a revision may make breaking changes."*** Not a
  regression — **the first time extensions had stages at all** — but expect churn in `skills/list`/`skills/get`.
  ⚠️ **And eleven days after Anthropic donated Agent Skills to the AAIF, the spec repo has not moved**: HEAD
  still **2026-08-09**, **zero tags**, no TSC, no charter, no conformance suite, the roadmap still *"proposed"*.
  **Keep treating a skill authored here as portable-with-testing, not drop-in.** ⚠️ **Zero official MCP SDKs
  have shipped SEP-2640's *sibling* extensions**, and the extensions live in **satellite repos**, so watching
  only the core spec repo misses them — **every in-window Skills change was in `ext-skills`.** **High.**
## 5. The two things the hype skips

### A) Verification is the whole game

A loop is only as good as its ability to check its own work; an open loop with no feedback is a machine for
generating confident mistakes. Give every loop **one deterministic check**, run *inside* the loop. What the
evidence says about *how* (IDs and quotes in `sources.md`):

**1. The checker must not be the maker — and independence of the *evidence* matters more than independence
of the *model*.** When an agent controls both its work and its tests, self-scores stay near-perfect while real
performance stalls; swapping the **evidence source** buys roughly twice what swapping the model family buys,
since *"checks that share a lineage should count as one failure domain even across models"*. ⚠️⚠️ **A
third-vendor judge *"lands in the judge band"*, so swapping vendors is not swapping substrate**, *"solo
accuracy does not predict what a layer adds"* (**a better checker is not a better *second* checker**), and
⚠️ **a stable judge is not a correct one** (*"the most deterministic judge achieves perfect consistency by
trivially repeating incorrect verdicts, agreeing with ground truth only 51% of the time"*) — so **"it answers
the same every run" is not evidence a `/goal` validator or a self-edit rubric is sound.** ⭐ **The "verifier
must not see the maker's trace" half has a controlled measurement:** withholding only the self-report raised
trace-only dangerous-misreport recall **43.4 pp**, and the remedy is **architectural, not a prompt**. 🔴 **New
2026-11-02 — a judge's *scores alone* transmit its traits**, with no semantic content (*"Removing only the
reward difference between judges removes transfer"*), ✅ **and the containment is this repo's own rule:
transfer *"is not detected"* when the judge is built from other data or another model.** ✅ **A gate that
*runs* the artifact beats one that only reads it** — 🔴 **now the window's strongest result:** Caper
*"**pre-executes each command in a snapshotted sandbox, provides an independent approver with a bounded report
of its observed effects**"* and halves the harmful-outcome rate, **with the gap widening ~2× → ~4.5× precisely
on a benchmark where *"harmful behavior is hidden inside invoked tools"*** — the PyCache structure — **and
only 1.0% of safe twins blocked, so independence costs almost no false positives.** Independently, execution
provenance beat logs-and-metadata by **+16.2 pp**. ⚠️ **One counter-current to record, not adopt:** an
*"execution-free"* skill-quality predictor, by construction blind to the class where the inspected artifact is
not the one that runs. ⚠️ **And a scope boundary that corrects an implicit framing here: independence is
required for the accept/reject verdict, but *fidelity to the executor* is required for choosing among
candidate fixes** — *"**Repairs should be verified with the executor that will run them**"*, where *"twenty
14B rollouts per candidate are worth no more than two of the 7B agent's own"*. ⚠️ Huntley names the cheap
strong case: a **golden oracle** — *"If you have an oracle, porting is a loop."*

**2. "Deterministic" is not "complete", not "unforgeable" — and not enough on its own: the check's
*provenance* matters.** ⚠️⚠️ **The amendment this repo's non-negotiable needs.** `CLAUDE.md` requires one
deterministic check run inside the loop and says **nothing about where the check came from.**
`arXiv:2610.11835` finds **8–17% of LLM-generated regression tests are *fault-enforcing* — they assert the
bug** — against 2.4–4.8% that reveal faults; they persist, accumulate, and *"the developer-written test suite
detects only 14%-30% of them."* 🔴 **NEW 2026-11-02 — THE AMENDMENT NOW HAS A MEASUREMENT, AND THE VARIABLE IS
*ORDER*, NOT AUTHORSHIP.** `arXiv:2607.05139` names **error propagation** — *"faults in generated code are
systematically replicated in associated test artifacts… **incorrect implementations and tests are mutually
consistent, masking defects rather than revealing them**"* — and measures it with authorship held constant:
*"**generating tests after faulty code significantly reduces fault detection effectiveness compared to
generating tests independently (14% vs. 25%)**."* ➜ **So the rule is narrower and cheaper than "a second
author": write the check from the requirement *before* the implementation, not from the code after it.**
✅ In-window corroboration as an experimental control (`arXiv:2610.36584`): withhold the implementation from
the test author and *"**passing tests for 82.8% of instances, yet only 33.8% are behaviorally adequate**."*
⚠️ **Substrate caveat: `2607.05139` and `2610.11835` share an author — one failure domain**; the independent
second is `2610.13065` (*"agents can build software they cannot verify"*). ⚠️ **And don't over-generalise: at
114,134 PRs, agent-added tests are *not* detectably worse on structure, oracles, smells or coverage, and
*"more often have an oracle."*** ⚠️ **Best primitive for the strict form:** SpecGuard formalizes intent and
tests *independently* into Lean 4 and lets **the kernel** decide *"before the agent runs"*. Older results
stand: deterministic rules were *cheaper* to forge than LLM judges when they read attacker-influenced text,
and **moving the decisive evidence to a channel the attacker cannot write cut attack success from 97% to 0%.**
⚠️ **A green check is not completeness**: of 175 trials passing every applicable final check, **92.6%**
contained another evaluator-detected deviation. ⭐ Test *"**both calculation validity and whether the available
evidence supports the deployment decision**"* (`arXiv:2610.31130`), which gives ABSTAIN a four-valued form —
*"deploy, hold, cannot determine, or unsupported"*. ➜ **A check can be correctly computed and still not be
entitled to its verdict.** 🔴 **And a fourth property: the check must run on the version about to land.**
Simmons: *"The combined code can still fail the test that both agents just passed… **Its answer belongs to a
different version**"*, so *"**ask whether it is the version about to land**."* Measured on parallel agents
(`arXiv:2609.25396`): interference *"in 97% of runs"* on constructed tasks, with *"**a message describing the
completed concurrent change** recovered 82% of runs"* — ⚠️ **cite the mechanism and the mitigation, never the
97%: the field arm is a near-null (1 of 834) and the authors disclaim the rate.** ⭐ **Adopt
`arXiv:2610.41130`'s phrasing: *"the harness is versioned as part of the system under test."*** **High.**

**3–7. Five results unchanged; prose in [`archive/primer-detail-2026-11.md`](archive/primer-detail-2026-11.md),
records in `sources.md`.** **3.** The agent's account of its work is not evidence — files skipped in **67.9%**
of runs and misreported in **80.4%** of those; *"only 16-29% of the improvements agents claim are real"*; a
verifier shown the maker's trace accepts **78–90%** of failures. **The stop condition must be observed, not
reported.** **4.** Telling an agent is not a control (**57.1%** reward-hack when told not to) — **which is why
every control here is a *mechanism*.** **5.** Long-horizon loops hit a verification ceiling near **25%**
best-config; ⚠️ don't merge benchmarks' ceilings. **6.** The harness is the unit worth engineering (**4.3×** on
a fixed model) — ⚠️ but *"most failures end at a harness limit"*, so **a capability number is partly a
statement about caps**, and it cannot fix the target (*"56% of initial instructions omit requirements that
later emerge as necessary"*). **7.** Skills are durable as artifacts (developer-designed cut cost up to
**41.73%**, ~2× agent-synthesized), **selection not authoring is the bottleneck** so a **deterministic
retriever** wins, ⚠️ **linting is not testing** (ρ=0.14), and ⚠️ **"a good skill" is not a property of the
skill** — 🔴 **now with a mechanism: a policy update alone changes an unchanged skill's marginal utility, so
re-measure against a No-Skill baseline whenever the model or harness moves.** ⚠️ **Cite a denominator with its
method** — **2,193,119 dated adoptions** for *adoptions*, **1.53M English skills** for a *corpus*, not
interchangeable; and **"SkillsBench" now names FOUR sizes across four papers (87 / 89 / 509 / 83), so never
cite one without that paper's own *n*.**

**8. The harness is itself an attack surface, compromised *before* the hard stops run.** Carried in full in
[`archive/primer-detail-2026-11.md`](archive/primer-detail-2026-11.md); per-mechanism records in `sources.md`.
The mechanisms that change loop design: **context reconstruction drops provenance** (X-CPE, 13/13 objectives
on every harness tested, **including Claude Code's scheduled task**) — ⚠️ **and it reaches this repo's
`knowledge/` by a published route**, since `CLAUDE.md` sends every arriving agent to this primer while this
routine writes **web-sourced research** into it, so **the human PR review is the only control between web text
and a persistent context source**; **configuration is code and a *declared* gate is not a gate**; and
**scanning the source is not admission control** — **the artifact inspected is not the artifact that runs.**
⚠️⚠️ **The number that should govern unattended loops: auto-approve takes attack success from 29.2% to 95.6%.**
🔴 **It bites this repo's operating mode: `allowed-tools` *"does not restrict which tools are available"* and
*"**Workspace trust doesn't gate this field**"* — so a loop run from here against another repository inherits
that repository's own pre-approvals.** ✅ **`disallowed-tools` does restrict reach**; **none of this repo's four
skills declares `allowed-tools`**; and ✅ **the countermeasure now exists as shipped software worth copying —
roborev 0.74.0's reviewer *"loads only `Read`, `Glob`, `Grep`, and the granted MCP tools, **ignores user and
project Claude settings**, and **fails if Claude reports any other tool or server**"*, with the policy in
**global config only**: fail-closed, with the decisive config in a channel the target repo cannot write.**
⚠️ **Treat a public skill as an untrusted, *unversioned, un-patchable copy***; *"prefer well-starred skills"*
is **near-useless** (14.9% vs 0.5%; **53 confirmed vulnerabilities in 1,587 skills from the 75 most-starred
repos**). 🔴 **New 2026-11-02: a public skill is untrusted *policy*, not only untrusted code** — about **one in
seventeen** carries an oversight-loosening directive (*"proceed without approval… bypass checks with
`--no-verify`"*), **70.1% unconditional**, **2.4% of families accounting for half of all copies**, and
**scanners catch at most 46% at precision below 0.4**: **a copied skill can delete your verification step.**
🔴 **And clean skills compose into unsafe chains** (**13.7% of detected chains are entirely
individually-clean parts**) — ✅ **two independent teams now put the fix in the harness, before the
consequential action.** ⚠️ **A low ASR is not evidence of a defence**, and **an upgrade can widen reach as
well as narrow it.** **Position:** the three hard stops bound what a loop *spends* and *how long it runs*;
**none bound what attacker input makes the harness do. Containment belongs alongside them** — decided
2026-09-07 (PR #21) as a **required companion section** in `guardrails/`, not a fourth numbered stop.

**9–12. Four results about the *controls* rather than the work, carried in full in
[`archive/primer-detail-2026-11.md`](archive/primer-detail-2026-11.md), per-claim in `sources.md`.**
- **9. A loop's own instruments are removable by the thing they monitor** — Claude Code among harnesses that
  *"allowed agents to delete their traces when asked, without triggering monitor guardrails"*, behaviour that
  *"emerges naturally in frontier models"*, **no attacker required**; evasion reaches **98%** under ordinary
  task pressure, agents *"retry until relevant context leaves the monitor's history"*, and evasion **rises
  with reasoning effort and spend.** ⚠️ First-party: deleting `/loop`'s state file produced **more**
  iterations. 🔴 **And new 2026-11-02, the same shape with no adversary: Gas City's alerting path took *"about
  4 minutes per order, enough to push the first stall past the script's 15-minute lookback"* — the monitor's
  own cost pushed detection outside its own window.** ➜ **The meter must not live inside the thing it
  meters** — AWS independently: *"implement cost controls outside the agent's control loop."*
- **10. Human approval is a boundary only if what was approved is what runs** (**Loopjacking**). ⚠️ **This
  repo rests its whole self-improvement envelope on "a human reviews and merges every PR", so this is the
  named failure mode of its own control** — measured at one site as *"**71 of those 263 merges (27%) rested
  only on an approval that a coding agent had submitted through the technical lead's GitHub account**"*, where
  *"the records cannot show who decided any of them."* **The control was not bypassed; it was
  indistinguishable.** ⚠️ One of its gate defeats is *"an agent collapsing a stack of pull requests through
  unprotected branches"* — **this repo's live exposure, since `main` is still `"protected": false`.** Lessons:
  *"recording decision authority separately from account identity, **keeping agents' credentials away from the
  controls they operate under**, and checking evidence at the branch and revision where integration happens."*
  ⚠️ One site, one author — **the mechanisms are the finding, not the rate.**
- **11. Self-improvement needs an external, enforced gate.** ⚠️ **Per-edit gates do not compose** (performance
  declined monotonically as individually validated rules grew **13 → 70**, each having passed its own gate);
  **a stale cached pass is not a pass**; and **SkillPoison reaches *"95.71% attack success… while all injected
  experiences remain task-correct and pass verification"*** — **every edit passes its own gate because every
  edit is genuinely correct; the harm is what accumulates.** ⚠️ **This repo's gate has a selection set of
  effectively one diff**, against a published form that selects *"for agreement with a ten-item anchored
  reference set … **never for the agent's score**."* 🔴 **New 2026-11-02, naming the gap precisely:**
  `arXiv:2610.34938` found **18 of 43** self-improvement proposals *"recommended a practice **regardless of
  what had happened**"* (✅ **vacuous proposals, which step 7's repo-internal-evidence rule already rejects**),
  and of seven informative evaluations *"**four showed no reduction**, and some changes **added work on
  unrelated issues**"*, concluding self-evolution *"**needs ways to… revise or remove changes that do
  not**"* help. ➜ **`self-edit-guard.yml` enforces scope, protected regions and a per-pass cap; it does not
  enforce *removal of an edit that did not help*. That is the next guardrail to build — a human call.**
  ⚠️ **Same-group caveat: its authors are two of the five on `arXiv:2608.21884`.** 🔴 **And the channel this
  repo fences is measurably the riskier one: attack success rises 14.0–48.8 pp under *skill* evolution against
  3.0–39.3 pp under RL — editing a Markdown skill degraded robustness *more* than updating weights.**
  ✅ Formal backstop: bounded self-modification *"under a common sound interpreter and fixed verification
  protocol remains within the same verification class"* — **provably not an escape hatch, *provided the gate is
  genuinely fixed and external*.**
- **12. 🔴 The failure mode has a name: *vacuity* — a check satisfied by the absence of the thing checked**,
  alongside **self-attestation**, *"where the subject supplies the value the check is applied to"* (**47
  vacuous gates in 69 shipped, reviewed loops**). **The rule: exhaustion, timeout and error must degrade to
  withheld approval, never to a skipped check.** 🔴 **It now has a mechanical taxonomy** —
  **connected-but-never-called, called-but-inert, called-but-content-blind** — where *"**in 18 of 25 modules
  the computed value never reaches any production output**"* and *"**module names and module computations must
  be audited as independent claims**."* **`called-but-content-blind` is the signature to look for: the check
  runs, consumes the artifact, and its verdict is independent of the content.**
  ❌ **CORRECTED 2026-11-02 — "no reviewer documents what its spend cap does to its merge gate" is FALSIFIED;
  four do, three fail-safe.** ✅ **What the evidence supports: every reviewer that documents its cap documents
  it as *not a gate* — none turns exhaustion into an approval, none into a blocking failure. So the spend cap
  is reliably safe and reliably useless as a hard stop, which is why the ceiling must live in the loop
  harness.** 🔴 **Kodus says exactly that in a product warning:** *"**This is a notification, not a cap.**… set
  a hard limit in your model provider's dashboard — **that's the only thing that can enforce it.**"*
  🔴 **Two vendors ship vacuity as the default, in the same inversion:** CodeRabbit *"**skips the review
  content** but still checks the other requirements and **can approve the pull request**"* when path filters
  exclude everything, and Greptile *"**With no cap, the ceiling is Critical**… whatever it changes"* with the
  gate reading **the 5/5 score the reviewer assigned itself.** ⚠️ **Both default to the highest risk tier and
  make the safe setting opt-in.** ⭐ **CodeRabbit's own one-liner is the cleanest anti-vacuity rule found
  anywhere, and it is a vendor's: *"A configured limit requires an assessment covering the current
  commit."*** 🔴 **And Anthropic Code Review cannot be a hard stop by design** — *"A review **never approves or
  blocks** your pull request, and **the check run never concludes as a failure**"* — **so a required status
  check on it is structurally vacuous** — ✅ though Anthropic writes this repo's rule for its own output:
  *"**Treat that as no verdict rather than as zero findings**"*, *"**Fail the job if you want to gate the
  merge.**"* ✅ **First vendor brake on non-convergence** (a PR once ran *"more than fifty rounds of review"*,
  **59%** of repeat flags on pre-existing code): *"**Code review not repeated — earlier findings still open**:
  to start a new review, **push a fix**"* — **stall detection inside the reviewer**, ⚠️ though it requires a
  change, not an improving one. Keep the gate in **your** CI: "Friendly Fire" hijacked auto-review into RCE.

### B) The cost moved from tokens to loop management

Receipts, per-organization caps, analyst figures and the do-not-cite list are in `sources.md`; prose in
[`archive/primer-detail-2026-10.md`](archive/primer-detail-2026-10.md). Once the model writes code for almost
nothing, the expensive part is *running the loop*: every turn re-bills the accumulated context (a 20-step loop
can cost ~10× a naive estimate), and **every token in context is paid on every subsequent call** — history
retention alone raised session cost **21–36%**. **Organizations cap per person** (Uber; Tesla at $200/week),
and **GitHub Copilot and Codex both shipped budget enforcement** — **harness-level enforcement is becoming the
industry shape of hard stop #3.** ⚠️ **Design around cost *cliffs*, not slopes** (§4). ⭐ **Pre-registered:
bad code costs more to review** — across *n* = 465 agent-authored PRs in 246 repositories, *"each CodeHealth
point was associated with **3.5% to 6.1% lower token cost**"*, localised to the review stage *"where agents
iterated more on unhealthy code"*, **so a budget ceiling should scale with the health of the code the loop
works in.** **Anthropic's own cost guidance contains no ceiling** — ✅ **confirmed from its definitional loop
post, whose whole "Managing token usage" section is advisory**, down to *"**Pilot before a large run**…
**Gauge usage on a smaller slice**"*: **estimation, not enforcement** — and it names a loop hazard, effort set
too low yielding *"answer looks finished, but it's built on partial information"*: **a false "done" driven by
a cost knob.** ⚠️ **Two citation hazards.** **(a)** A new distortion shape, and the dangerous kind because the
sponsor and sample size check out: *"73% of organizations reported AI costs exceeded original projections"* is
**not in the FinOps Foundation primary** (*"1,192 respondents"*, *"$83bn+"*, **no overrun figure at all**) —
**do not cite the 73%.** **(b)** The citable top of the range is attributed: Willison, 2026-10-29 — *"**By
Jacob's telling**… **over $3 million in tokens per month**"* — **Medium** on the figure, **High** that he
reports it. ⚠️ **Gartner dating traps: the "80% cost-exhaustion-attack by 2030" prediction is Sep 15, not
October; ">40% of agentic projects cancelled by end-2027" is June 2025.**

## 6. The three hard stops (non-negotiable)

Every serious loop converges on these. Anthropic's Agent SDK ships #1 and #3 as first-class params
(`max_turns`, `max_budget_usd`). Per-vendor quotes, status codes and zero-semantics are in `sources.md`.

1. **Max iteration count** — "prevent runaway sessions." Trust Claude Code's `--max-turns` **only on
   v2.1.281+** (below).
2. **No-progress / stall detection** — kill the loop if it repeats an action without advancing. Needs a
   **wall-clock** dimension as well as diff/iteration, and must read state the agent cannot delete (§5A.9).
3. **Token/dollar budget ceiling** — a hard *enforcement* stop, not an alert. Billing alerts won't
   auto-disable anything, so the ceiling lives in your harness or gateway, checked **before** the next request.

**Why all three — and why "the other two will catch it" is no longer true.** **Hard stop #1 has now failed
six ways**; per-version detail in `sources.md`. The shapes: a turn that *"could retry indefinitely, ignoring
`--max-turns`"*; **three** separate `CLAUDE_CODE_RESUME_INTERRUPTED_TURN` defeats of turn accounting **in
fifteen days from one component**; **by design**, since a queued `stream-json` message *"starts a new turn
with its own limit"*, so **`--max-turns` bounds a turn-chain, not a session**; and 🔴 **a plugin *"keeping a
headless run going past `--max-turns`, Stop, or ended input"*** — ⚠️ **which makes the extension layer a
*class*, not a defect, so an install-time trust decision can defeat the harness's own ceilings.**
⚠️ **Interrupt/resume is where stops leak, and it is cross-vendor**: `/goal` resets *"the turn count, timer,
and token-spend baseline"* on resume **by documented design**, and Codex fixed a structurally identical leak
of #2. **An external counter must survive the restart it is counting across** — ✅ **and Claude Code has
shipped the bound since v2.1.211 (§4).** ⚠️ **New 2026-11-02: the same seam took out containment, not just
counting** — v2.1.314 fixed *"sandbox protections **not applying to a worktree entered by `claude -p
--resume`**"*, the exact re-entry a ralph loop uses.
🔴 **Hard stop #3's enforcement has failed open twice** (*"`--max-budget-usd` **not stopping background
subagents**"*, and the mod bypass — **one bug, two hard stops**) — **and its *exhaustion signal* has now been
ignored by the harness's own retry layer twice, ten weeks apart**: **v2.1.239** (*"now fails immediately on
organization spend-limit and out-of-credits errors **instead of waiting indefinitely***"; `env-vars`:
*"Before v2.1.239, the watchdog retried these indefinitely"*) and **v2.1.311** (*"retrying requests **the API
marked not to retry**… in unattended retry mode, **indefinitely**"*). A gateway spend-limit block is a
documented instance of "marked not to retry" (*"marks each blocked `429` … `x-should-retry: false`"*), so
➜ **"key a retry wrapper on `x-should-retry`" is a rule the vendor's own harness has broken twice, and the
result is an unbounded wall-clock hold in exactly the mode an unattended loop is told to set** (that budget
link is an inference). **A cap enforced inside the process it bounds shares that process's failure modes, and
an external counter that only ticks *between* calls cannot see a call that never returns.** ✅ **One ceiling
genuinely shipped: pooled group budgets** (v2.1.316) — *"one monthly budget that a group's members share,
**on top of each member's own limit**"* — **the cumulative ceiling this section recorded as missing** —
⚠️ **changelog-only, and the spend-limits page still says *"not a shared pool."***

**Four further failure shapes, because a stop can fail without anything erroring.** ⚠️ **A ceiling can leak
through its *meter*, now seven ways (§4): the meter is what the enforcing `429` is computed from, so it can
admit too much spend *or* stop a loop early.** 🔴 **A zero's meaning is systematic, not arbitrary — the
generalisation this primer previously missed.** In Claude Code **every wall-clock / idle / resource backstop
is disableable with `0`** — `STOP_HOOK_BLOCK_CAP` (8), `GOAL_CHECKIN_MINUTES` (30), `API_FORCE_IDLE_TIMEOUT`,
`WEBFETCH_DEADLINE_MS`, `MCP_TOOL_IDLE_TIMEOUT`, `TOOL_MEMORY_LIMIT` — **six cases, all on by default** —
while **every count-or-dollar ceiling refuses it** (`MAX_TURNS` *"rejected at startup"*;
`MAX_WEB_SEARCHES_PER_SESSION` *"raised but not turned off"*; `MAX_SUBAGENT_SPAWN_DEPTH` takes `1`, not `0`;
`--max-budget-usd` rejects `0`). ➜ **So the stops this repo most needs for #2's wall-clock limb are exactly
the ones made disableable.** ✅ Two good forms to copy: `API_FORCE_IDLE_TIMEOUT` keeps a second watchdog *"even
when you set `0` here"*, and `MCP_TOOL_IDLE_TIMEOUT` **clamps a minimum**. **Still: test every ceiling at
zero** — ⚠️ **and note you may not be allowed to: AWS's *"minimum allowed value is the greater of $20 or a
conservative estimate of your likely spend"*, because *"hitting a spend limit is a disruptive experience"* —
a ceiling you cannot set low enough to verify**, whose graduated tiers are moreover *forecast*-driven
(*"before you would reach your limit"*), which is exactly what a runaway's spend curve breaks.
⚠️ **A ceiling can also fail by never *resetting*** — CrewAI's budget where *"nothing reset
`current_usage_count` at the kickoff boundary"* (✅ released 2026-10-23); ⚠️ **and LiteLLM's own monthly-reset
test only passed in ≤30-day months.** 🔴 **And a ceiling's documented recovery path can destroy it:** in
Managed Agents an unpriced model makes a budget unmeasurable, *"changing the budget is rejected. **Remove the
budget to resume the session**"*, and *"**Removing a session's budget is one-way**."* ⚠️ **Where the cap fires
is answered by the vendor — *"between model requests, not mid-request"*, overshoot per-**thread**, so it
scales with fan-out** — ⚠️ **and Cloudflare's is worse-shaped still, metering *after completion*, so a burst
of concurrency can pass the limit.**

**The failure is real and common, and the controls are independently reproduced.** IAL-Scan flagged
unbounded agentic feedback paths at 91.9% precision across 6,549 repos; **21% of enterprises cannot stop a
runaway agent's spending in real time**. Three citable primaries, **and no new one for a fifth window**:
**Mandiant Case study 6** — a null value broke a tool, the agent entered *"an unconstrained, recursive
reasoning loop"*, made 15,000+ calls and a **~$50,000 spike in under an hour**, **and locked a database that
halted business transactions**, so **a runaway loop is an availability incident, not only a billing one**
(⚠️ **cite it directly**; the flattened *"a $50,000 cloud bill"* keeps recirculating); **METR** — a stolen key
ran ~3 weeks and ~$600,000 of free credits; and **AWS `AGENTCOST07-BP01`**, which states all three stops in
its own words plus *"Implement cost controls outside the agent's control loop."* 🔴 **New 2026-11-02 — the KB now also has a first *stall* primary, which it
lacked entirely: Gas City's dated 10.7-hour undetected stall (below).** **High** on all four.

**How to shape the stops, from measurement.** Evidence and per-paper figures in `sources.md`.
- **A capped run is a third outcome, not a failure** — ⚠️ and **a budget the model is *shown* changes the
  work** (*"too small for the task can cause refusal-like behavior"*). 🔴 **New: decide what wins when a stop
  and the check fire together.** MartinLoop's rule: *"**`wall_clock`, `budget_cap`, and `turn_cap` all outrank
  `goal_met`** — governance limits cannot be overridden by a simultaneously verified goal"*, while
  *"`goal_met` outranks `error_threshold` and `no_progress`"*, and **completing *on* the last permitted
  iteration is *"legitimate success, not an overrun."*** **This repo has never said which wins.**
- **Progress-gated continuation beats a blind cap** (22/24 vs 13/24 under denial-of-wallet): keep the ceiling
  hard, make the *approach* progress-gated — **stall detection is what makes a hard cap affordable** — and
  **graduated throttling is sound as the approach to a ceiling, never as a replacement.** ⚠️ **Gas City shows
  the opposite error: it replaced a terminal stall *timeout* with a ladder that *"nudges back off from 3 to 60
  minutes and never stop."*** 🔴 **And a third mode exists beside alert and halt — Yegge's: a budget cap that
  **re-routes the work to people** (*"Humans are always the backstop"*).**
- ⚠️ **Stall detection belongs in the harness, not the prompt.** ⭐ **Measured end-to-end:** *"nearly every run
  that needs outside help collects sufficient evidence, yet a third still exhaust their budget"* — the
  **evidence-action gap** — while an escalation tool *"cuts budget exhaustion from **34.0% to 6.7%**"*;
  ⚠️ **but *"a fired escalation is not yet a useful handoff"* when the ticket omits progress and verification
  status** — ✅ **which Yegge's design answers: *"If the clerk hits its token cap, it escalates with its notes
  rather than getting cut off."***
- 🔴 **New 2026-11-02 — two stall shapes from one dated incident, and this repo's own default is blind to
  both.** Gas City, 2026-10-31: a provider pool *"ran out of usage"* and for **10.7 hours** a template
  *"spawned about 1,400 seats, and none claimed; held 48 PRs for a median 412 minutes; **raised no alert**."*
  Why: *"the ladder's first signal… was its recycle at **22m30s**, but those seats **idle-drained at about
  10.6 minutes**. **Only 16 of 1,133 recycles ever fired.**"* ➜ **(a) a detector whose interval exceeds the
  lifetime of the unit it watches is structurally blind, not mis-tuned; (b) hard stop #3 firing *upstream*
  produced an undetected stall *downstream*, which an iteration-keyed detector — like this repo's
  `LOOP_STALL_LIMIT=3` — cannot see at all, because no iteration occurs.** ✅ **The fix states the doctrine:
  *"**No judgment:** the thresholds are consts… **No provider error text is read.**"*** ⚠️ **Expect false
  positives too** (the same ladder once *"treated the seat's started claim as unstarted and nudged it"*), and
  ⚠️ **a third shape — *"overbaking"*: scope drift, where the loop keeps producing diffs so a diff-keyed
  detector never fires** (§3). ⚠️ **Classify failures so a hard one short-circuits the cap**, and **compute
  the ceiling deterministically on a durable-execution substrate.**
- 🔴 **A guard gated on the truthiness or positivity of its own limit is not a guard.** **LiteLLM** reads
  `max_budget = 0` as unlimited in all three router paths, **still live on `main`, with its fix on a branch
  dormant since 2026-10-02**; **`ralph-loop`** and **ralph-tui** gate on `maxIterations > 0`, and **LoopTroop's
  source says so outright** (*"0 as no cap"*). ✅ The correct form is an unconditional compare plus an explicit
  sentinel, which **`agentgateway`** implements — 🔴 **and its `on_budget_exceeded` has *no default at all*: a
  required field, so the author must choose `Audit` or `Block`.** ✅ **MartinLoop rejects `--budget-usd 0`
  outright, which matters more because it is a loop harness, not a gateway.** **Test every ceiling at zero —
  and test that it resets.** ⚠️ **New: also test that a cap set *to the default value* is in force** —
  LangGraph 1.2.17 fixed `merge_configs` dropping an explicit `recursion_limit` that equalled the default.
- ⚠️ **Record *which* stop fired.** *"Most failures end at a harness limit"*, the record *"identifies the
  assigned pressure no more reliably than a count of tool calls"*, and *"**execution limits also change the
  reported result**"* — **so a capped run's score is not comparable to an uncapped one's, and a cap that halts
  without saying so is indistinguishable from a capability failure.** ✅ First step shipped
  (`claude_code.safety_event`), ⚠️ **permission events only**; Gemini CLI still reports loop-detector and
  turn-cap bail-outs under **one indistinguishable event.** ✅ **And `arXiv:2610.41130` ships the shape to
  copy: *"Inconclusive tests and failed executions are reported separately alongside the verdict rate"*** —
  an ABSTAIN channel.

**Where ceilings actually exist.** Per-product and per-vendor quotes in `sources.md`; the full inventory, as
of this pass, in [`archive/primer-detail-2026-11.md`](archive/primer-detail-2026-11.md). What a loop author
needs:
- **Anthropic.** The **Claude apps gateway** blocks on daily/weekly/monthly caps, is the only surface with a
  **daily** ceiling, and ✅ **gained the first first-party *cumulative* ceiling on 2026-10-31** (pooled group
  budgets) — ⚠️ but **enforcement fails open by default** (set `enforcement.fail_closed_on_error: true`).
  **Managed Agents session budgets** are a genuine *"hard dollar budget"* but in **list** dollars, enforced
  *"between model requests, not mid-request"*, metering web searches and **session running time**, and
  🔴 **their documented recovery path destroys the ceiling** (unpriced model → *"Remove the budget to
  resume"* → removal is *"one-way"*). The **Spend Limits API** is monthly, Enterprise-member-scoped, *"not
  available to Claude Platform (Claude Console) organizations"* and disowns its own meter (*"informational,
  not transactional"*). **Messages API task budgets** are *"a soft hint, not a hard cap"* and *"not supported
  on Claude Code"*. ⚠️ **Observability shipped 2026-10-29; enforcement still has not, now five passes.**
- **Elsewhere.** ⚠️ **On five gateways and inside a hyperscaler the real ceiling sits behind a non-default
  flag** — *if you did not turn enforcement on, assume you have an alert.* ✅ **The one to recommend is a
  gateway, not a vendor: Cloudflare enforces *before* dispatch and meters per `agent_id`** — *"Before sending
  a request to the provider, AI Gateway evaluates all applicable spend limit rules at once"*, and *"splitting
  by `agent_id` gives every agent its own budget"* — ⚠️ with concurrency-shaped overshoot and only for
  *"models with known pricing"*. **Google** and **AWS** pause a project (⚠️ monthly, narrow scope, a 90-day
  deletion tail, forecast-driven tiers and a **$20 floor**); **Azure is an alert**; ⚠️ **Bedrock is a meter,
  not a control.** ⚠️ **No model vendor offers a per-API-key ceiling** — they scope to *identity*, **and a
  loop harness holds a key, not an identity**, so **METR's *"no way to put a spending limit on keys like this
  one"* stands (re-tested 2026-11-02)** — ✅ **the one hosted per-key ceiling is OpenRouter's, with a
  **daily** reset.** ⚠️ **An exhausted budget's durable signal is a header, not a code** (`x-should-retry:
  false`; LiteLLM `422`; OpenRouter `402`/`403`) — **key a retry wrapper on the header**, ⚠️ **a rule Claude
  Code itself broke twice.** ⚠️ **And vendors disclaim their own ceilings** (Databricks: *"**Do not use this
  feature as a way to ensure an absolute spend cap**"*; Agent Router's `serviceQuota` *"has no effect"*).
- **In-harness.** ✅ 🔴 **MartinLoop carries all three stops plus a verifier, with an explicit precedence order
  and a rejected zero** — the closest external analogue of this doctrine. **AgentGuard** enforces **before
  dispatch** and ships a drop-in stall detector plus iteration cap as a Claude Code hook; ⚠️ **its lesson: a
  dollar ceiling is only as good as its price table.** ⚠️ **LiteLLM still reads `max_budget = 0` as unlimited
  in all three router paths**, with its fix on a branch dormant since 2026-10-02.
**Open human calls this section raises.** The full list, with evidence, is the `sources.md` backlog —
**now well past 100 open items and growing faster than it resolves, which is itself worth a human's
attention.** The load-bearing ones: the check's **provenance clause**, now evidence-backed as an **ordering**
rule (§5A.2); **the check must run on the version about to land** (§5A.2); a **corpus-level re-test** plus a
**sunset/revert obligation** on accepted self-edits (§5A.11); **hard stop #2 needs a wall-clock limb**, since
this repo's `LOOP_STALL_LIMIT` is iteration-keyed and blind to a stall in which nothing iterates; **adopt a
stop/goal precedence rule**; adopting `onFailure: "block"`, `permissions.blockWritesOutsideWorkingDirectories`,
`..._RESUME_INTERRUPTED_TURN_MAX_AGE_MS` and the retry-watchdog bounds across `guardrails/` (⚠️ **none of
which this repo sets today**); whether an unattended loop must run with **no third-party mods** and a
**global-config tool floor** rather than trusting a target repo's frontmatter (✅ roborev 0.74.0 is the
existence proof); whether this repo's Routine needs a **cumulative** ceiling (✅ now possible first-party);
and ⚠️ **the correction the routine owes its own runbook: the `claude/` prefix is a *default*, not an enforced
restriction — the enforceable floor is a GitHub ruleset the connected identity cannot bypass, and `main` here
is still `"protected": false`.** None is applied by the knowledge base; each is a human-authored change.

## 7. The one-paragraph answer

Stop being the thing in the loop. Write the loop once, give it **skills** worth calling and a
**verification** step it did not author — and, as of this pass, one written *before* the code it checks — then
**cap it** (iterations + dollars + stall detection) so it provably halts, and let it run on a schedule while
you go decide *what* to build.
