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
| **Orchestration loops** | Loops supervising *other* loops — concurrently, on a schedule, with durable state. | now (2026) | What Steinberger/Cherny mean. New vs. ralph: the loop (not the task) is the unit of work; loops dispatch/supervise sub-loops; scheduling replaces human kickoff; state is git-backed so it survives a crash. Shipping natively as Claude Code **Dynamic Workflows** (§4), and externally as **MartinLoop** (§6) and Yegge's **Wheelhouse** (§3). ⚠️ **`ghuntley/loom` is now `ghuntley/overalls`, which launches 2026-11-12 (slipped from Nov 3 in-window) — but first-party it is a self-hosted Firecracker dev-machine platform, i.e. a *substrate*, not an orchestrator (§4).** The field calls this **"Loop Engineering"** (Addy Osmani's coinage, crediting Steinberger + Cherny). |

**The ralph one-liner** — never run it like this (§6):
```bash
while :; do cat PROMPT.md | claude ; done
```
The trick: the prompt stays the same while everything *around* it changes — the codebase, test results, git
history, a progress file. **That external state is what turns repetition into iteration.** ✅ Per HumanLayer,
ralph is *"**not "run forever" but… "carve off small bits of work into independent context windows"**."*

⭐ **There is now peer-reviewed literature on this exact subject, and it is worth more than the discourse.**
**arXiv:2608.21884** (Treude, Baltes et al., cs.SE, **v3**) mined **36,710 repositories**, confirmed
autonomous agent loops in **217 of 256** matched, dates Osmani's coinage to **25 July 2026**, and concludes
**verification cost is the bound on delegation**. ⚠️ **Its headline finding rebukes prescriptive loop advice,
this repo's included:** *"The repositories commit the configuration around these loops, but **almost none
commits the state files the discourse prescribes**."* **arXiv:2607.00038** defines a *"loop specification"* —
**trigger, goal, verification step, stopping rule, memory** — and over *n* = 50 loops finds **70%** verify and
**74%** name terminal states, while *"automated triggering and durable memory remain comparatively
underdeveloped."* **Two independent groups agree** (✅ authorship checked) **: verification is the most mature
part of the practice and durable state the least.** ⚠️ Both caveat that the discourse rests on *"self-reports
and anecdotes"*, and ⚠️ **the same group's harness-self-evolution paper (§5A.11) is not independent of this.**

**Myth to drop:** the "$297 programming language" story conflates a YC-hackathon team with Huntley's actual
language, **CURSED**, whose published cost is *"roughly US$6,000, and I did it three times over."* Attribute
it; never merge it with the blacklisted unattributed "$6,000 overnight" (`sources.md`).

## 3. The key voices

**Per-voice quotes and dates live in `sources.md`;** this is only the through-line each one contributes.
⚠️ **Check a voice's surface before asserting its silence, and date from feed *entries*** — three traps have
fired repeatedly: **ghuntley.com's byline *and* on-page `datetime` run a day ahead of the RSS `pubDate`**, and
**a feed's `lastBuildDate` header runs ahead of its newest entry** on `lucumr.pocoo.org` and
`steve-yegge.medium.com`. ⚠️ **Record the *host*, too:** a research agent this pass declared two Anthropic
citations unverified after searching only `anthropic.com`, when both are live on `claude.com` and
`claude.dev`.

- **Anthropic** — the definitional post, *"Loop engineering: Getting started with loops"* (**June 30, 2026**),
  defines loops as *"agents repeating cycles of work until a stop condition is met"* — 🔴 **but for a proactive
  loop *"The routine itself runs until you turn it off"*: no terminal condition, which is this routine's own
  shape.** ✅ It endorses "the verifier must not see the maker's trace" (*"a reviewer with fresh context is
  **less biased and not influenced by the main agent's reasoning**"*), and the Code Review team enforces it
  (*"**ask it to show the output instead of saying it's done**"*; *"A PR can't merge while any finding… is
  still open"*). ⚠️ **Mind the practice/product gap: their own PRs block on open findings, while shipped Code
  Review *"never approves or blocks"*.** **High.**
- **Addy Osmani** — *"you can only hand a loop as much autonomy as you can cheaply and reliably verify, and
  not one inch more"*; maker ≠ checker. ⭐ **The loop *teaches* the agent**, so ⚠️ *"both failure modes cause
  the agent to get worse, **but without any visible sign of failure**"* — **an activity-keyed stall detector
  cannot see a loop that is busy and degrading.** ⚠️ **His `.com` feed is at `addyosmani.com/feed.xml` (not
  `/blog/rss.xml`), newest entry Sep 14, and is *not* a subset of Substack.** ⚠️ **He is now Anthropic MTS on
  Claude Code** — independence context for his crediting Cherny with "Loop Engineering". **High.**
- **Geoffrey Huntley** — **back pressure** (*"Types are a form of verification. They provide back pressure"*),
  so **iteration throughput is a loop-design variable**; ⭐ **enforcement over instruction** (a pre-commit hook,
  because an `AGENTS.md` edit leaves *"still a delta, and it'll drift"*). ⚠️ He endorses **no** iteration cap,
  stall detector or cost ceiling — **his practice, not a recommendation**, and **Overalls** (§4) ships the same
  position: every token accounted, none capped. **High.**
- 🔴 **Steve Yegge — his system is *Wheelhouse*** (*"an open system with **no sandboxing**… fourteen mechanical
  fences… **They work under my own identity**"* — ⚠️ **openly the configuration `arXiv:2610.28683` says makes
  decision authority unrecoverable**). 🔴 Three primitives worth taking: a budget cap that **re-routes to
  people**; a token cap that **escalates with its notes rather than truncating**; and a judge *"never tuned on
  the gold set"*. 🔴 **And the *agreement ceiling*: two human scorers *"top out at agreeing around 90%"*, and
  *"that agreement ceiling is also the ceiling on what your evals can show."*** **High.**
- ⭐ **Josh C. Simmons** (`drjoshcsimmons.com`) — the practitioner primary on check provenance: *"**the useful
  question is where the expected behavior came from, not how many agents agreed with it**"*, plus the version
  clause (*"**its answer belongs to a different version**"*) and ⚠️ *"the agent can **complete the task by
  deleting the evidence against its patch**."* ⚠️ **Keep his evidentiary classes apart** — some figures are
  third-party, some his own toy model. **High.**
- **Simon Willison** — *"you can actually spend $1,000 in a day doing real work"*; **still the only outside
  voice for hard stop #3** (*"hard budget caps need to be the default"*). ⚠️ A stall detector **must key on
  state change, not "did it respond"** (`max` effort *"hit [the output limit] while it was still reasoning"*).
  🔴 **New Nov 9 — the review gate failing by *disengagement*:** an agent PR description detailing *"the steps
  taken to verify it"* is *"not necessarily slop, but it reads like slop!"*, so *"**I want human editorial
  judgement**"* — ➜ **a thorough self-reported verification narrative can displace the reading of it, which is
  the human-factors twin of self-attestation.** **High.**
- 🔴 **Kyle Kingsbury / Jepsen** — the strongest third-party statement, from outside this discourse: *"the
  signals we used to rely on as **markers of a mature system are now easier to counterfeit**."* **High.**
- **Dex Horthy / HumanLayer** — 🔴 **ralph's point is bounded context, not endurance**, and 🔴 **"overbaking"**
  names a hard-stop-#2 shape: scope drift, **invisible to a diff-keyed detector**. Their cap is **one
  iteration a night**. ✅ Adoptable: *"swallow all test/build/lint output and replace it with a single ✓"*.
  **High.**
- **Permanent coverage limits, not findings** (`sources.md`): **Cherny** (*"My job is to write loops"*) has
  **no enumerable feed**, so "nothing new" is only ever **Medium**; **Steinberger**'s blog is enumerable
  (`steipete.me/rss.xml`) but **dormant since Feb 15, 2026** — he posts on **x.com, unfetchable here**; and
  ⚠️ **Ronacher's Codemode "30 step loop" is agent-authored inside a generated script, not a harness cap.**

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
  — **AutoGPT's original sin, shipped.** ⚠️ **New 2026-11-09: the dead-man's switch this primer recommended
  copying is gone** — v2.1.319 *"Changed self-paced `/loop` to end when a turn finishes without rescheduling,
  instead of scheduling a fallback wakeup"*. ✅ **The new default is strictly safer** (forgetting to reschedule
  now terminates), ⚠️ **but `CLAUDE_CODE_LOOP_KEEPALIVE=1` restores the looser behaviour and is documented
  nowhere, while `scheduled-tasks.md` still describes the removed 20-minute wakeup.**
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
  time Claude calls a tool**."* ⚠️ **`0` disables it — one of seven such cases (§6)**, and `hooks.md` still says
  only *"To raise the cap"*. 🔴 **New 2026-11-09 — this is now a *documented* fail-open chain, not an
  inference: `goal.md` itself says that when Claude *"keeps answering the evaluator without making progress
  (no tool use for several turns in a row)"* Claude Code stops the loop, and links the block cap as *"the
  underlying mechanism"* — so `/goal`'s only stall stop is one a single `0` removes, and none of `goal.md`,
  `hooks.md` or `hooks-guide.md` says so.** ⚠️ **Two consequences:** the reset-on-tool-call means it bounds only unproductive
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

- **Subagents** nest to **depth 3** with a **concurrency** cap of **20** (both re-verified unchanged
  2026-11-09); the lifetime per-session spawn cap was **removed in v2.1.224** — ⚠️ **`env-vars` now calls it
  *"Removed… and now a no-op"*: a cap you can still configure that silently does nothing.** The 20-cap has
  documented holes (ultracode exempt, `/subtask` forks and resumed subagents bypass it, workflow-spawned
  subagents uncounted, *"no hard limit on the number of teammates"*). **So the only primitive that binds the
  whole tree is the dollar ceiling — say "spend cap", not "a cap of 20"** — ⚠️ **and the meter under it is
  known to be wrong in fan-out specifically.** **High.**
- **Dynamic Workflows** enforce caps at runtime: **16 concurrent agents** (raisable 1–256), **1,000 total per
  run** (*"Prevents runaway loops"*), a per-run token budget, worktree isolation, and list caps that **reject
  rather than silently truncate**. ⚠️ The size guideline is **advisory only**, the usage-limit pause applies
  only to **interactive** sessions, and **v2.1.186 fixed workflow subagents *"looping forever on repeated
  schema validation failures"* — the primitive credited with enforcing caps has had its own AutoGPT
  instance** — ⚠️ **joined 2026-11-03 by *"workflows re-running finished agents when resumed after a usage
  limit"*: duplicate iterations *and* duplicate spend on the resume path.** **High.**
- **Autonomy defaults moved up**: background agents commit, push and open a draft PR; **auto mode is the
  default starting mode from v2.1.283**, and the docs say it supplies **no containment**. ⚠️ **The number that
  should decide how you run unattended: auto-approve takes attack success from 29.2% to 95.6% (§5A.8)** —
  ⚠️ **and deny rules did not reliably reach fan-out** (v2.1.309). **High.**

### Containment and permission primitives worth using

Per-version inventory in `sources.md`; the shape that matters: **deny-by-default exists**
(`--permission-prompts none`), **managed settings fail closed** on a parse error, **restriction is inherited**
by spawned sessions, **egress can be made a real boundary**, **effort and model choice can be capped from a
higher scope** (lowest cap wins), and **subagent output cannot pass as instructions**. ✅ **Four primitives to
prefer:** `disallowed-tools` for an autonomous skill (§5A.8); **`decider: "person"`** on a mod's `tool.check`
(*"refused… **where nobody can be asked**"* — **fail-closed by construction unattended**);
**`blockWritesOutsideWorkingDirectories`** (⚠️ file tools only — see below); and 🆕 **new 2026-11-09,
`permissions.denyInsteadOfPrompting`** — *"a tool call that would wait on a permission prompt is **denied and
the turn continues**"* — ⭐ **the direct fix for the stall mode where an unattended loop hangs forever on a
prompt, which satisfies no hard stop**; ⚠️ **changelog-only, absent from `settings-reference`.** Three standing
cautions: **`--restricted` is a permission gate, not an OS sandbox**; **an allowlist matched on a command
*prefix* is not a gate at all** — **enforce on an argv vector**; and **permission-bypass fixes have shipped in
*every* window** (v2.1.319 alone: a `sed` call skipping the check, *"a crafted environment prefix"* hiding part
of a command, and a sandbox escape), so **a gate has to be tested and pinned to a version, not declared** —
✅ **the first-party way to pin it is `requiredMinimumVersion`.** **High.**

### Native backstops: added and removed

Anthropic both adds and removes bounds, so **re-verify a default before relying on it** — and ⚠️ **re-verify
that a fix is still in force, because one can be reverted.** **Removed:** the per-session subagent spawn cap
(v2.1.224, ⚠️ now *"a no-op"*); the one-hour limit on subagent background commands; ⚠️ **and new 2026-11-09,
`/loop`'s fallback wakeup (§"loop surfaces").** **Added:** deadlines on Monitor watches and WebFetch;
`TOOL_MEMORY_LIMIT`; a wall-clock ceiling on backgrounded shells.
🔴 **Eleven backstops this KB never recorded, found by deliberately *not* scoping to the week** — most
bounding mechanisms it had tracked as unbounded. **A window-scoped pass systematically cannot see a backstop
that shipped quietly and never changed again, so the inventory needs a periodic non-window sweep.** The shape:
**every one is a timer or a resource bound, and seven can be switched off with `0`** (§6). Load-bearing:
⚠️ **`RESUME_INTERRUPTED_TURN_MAX_AGE_MS`** (v2.1.211) bounds the setting recorded here as leaking hard stop #1
three times, **available all along** (*"Unset or `0` sets no bound… a negative or non-numeric value applies a
one-hour bound"* — **the invalid value fails safe while the explicit zero fails open**); ✅
**`requiredMinimumVersion`** (v2.1.163, Managed) is the first-party form of "pin the gate to a version";
and ✅ **three retry-watchdog knobs** bound a wait that is **a stall in which no iteration occurs** — ⚠️ **but
`..._MAX_USAGE_LIMIT_WAIT_MS` still has zero occurrences in `env-vars` five weeks on, and nothing in this repo
sets the watchdog at all.**
🔴 **`no-progress` has never appeared in the changelog — not once, in any version** — nor in `env-vars`,
`settings-reference`, `hooks` or `routines` (re-verified 2026-11-09): **Anthropic has shipped an iteration cap
and a dollar ceiling and has never named no-progress detection.** ⭐ **But it does ship exactly one, on by
default, and this KB never recorded it: the `rapid_refill_breaker`** — if the context refills to the
autocompact threshold within 3 turns of a compaction, 3 times running, the query loop aborts with that
`terminal_reason` (v2.1.89: *"detects when context refills to the limit immediately after compacting three
times in a row and stops with an actionable error instead of burning API calls"*). ⚠️ **It is named in one
doc line — the SDK's `terminal_reason` enum — and in no changelog entry, and it fails open whenever
compaction is disabled: a loop that turns off autocompact to manage its own context silently removes the only
no-progress breaker it had.** (High on existence/version; **Medium** on current thresholds — the shipped CLI
is no longer inspectable.) ✅ **Hooks keep moving fail-closed** — `onFailure: "block"`, extended to **Agent SDK
hook callbacks** in v2.1.317, ⚠️ **default still `continue`** — ⚠️ **but a hook guard fails open when its
*interpreter* is missing, a fix incomplete three times over, so treat a hook gate as advisory until tested on
the actual host.** ⚠️ **Containment keeps leaking on the worktree path a ralph loop re-enters:** v2.1.314 fixed
*"sandbox protections not applying to a worktree entered by `claude -p --resume`"*, and **v2.1.319 fixed *"a
sandbox escape when creating a worktree"*** — two releases, same surface. ✅ **The countermeasure is now
documented** (`blockWritesOutsideWorkingDirectories`, *"in every permission mode, including
`bypassPermissions`"*) — ⚠️ **but it *"doesn't limit shell commands, MCP tools, or the programs hooks run"*, so
it is no blast-radius stop for a loop that shells out, and turning it on *removes the worktree tools.***
⚠️ **And the 24-concurrent-hooks cap is still undocumented — worse, `hooks.md` states a different one**
(*"more than 12 of them… 12 of those run at once"*, per **event**, against the changelog's 24 per **session**,
subagents included) — **and `/goal` *is* a Stop hook.** **And both hard stop #1 and #3 have now failed open —
§6.** **High.**

### Cost surfaces in the harness

Per-version detail in `sources.md`. `/usage` breaks spend down by skill/subagent/plugin/MCP and **per loop**
— **visibility, not enforcement**, and ⚠️ **six passes running, that is all that ships** (newest: project
**cost-code tags**, Nov 6). `--max-budget-usd`, `/cost` and the status line meter at **list price** unless a
managed-only `modelPricing` table is in effect; both CLI caps are **print-mode only** — ✅ though a data-
residency multiplier *"also counts toward `--max-budget-usd`"*, so the ceiling meters the **billed** figure.
⚠️🔴 **The meter a ceiling is computed from has now been wrong EIGHT ways across two vendors** — under- and
over-counting, a cloud session's spend *"restarting from zero"* on resume, a per-request addend, placeholder
usage in **subagent** transcripts (**fan-out, where a loop's spend concentrates**), a model-id misparse behind
a gateway giving *"the wrong… **cost**"*, a resumed session *"making a model call nobody asked for"*
(**billable work with no iteration**), and 🔴 **new 2026-11-09, a defect in a brand-new ceiling one release
after it shipped: `/usage` *"showing a developer's own spend limit as 100% used after their group's pooled
budget ran out"* — exhaustion attributed to the wrong ceiling.** **Several stop a loop *early*, so "verify the
meter, not just the ceiling" is its own guardrail line. Reconcile against the invoice at least once.**
⚠️ **An aborted call is still billed** — **a wall-clock kill does not avoid the spend** — and the accounting
**resets by design** (*"a `/clear` starts the budget over"*), ⚠️ **so any ralph-style loop re-entering with
`--resume` gets a fresh ceiling every iteration.** **An external meter is still required.** **High.**

### Models and pricing that change loop maths

Per-model prices in `sources.md`. **Cached input dominates a long run**, so **a cost model metering on input
list price over-estimates long runs by ~an order of magnitude** — ⚠️ and **Sonnet 5 vs 5.5 differ 2×** there.
⚠️ **Claude Haiku 5.5 is the only current model excluded from flat-rate long context**, *"priced by prompt
length"* — **5× above 100K** — and 🔴 the threshold counts *"all of its input tokens, **including cache reads
and cache writes**"*, so **caching cannot keep a growing loop under it** (⚠️ **and new: on Haiku 5.5 the
data-residency multiplier *"also applies to the higher prices"*, compounding to ~5.5×**). It is what `haiku`
resolves to, i.e. **`/goal`'s evaluator, which re-reads the condition and the conversation every turn**
(mechanism **High**; the `/goal` consequence is an inference). ⚠️ **Pinning the evaluator has blast radius** —
no evaluator-only override. **Newer models take more turns per unit of work**, so an iteration cap tuned on an
older model **trips earlier** — re-tune #1. **Refusals are billed**, so **an unbounded retry against a
refusing model is a billable stall.** ⚠️ **Dated: Sonnet 4.5 retires and Opus 4.8 fast mode is removed
2026-11-30** (no fallback; the documented path is a model migration), **and `claude-opus-4-5-20251101` is past
a *"not sooner than November 24, 2026"* line**, with ≥60 days' notice promised before any retirement. **High.**

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
| **Overalls** 🆕 (launches 2026-11-12) | – | **hard-coded `iteration > 72` / `inference_count >= 64` · narrow `compaction_no_progress` · NONE** | ✓ (Firecracker VMs) | **substrate**, not an orchestrator |
| **Cursor** | ✅ **`/goal`, *"Rolling out"*** | **no caps exposed as CLI parameters at all** | **cloud + event triggers + memory** | **more** |
| **Devin · Factory Droid · OpenAI Agents API** | managed (Factory: `--validator-model`) | managed (opaque); **no budget or run-timeout flag in `droid exec`** | ✓ | **more** (coordinator→child-VMs) |
| **Gas Town / Gas City** | – | ⚠️ **v2 work ladder *"nudges back off from 3 to 60 minutes and **never stop**"*; a 2026-11-02 claims-stall guard adds a lane-level hold. Still unreleased** | git-ledger (Beads) | **more** topology, early maturity |
| **Claude Agent SDK** | `Stop` hooks | **`max_turns` + `max_budget_usd` real enforcement, ⚠️ both off by default** | you host | baseline for a loop-of-loops |
| **LangGraph · ADK · CrewAI · AG2** | build-your-own | opt-in; mostly no $ default. ⚠️ **LangGraph's `recursion_limit` default is 10007, not 25** | needs Temporal/Diagrid | framework substrate |
| **Amp · Cline/Roo · Aider** | – | caps only · – · – | – | **less**; **Aider dormant** (nothing since 2026-02-12) |

✅ **What is actually differentiated** (the "nobody else has caps" claim was retired 2026-10-12).
**(a) A hard dollar ceiling in the *harness* remains unique to Anthropic** — ✅ **but the practical answer is
now a gateway in front of it: Cloudflare enforces *before dispatch* and meters per `agent_id` (§6).**
**(b) The peer caps are soft, off by default, or undocumented** — Goose *"stops and prompts"*, which **in an
unattended loop with nobody to answer is a hang, not a stop**; ⚠️ **Codex's token ceiling is still
`UnderDevelopment`, off by default, undocumented, and fails open when unconfigured.** ➜ **The differentiator
is not "we have caps" — the stop must be *hard*, live in the harness, and terminate rather than ask.**
⚠️ **A liveness heartbeat is not a no-progress detector.** ✅ Shapes worth copying: **work leases with TTL +
heartbeat**; Gemini's *"**Enforcement is hard: the agent will be terminated when the limit is reached**"*;
🔴 **MartinLoop's exit precedence and its two-directional zero (§6)**; and ⚠️ **Gemini's per-agent
`maxTimeMinutes` — a wall-clock ceiling this repo's three-stop model still does not name** (open question).
🔴 **A vendor can widen a cap deliberately** (Goose raised the subagent default 25 → 1000: nothing failed —
**the cap was designed away**), ⚠️ **or remove one: opencode v2.2.6 made `opencode run` wait on background
jobs with *"no time limit"*, so a step that spawns a dev server never returns and neither the iteration
counter nor the budget meter ticks.** ⚠️ **Method, learned twice: read the code at both tags before recording
a cap as changed — this KB once inferred a behaviour change from a doc-wording change.** **High.**

Durable facts:

- **The validator-judge stop is cross-tool.** ✅ **Cursor's `/goal` is CONFIRMED** (its slash-commands page
  moved to `cursor.com/docs/cli/reference/slash-commands`): *"Give the agent a long-lived objective to work
  towards until it's fully complete. **Rolling out.**"* — ⚠️ **and it ships with none of the three hard stops
  documented anywhere.** Codex ships `ext/goal` **on by default**; Factory Droid ships `--validator-model`;
  ⚠️ **Goose ships both `/goal` (nudges once) and `/grind` (*"pursues relentlessly until max_turns"*, bounded
  only by the 1000 default — no stall detector, no ceiling).** Claude Code's edge is a genuinely *separate*
  evaluator — but **all of them delegate the *progress* judgement to a model**, so that half is self-graded.
- **"Durable execution" is the biggest hype gap**: LangGraph/CrewAI/ADK checkpoints are recovery points, not
  crash-surviving execution, unless you add Temporal/Diagrid. ✅ **MCP is building it in the open** (a Tasks and
  Events WG, and Tasks now supported in Claude Code).
- **Portability is real for MCP and project instructions; skills are governed and newly *implemented*.**
  🔴 **Corrected 2026-11-09 — the "expect breaking changes" framing needs splitting: the *extension* is at
  Beta, but SEP-2640 is *Final* and *"the specification is a released revision and is not edited in place"*,
  with changes shipping as a **new release**. So the revision you pin stays put** — a material improvement for
  a loop depending on a skill surface. ⚠️ **Still: the donated Agent Skills spec repo has not moved, and every
  in-window Skills change was in the satellite `ext-skills` repo — watching only the core repo misses them.**
  **Keep treating a skill authored here as portable-with-testing, not drop-in.** **High.**
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
⚠️ **a stable judge is not a correct one** (*"perfect consistency by trivially repeating incorrect verdicts,
agreeing with ground truth only 51% of the time"*), and a judge's *scores alone* transmit its traits — so
**"it answers the same every run" is not evidence a `/goal` validator or a self-edit rubric is sound.**
✅ **A gate that *runs* the artifact beats one that only reads it**, measured by Caper (independent approver
over *"a bounded report of its observed effects"*; the margin widens ~2× → ~4.5× exactly where *"harmful
behavior is hidden inside invoked tools"*, at ~1% false positives) — **so independence is nearly free.**
⚠️ **Scope boundary: independence is required for the accept/reject verdict; *fidelity to the executor* is
required for choosing among candidate fixes** (*"Repairs should be verified with the executor that will run
them"*). ⚠️ Huntley names the cheap strong case: a **golden oracle** — *"If you have an oracle, porting is a
loop."* Per-paper detail: [`archive/primer-detail-2026-11.md`](archive/primer-detail-2026-11.md).

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
✅ Corroborated as an experimental control (`arXiv:2610.36584`: withhold the implementation and *"passing
tests for 82.8% of instances, yet only 33.8% are behaviorally adequate"*). ⚠️ **Substrate caveat:
`2607.05139` and `2610.11835` share an author — one failure domain**; the independent second is `2610.13065`.
⚠️ **Don't over-generalise:** at 114,134 PRs agent-added tests are *not* detectably worse. 🔴 **New 2026-11-09
— the vacuity case is now independent and formal:** `arXiv:2611.05590` separates **verifier acceptance** from
**specification binding** from **semantic fidelity** and reports *"99.1% verifier acceptance on HumanEval
while only 1.9% carry a certificate binding to a spec-defined predicate"* — **the sharpest number yet for a
gate that passed and checked nothing** (no author overlap with `2609.27871`, so a genuine second domain).
⚠️ **And a green check is not completeness** (92.6% of trials passing every final check held another
deviation), so ⭐ **a check can be correctly computed and still not be entitled to its verdict** — give it
ABSTAIN. 🔴 **A fourth property: the check must run on the version about to land** — *"its answer belongs to a
different version"* — ⭐ **so "the harness is versioned as part of the system under test."**

🔴 **NEW 2026-11-09 — a fifth property, and it is the week's headline: the *signal* the check returns is
itself a fail-open surface, and this repo's non-negotiable assumes it isn't.** `CLAUDE.md` requires a check
*"that returns clear pass/fail"* — but **Claude Code's own success signal failed open four times in this one
window**: `claude -p` *"exiting 0"* when a full disk *"lost its transcript or `~/.claude.json` writes"*
(v2.1.317) and when *"its actions were refused because no safety check was available"* (v2.1.319); and
*"`claude -p` and Agent SDK sessions **reporting success** when an API error cut off a reply"* plus a mod's
`turn.step` hook *"making a stopped reply **finish as a success** in headless runs"* (both v2.1.318). A
whole-changelog sweep puts the class at **~19 vendor-confirmed instances**, including ***"sandboxed Bash
commands on Linux reporting exit code 0 for failed commands"*** (v2.1.275) and *"workflow agents sometimes
skipping their step, and the run **still reporting success**"* (v2.1.301). ⚠️ **Same window, same shape in the
tools a check is built from:** *"Claude treating **partial Grep and Glob results as complete** when a search
hit its time limit"* — **a timed-out search reads as a clean negative**, first-party vacuity. ➜ **The rule:
never read the harness's exit status or success field as the verdict. Run the check as a separate process and
read *its* output.** ✅ `templates/ralph/run.sh` already does — it evaluates `$SUCCESS_CHECK` independently and
requires a completion marker *and* a pass — and (fixed 2026-11-11) no longer ignores a non-zero `rc`: a
failed call can't declare completion, and `MAX_FAILED_ITERS` consecutive failures stop the loop (exit 7).
**High.**

**3–7. Five results unchanged; prose in [`archive/primer-detail-2026-11.md`](archive/primer-detail-2026-11.md),
records in `sources.md`.** **3.** The agent's account of its work is not evidence (files skipped in **67.9%**
of runs; a verifier shown the maker's trace accepts **78–90%** of failures) — **the stop condition must be
observed, not reported.** **4.** Telling an agent is not a control — **which is why every control here is a
*mechanism*.** **5.** Long-horizon loops hit a verification ceiling near **25%**. **6.** The harness is the
unit worth engineering (**4.3×** on a fixed model) — ⚠️ but *"most failures end at a harness limit"*, so **a
capability number is partly a statement about caps.** **7.** Skills are durable as artifacts, but **selection
not authoring is the bottleneck** (so a **deterministic retriever** wins), ⚠️ **linting is not testing**, and
⚠️ **"a good skill" is not a property of the skill** — **re-measure against a No-Skill baseline whenever the
model or harness moves.** ⚠️ **Cite a denominator with its method**, and **"SkillsBench" names FOUR different
sizes across four papers — never cite one without that paper's own *n*.**

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
skills declares `allowed-tools`**; and ✅ **roborev 0.74.0 is the shipped countermeasure worth copying** — a
reviewer that *"loads only `Read`, `Glob`, `Grep`, and the granted MCP tools, **ignores user and project
Claude settings**, and **fails if Claude reports any other tool or server**"*, policy in **global config
only**: fail-closed, with the decisive config in a channel the target repo cannot write.
⚠️ **Treat a public skill as an untrusted, *unversioned, un-patchable copy***; *"prefer well-starred skills"*
is **near-useless**. 🔴 **New 2026-11-02: a public skill is untrusted *policy*, not only untrusted code** — about **one in
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
  *"emerges naturally in frontier models"*, **no attacker required**; and a monitor with a bounded window can
  be **waited out**. ⚠️ First-party: deleting `/loop`'s state file produced **more** iterations; and Gas City's
  alerting path took *"about 4 minutes per order, enough to push the first stall past the script's 15-minute
  lookback"* — **the monitor's own cost pushed detection outside its own window, with no adversary.**
  ➜ **The meter must not live inside the thing it meters** — AWS independently: *"implement cost controls
  outside the agent's control loop."*
- **10. Human approval is a boundary only if what was approved is what runs** (**Loopjacking**). ⚠️ **This
  repo rests its whole self-improvement envelope on "a human reviews and merges every PR", so this is the
  named failure mode of its own control** — at one site *"71 of those 263 merges (27%) rested only on an
  approval that a coding agent had submitted through the technical lead's GitHub account"*, where *"the
  records cannot show who decided any of them."* **The control was not bypassed; it was indistinguishable.**
  ⚠️ One of its gate defeats is *"an agent collapsing a stack of pull requests through unprotected branches"* —
  **this repo's live exposure, since `main` is still `"protected": false` and this pass is itself a stacked
  PR.** ⚠️ One site, one author — **the mechanisms are the finding, not the rate.**
- **11. Self-improvement needs an external, enforced gate.** ⚠️ **Per-edit gates do not compose** (performance
  declined monotonically as individually validated rules grew **13 → 70**, each having passed its own gate),
  and **SkillPoison reaches *"95.71% attack success… while all injected experiences remain task-correct and
  pass verification"*** — **every edit passes its own gate because every edit is genuinely correct; the harm is
  what accumulates.** 🔴 **And 18 of 43 self-improvement proposals *"recommended a practice regardless of what
  had happened"*** (✅ **vacuous proposals, which step 7's repo-internal-evidence rule already rejects**), with
  four of seven informative evaluations showing **no reduction** — ➜ **`self-edit-guard.yml` enforces scope,
  protected regions and a per-pass cap; it does not enforce *removal of an edit that did not help*. That is
  the next guardrail to build — a human call.** 🔴 **And the channel this repo fences is measurably the riskier
  one: editing a Markdown skill degraded robustness *more* than updating weights.**
- **12. 🔴 The failure mode has a name: *vacuity* — a check satisfied by the absence of the thing checked**,
  alongside **self-attestation**, *"where the subject supplies the value the check is applied to"* (**47
  vacuous gates in 69 shipped, reviewed loops**). **The rule: exhaustion, timeout and error must degrade to
  withheld approval, never to a skipped check.** ⭐ Signature to look for: **called-but-content-blind** — the
  check runs, consumes the artifact, and its verdict is independent of the content. ✅ **On reviewers, the
  evidence supports a sharper claim: every one that documents its spend cap documents it as *not a gate* —
  none turns exhaustion into an approval, none into a blocking failure, so the cap is reliably safe and
  reliably useless as a hard stop.** 🔴 **Kodus says it outright:** *"**This is a notification, not a cap.**…
  set a hard limit in your model provider's dashboard — **that's the only thing that can enforce it.**"*
  🔴 **Two vendors ship vacuity as the default** (CodeRabbit can *"approve the pull request"* while skipping
  review content; Greptile's gate reads the score the reviewer gave itself), ⚠️ **both defaulting to the
  riskiest tier with the safe setting opt-in.** ⭐ **CodeRabbit's own one-liner is the cleanest anti-vacuity
  rule found anywhere: *"A configured limit requires an assessment covering the current commit."***
  🔴 **And Anthropic Code Review cannot be a hard stop by design** (*"never approves or blocks"*), **so a
  required status check on it is structurally vacuous** — ✅ though Anthropic states this repo's rule for its
  own output: *"**Treat that as no verdict rather than as zero findings**"*. Keep the gate in **your** CI.

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
ignored by the harness's own retry layer twice, ten weeks apart** (v2.1.239, v2.1.311 — per-version quotes in
`sources.md`); since a gateway spend-limit block is a documented instance of *"marked not to retry"*
(*`x-should-retry: false`*), ➜ **"key a retry wrapper on `x-should-retry`" is a rule the vendor's own harness
has broken twice, and the result is an unbounded wall-clock hold in exactly the mode an unattended loop is
told to set** (that budget link is an inference). **A cap enforced inside the process it bounds shares that
process's failure modes, and an external counter that only ticks *between* calls cannot see a call that never
returns.** ✅ **One ceiling genuinely shipped: pooled group budgets** (v2.1.316) — *"one monthly budget that a
group's members share, **on top of each member's own limit**"* — **the cumulative ceiling this section
recorded as missing.** ⚠️ **Three releases of pooled-budget work later (through v2.1.319's
`admin.pooled_conflict_rule` / `admin.pooled_priority_order`) it is still documented nowhere, and the
spend-limits page still says *"not a shared pool"*** — ⚠️ **and v2.1.317 had to fix `/usage` *"showing a
developer's own spend limit as 100% used after their group's pooled budget ran out"*: a meter defect in a
brand-new ceiling, one release after it shipped, attributing exhaustion to the wrong ceiling.**

**Four further failure shapes, because a stop can fail without anything erroring.** ⚠️ **A ceiling can leak
through its *meter*, now eight ways (§4), and the meter is what the enforcing `429` is computed from.** 🔴 **A zero's meaning is systematic, not arbitrary — the
generalisation this primer previously missed.** In Claude Code **every wall-clock / idle / resource backstop
is disableable with `0`** — `STOP_HOOK_BLOCK_CAP` (8), `GOAL_CHECKIN_MINUTES` (30), `API_FORCE_IDLE_TIMEOUT`,
`WEBFETCH_DEADLINE_MS`, `MCP_TOOL_IDLE_TIMEOUT`, `TOOL_MEMORY_LIMIT`, and (new 2026-11-09)
`CLAUDE_ENABLE_STREAM_WATCHDOG` — **seven cases** — while **every count-or-dollar ceiling refuses it**
(`MAX_TURNS` *"rejected at startup"*; `MAX_WEB_SEARCHES_PER_SESSION` *"raised but not turned off"*;
`MAX_SUBAGENT_SPAWN_DEPTH` takes `1`, not `0`; `--max-budget-usd` rejects `0`). ➜ **So the stops this repo
most needs for #2's wall-clock limb are exactly the ones made disableable.** ❌ **Correction to this primer's
own "all on by default": `API_FORCE_IDLE_TIMEOUT` is unset-active only *"on providers other than the direct
Anthropic API"*** — the 5-minute body-idle stop is **off by default for direct-API users, i.e. most loop
authors.** 🔴 **And a new hazard — a threshold that is a *dependent variable*:**
`CLAUDE_ASYNC_AGENT_STALL_TIMEOUT_MS` (default 10 min, the only first-party subagent stall knob) has its
default *"rise with"* `CLAUDE_STREAM_IDLE_TIMEOUT_MS`, **so widening an unrelated network timeout silently
widens the stall detector.** ✅ Good forms to copy: `API_FORCE_IDLE_TIMEOUT` keeps a second watchdog *"even
when you set `0` here"*; `MCP_TOOL_IDLE_TIMEOUT` **clamps a minimum**; `CLAUDE_ENABLE_STREAM_WATCHDOG` is
*"on by default for all providers"* when unset. ⭐ **The teaching pair for this whole class is one comparison
operator wide:** goose's `max_turns = 0` **fails closed** (`if assistant_turn_count(messages) < self.max_turns`
→ `0 < 0` is false, so the stop fires at once) and its unset default is **1000, never unbounded**; ralph-tui
gates on `maxIterations > 0`, so `0` **silently removes hard stop #1**, its validator blesses it (*"Max
iterations must be 0 or greater"*), and its own log prints the cap as **`'∞'`**. **Still: test every ceiling at
zero** — ⚠️ **and note you may not be allowed to: AWS's *"minimum allowed value is the greater of $20 or a
conservative estimate of your likely spend"*, because *"hitting a spend limit is a disruptive experience"* —
a ceiling you cannot set low enough to verify**, whose graduated tiers are moreover *forecast*-driven
(*"before you would reach your limit"*), which is exactly what a runaway's spend curve breaks.
⚠️ **A ceiling can also fail by never *resetting*** (CrewAI's never reset at the kickoff boundary;
LiteLLM's monthly-reset test only passed in ≤30-day months) — ⚠️ **or by resetting only *upward*: AWS's
minimum is recomputed from prior-month spend, *"if that was high, it becomes the minimum"*, so overrunning
once raises the floor of what you may set next.** 🔴 **And a ceiling's documented recovery path can destroy
it:** in Managed Agents an unpriced model makes a budget unmeasurable — *"**Remove the budget to resume the
session**"*, and *"**Removing a session's budget is one-way**."* ⚠️ **Where the cap fires is answered by the
vendor — *"between model requests, not mid-request"*, overshoot per-**thread**, so it scales with fan-out —
and Cloudflare's meters *after completion*, so a burst of concurrency can pass the limit.**

**The failure is real and common, and the controls are independently reproduced.** Four citable cost
primaries — 🔴 **the five-window drought ended in-window** — plus a first *stall* primary (Gas City's
10.7-hour undetected stall, below). **Mandiant Case study 6**: a null value broke a tool, the agent entered
*"an unconstrained, recursive reasoning loop"*, made 15,000+ calls and a **~$50,000 spike in under an hour**,
**and locked a database that halted business transactions** — **so a runaway loop is an availability
incident, not only a billing one** (⚠️ **cite it directly**; the flattened *"a $50,000 cloud bill"* keeps
recirculating). **METR**: a stolen key ran ~3 weeks and ~$600,000 of free credits. **AWS `AGENTCOST07-BP01`**
states all three stops in its own words plus *"Implement cost controls outside the agent's control loop."*
🔴 **And new 2026-11-09, Mandiant/GTIG's LLMJacking report (Nov 2) answers "how fast must a ceiling act?"**:
*"fraudulent charges … exceeding $100,000 USD in a single day"*, *"more than 500,000 LLM API calls in less
than eight hours"*, *"massive bills… **in just minutes or hours**."* ⚠️ **Credential abuse, not a runaway
loop — but two mechanisms transfer exactly and are new here: the actor *"requested quota increases via the
cloud provider's API"* and *"subscribed victim accounts to Pay-As-You-Go agreements"* (➡️ **a ceiling
reachable through the credential it constrains is not a ceiling**), and defeated per-key limits by
*"continuously creating and deleting short-lived service accounts"* (➡️ **a ceiling keyed on something the
capped party supplies resets on rotation**).** 🔴 **And it files *"granular API quotas"* and *"spending
caps"* under a heading reading **"Budget Alerts"** — the alert/enforcement conflation this section exists to
correct, in a top-tier security vendor's own recommendations.** **High** on all four.

**How to shape the stops, from measurement.** Evidence and per-paper figures in `sources.md`.
- **A capped run is a third outcome, not a failure** — ⚠️ and **a budget the model is *shown* changes the
  work**. 🔴 **Decide what wins when a stop and the check fire together.** MartinLoop: *"**`wall_clock`,
  `budget_cap`, and `turn_cap` all outrank `goal_met`** — governance limits cannot be overridden by a
  simultaneously verified goal"*, while *"`goal_met` outranks `error_threshold` and `no_progress`"*, and
  ⭐ **`turn_cap` is suppressed when the goal is already met, so completing *on* the last permitted iteration
  is *"legitimate success, not an overrun"*.** **This repo has never said which wins.**
- **Progress-gated continuation beats a blind cap** (22/24 vs 13/24 under denial-of-wallet): keep the ceiling
  hard, make the *approach* progress-gated — **stall detection is what makes a hard cap affordable** — and
  **graduated throttling is sound as the approach to a ceiling, never as a replacement.** ⚠️ **Gas City shows
  the opposite error: a terminal stall *timeout* replaced by a ladder that *"nudges back off from 3 to 60
  minutes and never stop."*** 🔴 **And a third mode beside alert and halt — Yegge's budget cap **re-routes
  the work to people** (*"Humans are always the backstop"*).**
- ⚠️ **Stall detection belongs in the harness, not the prompt.** ⭐ The **evidence-action gap**: *"nearly
  every run that needs outside help collects sufficient evidence, yet a third still exhaust their budget"*,
  while an escalation tool *"cuts budget exhaustion from **34.0% to 6.7%**"*; ⚠️ **but *"a fired escalation is
  not yet a useful handoff"* if the ticket omits progress and verification status — escalate *with the notes*.**
- 🔴 **Two stall shapes from one dated incident (Gas City, 2026-10-31 — detail in `sources.md`), and this
  repo's own default is blind to both.** A provider pool *"ran out of usage"* and for **10.7 hours** a
  template *"spawned about 1,400 seats, and none claimed; held 48 PRs for a median 412 minutes; **raised no
  alert**"* — because the detector's first signal came at **22m30s** while the seats **idle-drained at ~10.6
  min** (*"Only 16 of 1,133 recycles ever fired"*). ➜ **(a) a detector whose interval exceeds the lifetime of
  the unit it watches is structurally blind, not mis-tuned; (b) hard stop #3 firing *upstream* produced an
  undetected stall *downstream*, which an iteration-keyed detector — like this repo's `LOOP_STALL_LIMIT=3` —
  cannot see at all, because no iteration occurs.** ✅ The fix states the doctrine: *"**No judgment:** the
  thresholds are consts… **No provider error text is read.**"* ⚠️ **Expect false positives too**, and ⚠️ a
  third shape — ***"overbaking"*: scope drift, where the loop keeps producing diffs so a diff-keyed detector
  never fires** (§3). ⚠️ **Classify failures so a hard one short-circuits the cap**, and **compute the ceiling
  deterministically on a durable-execution substrate.**
- 🔴 **A guard gated on the truthiness or positivity of its own limit is not a guard.** **LiteLLM** reads
  `max_budget = 0` as unlimited — ⚠️ **re-verified 2026-11-09 on `main`: still live in all three router paths
  (now lines 321/336/351, not the 289/304/319 this primer recorded), with `is None` used correctly nine lines
  above at 312, and a *fourth* site in the pre-invocation bridge (`rust_bridge/preflight.py:42`) that is worse
  still — `if max_budget and _current_cost > max_budget`, falsy-zero *and* a strict `>`.** Its fix has sat on a
  branch dormant since 2026-10-02, and **v1.108.0 shipped the bug stable again (2026-11-04)**; ⚠️ **yet the
  same package's `max_iterations_limiter` gets it right and increments *before* the call, while its
  `max_budget_per_session` meter increments *after* inside a blanket `except Exception` — so the difference
  between a ceiling that holds and one that doesn't is where the counter is incremented.** **ralph-tui** gates
  on `maxIterations > 0`, and **LoopTroop's** source says so outright. ✅ The correct form is an unconditional
  compare plus an explicit sentinel, which **`agentgateway`** implements — 🔴 **and its `on_budget_exceeded`
  has *no default at all*: a required field, so the author must choose `Audit` or `Block`.** ⭐ **MartinLoop
  v0.9.0 goes furthest and is the shape to copy: `0` is a *meaningful sentinel in both directions* —
  `live ? parsed > 0 : parsed === 0`, i.e. a live run *refuses* zero and a provider-free run *requires* it.**
  **Test every ceiling at zero — and test that it resets.** ⚠️ **Also test that a cap set *to the default
  value* is in force** (LangGraph 1.2.17 dropped an explicit `recursion_limit` equal to the default).
- ⚠️ **Record *which* stop fired.** *"Most failures end at a harness limit"*, the record *"identifies the
  assigned pressure no more reliably than a count of tool calls"*, and *"**execution limits also change the
  reported result**"* — **so a capped run's score is not comparable to an uncapped one's, and a cap that halts
  without saying so is indistinguishable from a capability failure.** ✅ First step shipped
  (`claude_code.safety_event`), ⚠️ **permission events only**; Gemini CLI still reports loop-detector and
  turn-cap bail-outs under **one indistinguishable event.** ✅ **And `arXiv:2610.41130` ships the shape to
  copy: *"Inconclusive tests and failed executions are reported separately alongside the verdict rate"*** —
  an ABSTAIN channel.

**Where ceilings actually exist.** Per-product and per-vendor quotes in `sources.md`; the full inventory in
[`archive/primer-detail-2026-11.md`](archive/primer-detail-2026-11.md). What a loop author needs:
- **Anthropic.** The **Claude apps gateway** blocks on daily/weekly/monthly caps, is the only surface with a
  **daily** ceiling, and ✅ gained the first first-party *cumulative* ceiling (pooled group budgets) — ⚠️ but
  **enforcement fails open by default** (`enforcement.fail_closed_on_error: true`). **Managed Agents budgets**
  are a genuine hard dollar cap but in **list** dollars, *"between model requests, not mid-request"*, metering
  web searches and **session running time**, and 🔴 **their documented recovery path destroys the ceiling**
  (unpriced model → *"Remove the budget to resume"* → removal is *"one-way"*) — ⚠️ **and new 2026-11-09, the
  SDKs let the ceiling vanish silently: the server rejects `0` with a 400, but a zero-value or unset budget
  struct is *omitted from the request*, so the session is created unbudgeted. Assert on the response, not the
  request.** The **Spend Limits API** is monthly and disowns its own meter (*"informational, not
  transactional"*); **task budgets** are *"a soft hint, not a hard cap"* and *"not supported on Claude Code"*.
  ⚠️ **Six passes now: observability ships, enforcement does not** — the newest is project **cost-code tags**
  (Nov 6), tracking only.
- **Elsewhere.** ⚠️ **On five gateways and inside a hyperscaler the real ceiling sits behind a non-default
  flag** — *if you did not turn enforcement on, assume you have an alert.* ✅ **The one to recommend is a
  gateway, not a vendor: Cloudflare enforces *before* dispatch and meters per `agent_id`** — ⚠️ with
  concurrency-shaped overshoot, only for *"models with known pricing"*, max 20 rules, and a self-declared
  *"best-effort estimation"*. 🔴 **New 2026-11-09, and it inverts the recommendation's default: Cloudflare now
  documents an exhaustion behaviour that does not stop — *"Fall back to a cheaper model… AI Gateway
  automatically routes requests to the fallback model **instead of blocking them**"*, with no budget on the
  fallback. For a loop the only acceptable setting is block** — ⚠️ **worse, it silently swaps the model under a
  verification step exactly when spend is highest.** ✅ **It also gained an *unforgeable* bucket key**
  (gateway-assigned `cf.user_id`, *"You do not need to pass user IDs from your client application"*) — 🔴 **but
  *"Service-token requests do not include `cf.user_id`"*, i.e. it is unavailable to precisely the headless
  loops this repo runs, which fall back to a client-supplied key the capped party can rotate.** **Google** and
  **AWS** pause a project (⚠️ monthly, 90-day deletion tail, forecast-driven tiers, a **$20 floor** — ⚠️ **and
  new: the floor *ratchets up* from prior-month spend, *"if that was high, it becomes the minimum"*, so
  overrunning once raises what you may set next**); **Azure is an alert**; ⚠️ **Bedrock is a meter, not a
  control.** ⚠️ **No model vendor offers a per-API-key ceiling** — they scope to *identity*, **and a loop
  harness holds a key, not an identity** — ✅ **the one hosted per-key ceiling is OpenRouter's, with a
  **daily** reset.** ⚠️ **An exhausted budget's durable signal is a header, not a code** (`x-should-retry:
  false`; LiteLLM `422`; OpenRouter `402`/`403`, still self-contradictory) — **key a retry wrapper on the
  header.**
- **In-harness.** ✅ 🔴 **MartinLoop (v0.9.0, in-window) carries all three stops plus a verifier, an explicit
  precedence order, and the best zero semantics found anywhere** — the closest external analogue of this
  doctrine. **AgentGuard** enforces **before dispatch** and ships a drop-in stall detector plus iteration cap
  as a Claude Code hook; ⚠️ **its lesson: a dollar ceiling is only as good as its price table.** ⚠️ **Codex's
  token ceiling is `UnderDevelopment`, `default_enabled: false`, undocumented, and fails open when
  unconfigured** (`record_usage` returns *not exhausted* on an uninitialised lock). ⚠️ **opencode v2.2.6
  (Nov 6) *removed* a stop: `opencode run` now waits on background jobs with *"no time limit: a job that never
  exits… keeps the run open"*, so a step that spawns a dev server never returns and neither the iteration
  counter nor the budget meter ticks — wrap it in an external `timeout`.**

**Open human calls this section raises.** The full list with evidence is the `sources.md` backlog — **now ~190
open items and growing faster than it resolves, which is itself worth a human's attention.** The load-bearing
ones: the check's **provenance clause**, now an **ordering** rule (§5A.2); **the check must run on the version
about to land**; 🔴 **never gate on the harness's exit status** (§5A); a **corpus-level re-test** and a
**sunset/revert obligation** on accepted self-edits; **hard stop #2 needs a wall-clock limb**, since
`LOOP_STALL_LIMIT` is iteration-keyed and blind to a stall in which nothing iterates; **adopt a stop/goal
precedence rule**; 🔴 **require that the loop's credential cannot raise its own ceiling, and that the ceiling's
bucket key is not one the loop supplies** (both now primary-sourced, above); adopting `onFailure: "block"`,
`permissions.denyInsteadOfPrompting`, `blockWritesOutsideWorkingDirectories` and the retry-watchdog bounds
across `guardrails/` (⚠️ **none of which this repo sets today**); whether an unattended loop must run with
**no third-party mods** and a **global-config tool floor**; whether this repo's Routine needs a **cumulative**
ceiling; and ⚠️ **the correction the routine owes its own runbook: the `claude/` prefix is a *default*, not an
enforced restriction — the enforceable floor is a GitHub ruleset the connected identity cannot bypass, and
`main` here is still `"protected": false`.** None is applied by the knowledge base; each is human-authored.

## 7. The one-paragraph answer

Stop being the thing in the loop. Write the loop once, give it **skills** worth calling and a
**verification** step it did not author — written *before* the code it checks, run on the version about to
land, and read from its *own* output rather than the harness's exit status — then **cap it** (iterations +
dollars + stall detection, every ceiling tested at zero) so it provably halts, and let it run on a schedule
while you go decide *what* to build.
