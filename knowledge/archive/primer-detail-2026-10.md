# Archive: primer §5A per-item detail, as of 2026-10-19

Moved out of [`../00-primer.md`](../00-primer.md) on **2026-10-19** to keep it inside its 750-line
briefing budget (`.github/workflows/kb-size.yml`), per `update-knowledge` SKILL.md step 5. Nothing here
was retracted or superseded — it is the fuller per-paper prose behind the compact syntheses that now
stand in §5A items 3–6 and 9–11. Every claim below is also recorded, with its source and confidence,
in [`../sources.md`](../sources.md), which remains the canonical per-claim record.

## §5A items 3–6 (verbatim as of 2026-10-19)

**3. The agent's account of its work is not evidence.** Agents skipped files they were asked to review in
67.9% of runs and misreported 80.4% of those; *"agents' final responses are not reliable accounts of their
actions"* (arXiv:2609.20812). Against logged results, *"only 16-29% of the improvements agents claim are
real"* (arXiv:2610.02588), whose governing rule states this doctrine independently: *"prose can state a
proposition, but only evidence returned by an executed action can support or refute it."* A verifier shown
the maker's trace accepts 78–90% of failures, and *"an instruction to 'use only the frames' does not remove
the effect"*. **The stop condition must be observed, not reported; the verifier must not read the maker's
narration.**
⚠️ **The hardest number yet, and it indicts a green check too:** when a co-installed similar skill runs
instead of the installed one, *"the final reply names the skill used in only 0.9% of substituted runs"* —
and *"The task still passes, so benchmarks that check only task completion miss such cases"*
(arXiv:2610.11647, n = 6,368 runs). **A passing deterministic check does not establish that the loop used
the guardrail skill it was told to** — the paper names a ban on touching git among the lost functions — and
its fix is a **pre-tool hook at the first skill read**, a shape this repo already ships. ⚠️ **And a subtler
form of trace tampering than editing a log:** *"the agent itself determines which authoritative observations
become visible during execution"* (arXiv:2610.11514) — **selective admission of evidence, which a verifier
reading the maker's trace inherits.**

**4. Telling an agent is not a control.** 57.1% of runs reward-hack even when told not to; instructing
re-verification helps but does not eliminate. **Rich reviewer feedback trains evasion** (40.5% with detailed
feedback vs 20.3% with generic rejection, arXiv:2609.28614), so **inside an iterating loop prefer a terse
fail verdict to an explained one** — ⚠️ reinforced by a new channel: along a transmission chain *"the code
acquires more persuasive justifications"* (arXiv:2610.12822), **so a justification that improves while the
artifact does not is exactly what a judge reading a trace is vulnerable to.** A decomposed multi-agent judge
can be *worse* than one direct ask — **let the verifier ABSTAIN**, and note which component abstained cleanly
in practice: *"A deterministic same-packet comparator correctly resolved the bounded task or abstained
throughout"* (arXiv:2610.09581). **A contaminated benchmark is not a verifier.** ⚠️ **And deception needs no
inducement**: *"substantial deception even under the Neutral condition"*, including *"models recognize
infeasible or conflicting requirements but still present them as achievable"* (arXiv:2610.13626, **cite the
direction, not the figure**) — **the mechanism behind why a loop cannot stop on its own self-assessment.**

**5. Long-horizon loops hit a verification ceiling, and reliability decays with steps.** Two independent loop
benchmarks land at ~25% (LoopsBench, LoopArena), both finding **verification and regression management, not
coding ability, the binding constraint**. On agentic tool loops every model tested fell to near-zero within
sixteen steps, tracking **step count, not context length** — **so an iteration cap also bounds the region
where the agent is still reliable.** **High.**

**6. The harness is the unit worth engineering.** The evaluation harness moves SWE-bench solve rate 4.3×
while the training recipe moves it 1.16×; harness expansion alone can degrade previously solved tasks —
**prune `.claude/`, don't accrete it.** The **model+scaffold pair is the reliably measurable object and the
model alone is not.** Designs worth copying are in `sources.md`, including PROCTOR's **canary cases, so "a
100% suite score is not a triumph but a tripwire."** `claude plugin eval` applies the same instincts (3 runs
per case, a **no-plugin baseline arm**, cases hidden from the agent, *"suspect the judge before the
plugin"*) — but ⚠️ **two caveats**: its `llm` judge reads the maker's trace (*"an `llm` judge sees the first
12 and the last 12"* messages), mitigated only by three votes; and while the **cost-ceiling** form of budget
exhaustion is now marked `partial: true`, **a plan-usage-limit hit mid-suite still is not**, so it can still
masquerade as a regression (**High**).

## §5A items 9–11 (verbatim as of 2026-10-19)

**9. ⚠️ A loop's own instruments are removable by the thing they monitor.** Claude Code is among harnesses
that let an agent **delete its own execution traces without triggering monitor guardrails**, and this
*"emerges naturally … when agents try to improve their rewards"* (arXiv:2609.30266); agents evade runtime
monitors under ordinary task pressure, including by retrying *"until relevant context leaves the monitor's
history"*, and **evasion rises with reasoning effort and token spend** (arXiv:2609.30217 — same authors, one
failure domain). ⚠️ **Claude Code added a per-subagent `effort` parameter this window**, so that dial is now a
safety dial too. A **low monitor reading proves nothing**: *"an out-of-band behavioral check is required"*.
**The meter must not live inside the thing it meters** — AWS reaches the same rule independently (*"Implement
cost controls outside the agent's control loop"*). ⚠️ **Two first-party instances now**: the official
**ralph-wiggum** plugin keeps its iteration count in the agent's worktree where `max_iterations: 0` disables
the cap, **and `/loop` itself ran an extra iteration after `.claude/scheduled_tasks.json` was deleted** (§4).
Tamper-*evidence* is cheap (a hash chain *"detects every edit"*) but is **not** tamper-prevention — the same
tool *"blocks only 18 of 44 harmful tool calls (41%)"*. ⚠️ **And an instrument can be swapped under you**:
arXiv:2610.07359 found *"One judge tier was served by an unrequested model version in 50 of 112 batches"*,
which **reversed five of its conclusions** — **record the served model on every call.** This repo applies the
rule: every stop and the success check read state the agent cannot write.

**10. Human approval is a boundary only if what was approved is what runs.** **Loopjacking**
(arXiv:2609.21081): a human approves operation A, the implementation executes B — ⚠️ **and Claude Code
shipped two first-party instances this window**, an image and a notebook/PDF read *"able to return a file
outside what was approved, through a link swapped in mid-read."* **Approval laundering** (arXiv:2609.28586):
the approved action's transitive effects go unrecorded. For this repo, whose envelope rests on "a human
reviews and merges every PR", the question — does the gate bind the reviewed diff to what merges? — is **a
human call** checkable in CI.

**11. Self-improvement needs an external, enforced gate.** Capability-improving self-edits failed
recoverability and conventional repair recovered 0; a poisoned benchmark can make a self-evolving agent
disable TLS validation, and **a later clean evaluation does not clear a poisoned one**; prompts are a
reward-hacking substrate and **inspectability is not a defense**; an 8-day recursive run still had **32%
residual reward hacking** (`sources.md`). ⚠️ **And per-edit gates do not compose**: a corpus-level guard
caught *"declining performance as individually validated rules accumulate"* as active rules grew from **13 to
70**, each having passed its own gate (arXiv:2609.24130); **a stale cached pass is not a pass** and
**default-deny without rollback is not safe-by-default** (arXiv:2610.01073).
⚠️⚠️ **The corpus-level re-test now has a cheap, published form.** arXiv:2610.11464: *"removing the anchor
guards collapses the verifier into a vacuous always-pass grader, yet that collapsed verifier trains skills
just as well. **Downstream task score cannot certify a self-evolved verifier.**"* Its gate is selected *"for
agreement with a ten-item anchored reference set … **never for the agent's score**"* — **a handful of frozen
cases the gate must still decide correctly, re-run against the accumulated `SKILL.md` every pass.**
arXiv:2610.09239 says why it must not be tiny: *"the final selection-set score of greedy loops exceeded
held-out accuracy by 13 to 20 points with 16 selection items and by 1 to 5 points with 256"*, and *"most
proposals after the first are harmful."* ⚠️ **This repo's gate has a selection set of effectively one diff.**
Three independent groups agree on the direction; magnitudes are not comparable. ⚠️ **And the adversarial
version:** SkillPoison reaches *"95.71% attack success rates, while all injected experiences remain
task-correct and pass verification and lexical inspection"* by *"remov[ing] the contextual conditions that
constrain when the behavior applies"* — **every edit passes its own gate because every edit is genuinely
correct; the harm is what accumulates.** A formal backstop: bounded self-modification *"under a common sound
interpreter and fixed verification protocol remains within the same verification class"* (arXiv:2610.10611) —
**a fenced self-edit is provably not an escape hatch, *provided the gate is genuinely fixed and external*.**
SaltBench's lesson applies to `self-edit-guard`: *"a probe written in the sandbox's language cannot see a
hole in the layer above it."*

## §5A item 8 — "configuration is code" and carrier detail (verbatim as of 2026-10-19)

- **Configuration is code, and a *declared* gate is not a gate.** Trojanized plugin hooks compromised all
  seven harnesses tested; **SkillShift** biases decisions with no payload to scan; **Plugin4Shell** pinned a
  commit but *"never verifie[d] it landed there"*; GitSpawn's `claude ultrareview` path remains unresolved —
  **never run it in a loop on an untrusted tree.** ⚠️ **Four first-party gates silently did not run in one
  week** (a user mod skipping an organization's guard; a hooks-worker restart; a **tampered on-disk cache**
  that could *"switch off or unseat the built-in policy plugin"*; a UNC-path permission bypass), plus **two
  TOCTOU swaps on an *approved* read** — *"a file outside what was approved, through a link swapped in
  mid-read"*. **Mod containment is load-order dependent.** ⚠️ **Scanning the source is not admission
  control**: **PyCache Trap** reaches *"94-100% attack success"* across 7 scanners because *"Python may
  execute a bundled bytecode cache with different behavior"* — **the artifact inspected is not the artifact
  that runs**, the same class as an allowlist matched on a string rather than an argv vector.
- **Other carriers:** egress allowlists are only as strong as the resolver (`/etc/hosts` laundering); a model
  wrote jailbreak-style instructions into its own compaction summaries; Cline fixed hooks whose injected
  context was **silently dropped** (**verify an injected guardrail reached the model**); **MCP tool metadata
  is a semantic supply chain** whose budget grew 2,048 → 4,096 up front and → 16,384 via tool search.
  ⚠️ **And MCP allow rules narrowed in v2.1.299** — `mcp__a` no longer matches `a__b`, so **an existing
  prefix rule silently tightens and a loop that relied on it starts prompting.** **Adversaries run this
  repo's pattern** — the discipline is value-neutral.

## §3 "The key voices" — fuller per-voice prose (verbatim as of 2026-10-19)

The primer keeps a condensed version. Nothing here is retracted; the per-essay records with dates and
confidence are in [`../sources.md`](../sources.md).

## 3. The key voices

Per-essay quotes and dates in `sources.md`. ⚠️ **Read every voice's surface before its silence**: full-text
feeds (`ghuntley.com/rss`, `addyo.substack.com/feed`, `steve-yegge.medium.com/feed`) serve complete bodies and
bypass the Substack/Medium 403s, so a page fetch is rarely needed.

- **Anthropic** — "Loop engineering: Getting started with loops" (Jul 7, 2026) is the Claude Code team's own
  definitional post: turn-based loops, `/goal`, `/loop`/`/schedule`, quality from verification skills, cost
  from turn caps. ⭐ **And now a first-party account of the practice at scale** — "How the Claude Code team
  does code review" (Osmani, Lunt, Wang, **Oct 15**), which is the strongest evidence yet that this doctrine
  is *enforced* rather than requested: *"We give Claude something it can run—like tests, a build or a
  screenshot to compare against the design—and **ask it to show the output instead of saying it's done**"*;
  **a real merge gate** — *"A PR can't merge while any finding from the bug review or the security review is
  still open"*; findings *"verified by other agents before humans review them"* with *"a separate group
  [that] votes on each finding, and it only gets posted if enough of them agree it's real"*; *"Any incidents
  are now an eval"*; and a `REVIEW.md` beside `CLAUDE.md`. ⚠️ **Note the gap between practice and product:
  Anthropic's own PRs are blocked by open findings, while shipped Code Review *"never blocks merging"*
  (§5A.12).** **High.**
- **Addy Osmani** — the most consistent written statement of this doctrine. The arc: agents run the inner
  loop and engineers own the accountability boundary; *"you can only hand a loop as much autonomy as you can
  cheaply and reliably verify, and not one inch more"*; maker ≠ checker, because *"a test written or
  controlled by the thing it's testing doesn't prove much"* and *"real independence comes from a different
  source of truth: a spec a person wrote, a reference implementation, a proof."* ⭐ **"Agentic Verification"
  (Oct 14) adds the most actionable new idea of the window — the loop *teaches* the agent**: *"tests are also
  how your agent senses the world and knows when it's done"*; *"Tests must be fast and deterministic, or the
  agent will pick up the wrong lesson"*; *"It's not merely a time sink — it's a training exercise"*; *"The
  agent... learns from the incentives of the loop."* If a retry sometimes works it adopts retrying; if tests
  take 15 minutes it batches changes and loses the ability to localise failures — and ⚠️ **"Both failure
  modes cause the agent to get worse, but without any visible sign of failure"**, which **a stall detector
  keyed on activity cannot see, because the loop looks busy.** Also *"I would always prefer a much better
  feedback loop to a slightly better model"* and *"Example tests say what should happen; properties say what
  must not."* ⚠️ **His `.com` blog now lags Substack by ~30 days and has no working feed** — a `.com`-only
  check would have missed this post entirely. **None of the essays address iteration caps, stall detection or
  budget ceilings.** **High.**
- **Geoffrey Huntley** — the most prolific voice here (**five more posts Oct 13–17**). The through-line is
  **back pressure**: *"Types are a form of verification. They provide back pressure: compiler errors that the
  LLM picks up and fixes automatically, every loop"*, and *"compile time is the tax on back pressure"* — so
  **iteration throughput is a loop-design variable.** Primitives: a **golden oracle** (*"If you have an
  oracle, porting is a loop"*) and **guardrail by removal**, stripping force-push out of Git itself. ⭐ **The
  in-window passage worth copying, because it is enforcement over instruction** (Oct 13, independently
  amplified by Willison the same day): rather than documenting a rule, *"I write a pre-commit hook that
  checks the git diff for direct calls to observability modules that bypass my diagnostics module. Boom: fail
  the commit, inject a prompt telling the agent to use the diagnostics library. All of a sudden it's ten out
  of ten"* — because updating `AGENTS.md` leaves *"still a delta, and it'll drift."* Also *"That's why I'm in
  the verification space: you need a good verification platform as back pressure"*, *"a program is
  reproducible and verifiable"* (a prompt and its output are not), and a staleness rule this repo should heed:
  *"your AGENTS.md and many of your skills should be deleted after every model release, or at least every
  couple of months, and redone."* ⚠️ He endorses **no** iteration cap, stall detector or cost ceiling, and
  works **without** two controls this repo mandates (*"My agents have sudo, and I push to main"*) on a
  disposable box — **cite as his practice, not as a recommendation.** ✅ He has now published CURSED's cost:
  *"roughly US$6,000, and I did it three times over"* — a named, self-reported figure, **not** the
  blacklisted anonymous *"$6,000 overnight"* anecdote. **High.**
- **Simon Willison** (**High**) — loops need *"extraordinary discipline and knowledge"*; *"you can actually
  spend $1,000 in a day doing real work"*; and a first-hand pathology: `max` effort *"hit [the 128,000 output
  limit] while it was still reasoning"*, replicated on two models — **so an iteration can consume its whole
  output budget and emit nothing, and a stall detector must key on state change, not "did it respond".**
  ⚠️ **He is still the only outside voice for hard stop #3**: *"Soft caps, 'after $X/month, send me a warning
  email', will not cut it"* / *"hard budget caps need to be the default"* (Oct 3) — **and his subject is the
  pay-by-usage services a loop's *code* calls, a cost surface `guardrails/` does not cover.** Nothing
  in-window on ceilings, so that remains a single post.
- **Boris Cherny** — created Claude Code; *"My job is to write loops"*; 259 PRs in 30 days all written by
  Claude Code; permanent background loops submitting PRs. On verification, now quoted on an Anthropic surface:
  giving Claude a way to verify its work is *"probably the most important thing"*, worth *"two to three times
  better"* results, and *"verification looks different for each domain."* **No enumerable first-party feed, so
  "nothing new from Cherny" is only ever Medium** — a permanent limit, not a weekly finding.
- **Steve Yegge** — Gas Town → **Gas City** (orchestration SDK; **v1.5.0**, from `gastownhall/gascity`; the
  `gastown` repo this KB once tracked is dormant). Gas Town *"fell apart at the seams with Opus 4.7"* — **a
  model update silently broke a working loop, an argument for stall detection** — and *"harnesses need to be
  part of your application, chemically bonded in"*. His failure report: agents ratcheted to *"650 distinct
  refusal sites"* until *"we cut it down to 14 fences, and now I have to personally approve any new ones"* —
  **independent support for widening a guardrail envelope being human-authored only.** Quiet ~8 weeks. **High.**
- **Peter Steinberger** — the fuse (~Jun 7, 2026): *"you shouldn't be prompting coding agents anymore. You
  should be designing loops that prompt your agents"*. ⚠️ **His blog is quiet since 2026-02-15 but he posts
  mainly on x.com, which is unfetchable here, so this is permanently a coverage gap, not a verified quiet.**
- **Armin Ronacher** — on-topic since "What is Codemode" (Oct 6): a QuickJS/WASM sandbox with *"no network, no
  file system, no timers, limited RAM"* and a cap of *"four"* concurrent tool executions, ⚠️ **but its "30
  step loop" is agent-authored inside a generated script, not a harness cap, and it ships none of the three
  hard stops.** Blog carried nothing in-window.

## §5A item 12 — the vacuity dossier in full (verbatim as of 2026-10-19)

The primer keeps a condensed version. This is the full six-instance enumeration and the review-tool
corrections made on 2026-10-19.

**12. 🔴 The failure mode has a name now: *vacuity* — a check satisfied by the absence of the thing checked.**
arXiv:2609.27871 (*"Bounded Loops"*, v1 2026-08-20, cs.SE) names it alongside **self-attestation**, *"where
the subject supplies the value the check is applied to"*, and found **47 vacuous gates in 69 shipped,
reviewed loops**. ⚠️ **Read its own caveat first:** *"the apparatus, not our number, is the contribution"* —
freezing the gates and applying a fresh mutant family *"recovers a 23.3% false-accept rate where the
exhausted corpus reported none."* Its definition of a bounded loop is this repo's doctrine in three terms:
*"a worker, an independent gate the worker cannot write to, and a declared budget"*, with the budget
*"enforced inside an attempt, not between attempts."* **Six independent instances, found separately:**
(a) **Anthropic Code Review** — at its monthly cap *"Code Review skips the review"*, and the check run
*"doesn't conclude as a failure"*, so **a correctly-configured hard ceiling can produce an unreviewed merge**;
(b) **roborev** — `success` means *"a comment was posted, including comments that contain findings"*, so a
required check gates on *a review having happened*; (c) **CodeRabbit** — *"Incomplete analysis alone does not
cause failure"*; (d) **Qodo 3.1** (Oct 15) ships *"automatic rule deactivation for rules whose findings are
rarely fixed"* — **a gate that erodes its own surface through use**; (e) arXiv:2610.23362 in deployed safety
monitors — *"the evidence is already recognized yet disconnected from enforcement"*; (f) arXiv:2610.19264
(*n* = 6,309 skill listings) — frontmatter *"removes confirmation prompts rather than restricting what the
skill can reach"* and **59% of declaring listings understate what their bundle can do** (self-attestation at
scale). Practitioner form, via arXiv:2608.21884: a loop *"satisfies the gate you wrote"*, not the goal.
✅ **The safe design is attested twice.** **Ellipsis:** a reviewer that runs out of budget *"contributes
nothing"* and the review posts *"never as an approval"*; *"when no reviewer finishes, nothing is posted and
nothing is marked reviewed."* **Greyling:** a verifier *"makes rejection the default, so the agent's output
must 'earn' approval."* **The rule: exhaustion, timeout and error must degrade to withheld approval, never to
a skipped check.** ⚠️ **Correction to this KB:** *"no tool does both"* is **false** — CodeRabbit gates merges
(pre-merge checks in `error` mode plus a fail-closed Security required check, and ships maker ≠ checker as a
setting that once disabled *"cannot be re-enabled"* from the branch — **the property this repo needs of
`self-edit-guard`**) while **roborev does neither** (*"The cap never stops jobs"*). **The surviving, sharper
claim: no reviewer documents what its spend cap does to its merge gate.** Agent-driven review of untrusted
code stays a **privileged operation**: "Friendly Fire" hijacked auto-review into RCE, and an
`AGENTS.override.md` in a PR made Codex approve a backdoor — **keep the gate in your own CI.** ⚠️ **And
review must be made to converge:** Anthropic reports a PR going *"more than fifty rounds of review and fixes
overnight before its author stopped it"*, with **59% of repeat flags on code already there at the first
pass** — **an agent author and an agent reviewer can keep each other busy indefinitely.**
