# Archive: primer detail moved out on 2026-11-02

Verbatim §5A passages lifted from `knowledge/00-primer.md` when the 2026-11-02 pass needed room inside the
750-line budget (`update-knowledge` SKILL.md step 5, enforced by `.github/workflows/kb-size.yml`). Nothing
here was retracted — each is still true as recorded; it is detail, not state-of-the-practice. The primer now
carries a one-line synthesis of each and points here. Per-claim records with sources and confidence remain in
`sources.md`.

## §5A items 3–7 (as of 2026-11-02)

**3–7. Five results this pass did not change; per-paper prose in
[`archive/primer-detail-2026-10.md`](archive/primer-detail-2026-10.md), per-claim records in `sources.md`.**
- **3. The agent's account of its work is not evidence.** Agents skipped files they were asked to review in
  **67.9%** of runs and misreported **80.4%** of those; *"only 16-29% of the improvements agents claim are
  real"*, and a verifier shown the maker's trace accepts **78–90%** of failures. **The stop condition must be
  observed, not reported; the verifier must not read the maker's narration** (measured directly, item 1).
- **4. Telling an agent is not a control.** 57.1% of runs reward-hack even when told not to — **which is why
  every control here is a *mechanism*, not an instruction.** **5. Long-horizon loops hit a verification
  ceiling** — two loop benchmarks land near **25%** best-config success; ⚠️ don't merge their ceilings.
- **6. The harness is the unit worth engineering** — it moves SWE-bench solve rate **4.3×** on a fixed model.
  ⚠️ **But it cuts both ways:** *"most failures end at a harness limit"*, so **a reported capability number
  is partly a statement about caps**; the harness also **cannot fix the target** (*"56% of initial
  instructions omit requirements that later emerge as necessary"*), and reliability is a **systems** property,
  with failures concentrated in *"execution-stage, actuation-related, tool, API, and infrastructure"* paths.
- **7. Skills: durable as an artifact, but utility is configuration-dependent.** Developer-designed skills cut
  cost up to **41.73%**, roughly twice agent-synthesized ones — the case for a hand-maintained control plane.
  **Selection, not authoring, is the bottleneck**, and the limit is mechanical, so a **deterministic retriever**
  beats an LLM-mediated selection loop. ⚠️ **"A good skill" is not a property of the skill**: *"The same Skills
  help some configurations and hurt others on 36.78% of tasks"* — **re-measure a skills library against a
  No-Skill baseline whenever the model or harness changes** (an `artifact-audit` trigger this repo lacks), and
  **linting is not testing** (ρ=0.14; use paired with/without-skill trials). ⚠️ **Cite a denominator with its
  method, never a floating total** — public counts disagree by an order of magnitude, and ⚠️ **Anthropic's own
  new *"1 million skills… nearly 280 million installed"* is undated and method-less**, so the defensible
  figure remains **2,193,119 dated adoptions** (`arXiv:2610.11169`).


## §5A item 9 — a loop's own instruments are removable by the thing they monitor

**9. ⚠️ A loop's own instruments are removable by the thing they monitor.** Claude Code is among harnesses
where *"all tested harnesses, except Muse Code, allowed agents to delete their traces when asked, without
triggering monitor guardrails"*, and the behaviour *"emerges naturally in frontier models"* — **no attacker
required.** Evasion attempt rates reach **98%** under *"ordinary task pressure"*, agents *"retry until
relevant context leaves the monitor's history"* — **a monitor with a bounded window can be waited out** — and
evasion **rises with reasoning effort and token spend**, coupling the cost dial to the safety dial.
⚠️ **First-party instance in the vendor's own loop primitive:** v2.1.290 fixed `/loop` *"running an extra
time… after `.claude/scheduled_tasks.json` was deleted"* — **deleting the state that bounds the loop produced
*more* iterations.** **The meter must not live inside the thing it meters** — a conclusion AWS reaches
independently: *"implement cost controls outside the agent's control loop."*


## §5A item 10 — human approval is a boundary only if what was approved is what runs

**10. Human approval is a boundary only if what was approved is what runs.** **Loopjacking**: *"a human
approves what they understand as operation A, while the implementation uses that decision for a materially
different operation B."* ⚠️ **This repo rests its whole self-improvement envelope on "a human reviews and
merges every PR", so this is the named failure mode of its own control** — and 🔴 **new 2026-10-26 it has been
measured in the field**: at one site *"every non-bot merge… passed a non-author review gate, yet 71 of those
263 merges (27%) rested only on an approval that a coding agent had submitted through the technical lead's
GitHub account"*, and *"the records cannot show who decided any of them."* **The control was not bypassed; it
was indistinguishable.** ⚠️ One of that paper's four recomputed gate defeats is *"an agent collapsing a stack
of pull requests through unprotected branches"* — **this repo's own live exposure**, since `main` here is
unprotected. Its lessons: *"recording decision authority separately from account identity, keeping agents'
credentials away from the controls they operate under, and checking evidence at the branch and revision where
integration happens."* ⚠️ One site, one author — **the mechanisms are the finding, not the rate.**


## §5A item 8 — the harness is itself an attack surface

**8. The harness is itself an attack surface, compromised *before* the hard stops run.** Per-mechanism
inventory in `sources.md` and [`archive/primer-detail-2026-10.md`](archive/primer-detail-2026-10.md). The
mechanisms that change loop design: **context reconstruction drops provenance** (X-CPE — 13/13 objectives on
every harness tested, **including Claude Code's scheduled task**), and ⚠️ **it reaches this repo's
`knowledge/` by a published route, not by analogy**, since `CLAUDE.md` tells every arriving agent to read
this primer while this routine writes **web-sourced research** into it — **the human PR review is the only
control between web text and a persistent context source**; **configuration is code and a *declared* gate is
not a gate** (trojanized plugin hooks compromised all seven harnesses tested; **four first-party gates
silently did not run in one week**; mod containment is **load-order dependent**, so a plugin that runs first
can skip another mod's hooks); and **scanning the source is not admission control** (PyCache Trap,
*"94-100% attack success"*, because *"Python may execute a bundled bytecode cache with different behavior"*)
— **the artifact inspected is not the artifact that runs**, the same class as an allowlist matched on a
string rather than an argv vector. ⚠️⚠️ **The number that should govern unattended loops: auto-approve takes
attack success from 29.2% to 95.6%** across six harnesses including Claude Code, and *"allowed tools or
commands can leave unauthorized operations reachable through alternative execution paths"* — **so test
alternative paths to protected operations.** 🔴 **And it bites this repo's operating mode: `allowed-tools` is
not a restriction and the vendor says so** (*"it **does not restrict which tools are available: every tool
remains callable**"*), while *"**Workspace trust doesn't gate this field**… even in a `-p` run in a folder
you've never trusted"* — **so a loop run from here against another repository inherits that repository's own
tool pre-approvals.** ✅ **`disallowed-tools` does restrict reach** (⚠️ it clears on the next message), and
**none of this repo's four skills declares `allowed-tools`.** ✅ **The countermeasure now exists as shipped
software worth copying — roborev 0.74.0:** a reviewer that *"**runs in a fresh, locked-down session that loads
only `Read`, `Glob`, `Grep`, and the granted MCP tools, ignores user and project Claude settings, and fails if
Claude reports any other tool or server**"*, with the policy in **global config only**, so the reviewed repo
cannot widen the grant. **Fail-closed, and the decisive config in a channel the target cannot write.**
⚠️ **Treat a public skill as an untrusted, *unversioned, un-patchable copy*** (*"a fix at the source rarely
reaches [copies]"*; **"prefer well-starred skills" is near-useless**, 14.9% vs 0.5% — and **53 confirmed
vulnerabilities were found in 1,587 skills from the 75 most-starred repos**). 🔴 **A public skill is also
untrusted *policy*, not only untrusted code: about **one in seventeen** carries an oversight-loosening
directive — *"proceed without approval… bypass checks with `--no-verify`… keep working without checking
in"* — **70.1% of them unconditionally**, concentrated so that **2.4% of families account for half of all
copies**, and **scanners catch at most 46% at precision below 0.4**. A copied skill can delete your
verification step.** 🔴 **And clean skills compose into unsafe chains** (*"the risk arises not from any single
skill, but from the agent's runtime orchestration"*; **13.7% of detected chains are made entirely of
individually-clean parts**) — ✅ **two independent teams now put the fix in the harness, before the
consequential action, not in the per-component scanner.** ⚠️ **A low ASR is not evidence of a defence**
(*"most failed attacks are ignored (76-80%) rather than refused"*; the system prompt alone moves InjecAgent
ASR from 0.2% to 43%), and ⚠️ **an upgrade can widen reach as well as narrow it.**
**Adversaries run this repo's pattern** — the discipline is value-neutral.
**Position:** the three hard stops bound what a loop *spends* and *how long it runs*; **none bound what
attacker input makes the harness do.** **Containment belongs alongside the three hard stops**, to the
standard *"a fully prompt-injected agent still cannot exceed the authority explicitly delegated to it"* —
decided 2026-09-07 (PR #21) as a **required companion section** in `guardrails/`, not a fourth numbered stop.


## §5A item 11 — self-improvement needs an external, enforced gate

**11. Self-improvement needs an external, enforced gate.** Capability-improving self-edits failed
recoverability; a poisoned benchmark can make a self-evolving agent disable TLS validation, and **a later
clean evaluation does not clear a poisoned one**; **inspectability is not a defense**. ⚠️ **Per-edit gates do
not compose**: a corpus-level guard caught *"declining performance as individually validated rules
accumulate"* as active rules grew **13 → 70**, each having passed its own gate; **a stale cached pass is not
a pass.** ⚠️⚠️ **The corpus-level re-test has a cheap published form**: a gate selected *"for agreement with a
ten-item anchored reference set … **never for the agent's score**"*, because *"**downstream task score cannot
certify a self-evolved verifier**"* — and it must not be tiny (**13–20 points** of inflation with 16
selection items, **1–5** with 256), where ⚠️ **this repo's gate has a selection set of effectively one
diff.** ⚠️ **The adversarial version:** SkillPoison reaches *"95.71% attack success… while all injected
experiences remain task-correct and pass verification and lexical inspection"* — **every edit passes its own
gate because every edit is genuinely correct; the harm is what accumulates** — and `arXiv:2610.32155` now
says the same of *skills* (13.7% of unsafe chains are made entirely of individually-clean parts).
⭐ **`arXiv:2610.27465` gives two measurables — verifier strength σ and recoverability** — and rules that *"a
change can run unattended only when its **old version is kept** and its **verifier's strength has been
measured**"*, permitting *"prompt, tool and skill edits"* while keeping weight updates under sign-off. **Lead's
reading:** a `self-edit:` is a skill edit on their permitted side, git keeps the pre-edit file verbatim, and
`self-edit-guard.yml` is a deterministic CI check rather than an LLM judge — ⚠️ **but their 17% irreversible
residue argues the envelope's real protection is the pre-merge human review, not revert.**
🔴 **New 2026-11-02, and it names the gap this repo actually has.** `arXiv:2610.34938` ran Claude Code on *"30
SWE-bench Verified issues"*, coded *"125 proposals"* and evaluated 12 harness changes: *"**18 of 43
lint-related proposals recommended a practice regardless of what had happened**"* (✅ **vacuous proposals,
which step 7's repo-internal-evidence requirement already rejects**), and of seven informative evaluations
*"**four showed no reduction**, and some changes **added work on unrelated issues**"*, concluding that
self-evolution *"**needs ways to establish whether a change helps on later tasks and to revise or remove
changes that do not**."* ➜ **`self-edit-guard.yml` enforces scope, protected regions and a per-pass cap; it
does not enforce *removal of an edit that did not help*. That is the next guardrail to build — a human call.**
⚠️ **Same-group caveat: its authors are two of the five on `arXiv:2608.21884`, the §2 headline paper.**
🔴 **And the channel this repo fences is measurably the riskier one:** `arXiv:2610.39122` finds attack success
rising **14.0–48.8 pp under skill evolution** against **3.0–39.3 pp under RL** — **editing a Markdown skill
degraded robustness *more* than updating weights did**, which is a counter-intuitive argument for the
web-sourced-edits-are-human-only rule. ✅ A formal backstop: bounded self-modification *"under a common sound interpreter and fixed
verification protocol remains within the same verification class"* — **a fenced self-edit is provably not an
escape hatch, *provided the gate is genuinely fixed and external*.** SaltBench's lesson applies: *"a probe
written in the sandbox's language cannot see a hole in the layer above it."*


## §5A item 12 — vacuity

**12. 🔴 The failure mode has a name: *vacuity* — a check satisfied by the absence of the thing checked.**
Full per-tool dossier in `sources.md` and
[`archive/primer-detail-2026-10.md`](archive/primer-detail-2026-10.md). `arXiv:2609.27871` names it alongside
**self-attestation**, *"where the subject supplies the value the check is applied to"*, and found **47
vacuous gates in 69 shipped, reviewed loops** (⚠️ its own caveat: *"the apparatus, not our number, is the
contribution"*). Its definition of a bounded loop is this repo's doctrine in three terms: *"a worker, an
independent gate the worker cannot write to, and a declared budget"*, with the budget *"enforced inside an
attempt, not between attempts"* — ⚠️ **and Anthropic has now confirmed its own cap fires *between* requests,
so that third term is unmet first-party (§6).** **Instances keep arriving across every review tool tracked:**
a metered reviewer that **skips the review** at its cap and *"never approves or blocks"*, so **a
correctly-configured hard ceiling can produce an unreviewed merge**; a `success` flag meaning only that a
comment posted; and **a gate that erodes its own surface through use** by deactivating rules whose findings
are rarely fixed. ⭐ **roborev hunts vacuity directly** (*"**Find tests that protect no behavior the repository
owns**… **never asks for more tests**"*). **The rule: exhaustion, timeout and error must degrade to withheld
approval, never to a skipped check.**
❌ **CORRECTED 2026-11-02 — the sharper claim "no reviewer documents what its spend cap does to its merge
gate" is FALSIFIED. Four do, and three are fail-safe.** ✅ **The claim the evidence supports instead: every
reviewer that documents its cap documents it as *not a gate* — none turns exhaustion into an approval, none
into a blocking failure. So the spend cap is reliably safe and reliably useless as a hard stop, which is why
the ceiling must live in the loop harness.** 🔴 **Kodus says so in a product warning, and it is the best
citation this repo will get for its own non-negotiable:** *"**This is a notification, not a cap.**… To
actually stop spend, set a hard limit in your model provider's dashboard — **that's the only thing that can
enforce it.**"*
🔴 **Two vendors ship vacuity as the default, in the same inversion.** **CodeRabbit:** *"If every changed file
is excluded by path filters, CodeRabbit **skips the review content** but still checks the other requirements
and **can approve the pull request**"* — ✅ *"With a risk limit set, it **withholds approval instead, because
the commit has no risk assessment**"*, and ⭐ its one-liner is the cleanest anti-vacuity rule found anywhere,
from a vendor rather than a paper: *"**A configured limit requires an assessment covering the current
commit.**"* **Greptile:** *"**With no cap, the ceiling is Critical** — Greptile can approve any PR with a
clean 5/5 review, **whatever it changes**"*, and the gate reads *"**the 5/5 score**"* **the reviewer assigned
itself** — textbook self-attestation. ⚠️ **Both default auto-approval to the highest risk tier and make the
safe setting opt-in.** 🔴 **And Anthropic Code Review cannot be a hard stop by design:** *"A review **never
approves or blocks** your pull request, and **the check run never concludes as a failure**"* — **a required
status check on it is structurally vacuous** — ✅ though Anthropic writes this repo's rule for its own output:
*"**Treat that as no verdict rather than as zero findings**"*, *"**Read the title before the counts**"*,
*"**Fail the job if you want to gate the merge.**"* ✅ **And the first vendor brake on non-convergence** (a PR
once went *"more than fifty rounds of review"*, **59% of repeat flags on pre-existing code**): *"**Code review
not repeated — earlier findings still open**: to start a new review, **push a fix**"* — **stall detection
inside the reviewer** — ⚠️ though it requires a change, not an improving one. Keep the gate in **your** CI:
"Friendly Fire" hijacked auto-review into RCE.

## §6 "Where ceilings actually exist" — the per-vendor inventory (as of 2026-11-02)

**Where ceilings actually exist — Anthropic.** Per-product quotes in `sources.md`. The **Claude apps gateway**
blocks on daily/weekly/monthly caps and is the only surface with a **daily** ceiling, but **enforcement fails
open by default** (set `enforcement.fail_closed_on_error: true`). The public **Spend Limits API** is
**monthly, Enterprise-only, per member**, ⚠️ **unlimited by default**, with the org-wide default **UI-only**,
and its own docs disown it: `period_to_date_spend` *"**might** read as `"0"` if the spend reading is
temporarily unavailable; treat it as informational, not transactional"* — **so a harness comparing it to a
ceiling reads "nothing spent" during an outage.** **Managed Agents session budgets** are a genuine *"hard
dollar budget"* but in **list** dollars, enforced *"between model requests, not mid-request"*, metering web
searches and **session running time**, with the cap copied onto **each session** so it *"bounds each run
separately rather than the deployment's cumulative spend"* — ✅ **the gateway closed that gap on 2026-10-31
with pooled group budgets (above), the first first-party *cumulative* ceiling.** 🔴 **But Managed Agents'
documented recovery path still destroys the ceiling** (unpriced model → *"Remove the budget to resume"* →
removal is *"one-way"*). **Messages API task budgets** are *"a soft hint, not a hard cap"* and *"not supported
on Claude Code"*. **A budget the model is shown is a pacing hint; a budget the platform checks before the next
request is a ceiling.** ⚠️ **Sharpen the standing negative: observability shipped on 2026-10-29** (the Usage
and Cost Analytics API, read-only, groupable **by API key**) — **enforcement still has not, now five
passes.**

**Where ceilings actually exist — elsewhere.** Per-vendor quotes and status codes in `sources.md`.
- **On five independent gateways and inside a hyperscaler, the real ceiling sits behind a non-default flag** —
  *if you did not explicitly turn enforcement on, assume you have an alert.*
- 🔴 ✅ **The one to recommend is a gateway, not a vendor: Cloudflare AI Gateway enforces *before* dispatch and
  meters per agent.** *"**Before sending a request to the provider**, AI Gateway evaluates all applicable spend
  limit rules at once… **the request is blocked with a `429`**"*, and *"**Split by value**… **splitting by
  `agent_id` gives every agent its own budget**"* (composable with model and provider). Its in-window page
  documents routing Claude Code, Cursor, Gemini CLI, Codex and OpenCode through it. ⚠️ **Its overshoot is
  worse-shaped than Anthropic's** — *"**eventually consistent**… the cost is recorded **after completion**, so
  **a burst of concurrent requests can briefly exceed the limit**"*, i.e. **fan-out is the leak** — and it
  covers only *"models with **known pricing**."*
- **Who else enforces:** **Google Cloud Spend Caps** pause the service (monthly, **one project × one of four
  eligible services**; ⚠️ *"spend cap enforcement isn't instantaneous"*, in-flight requests *"processed to
  completion"*, *"**You remain responsible for any overage costs**"*; ⚠️ the doc **never says GA**, and
  "Vertex AI" is now *Gemini Enterprise Agent Platform*). **AWS** pauses the project (⚠️ up to 10 projects,
  90-day deletion tail, graduated tiers **opt-in and forecast-driven**, Bedrock only in the ~4-day tier, and
  a **$20 minimum** you cannot go under). **OpenAI** enforces at org/project scope; **Azure is an alert**;
  ⚠️ **Bedrock is a meter, not a control**, and names the loop-harness failure outright: *"Amazon Bedrock
  records the gateway's IAM role as the caller's identity."*
- ⚠️ **No model vendor offers a per-API-key spend ceiling**, re-tested **Nov 2** — they scope to *identity*,
  **and a loop harness holds a key, not an identity**, so **METR's *"no way to put a spending limit on keys
  like this one"* stands.** 🔴 **Anthropic's own Spend Limits API is Enterprise-member-scoped and *"not
  available to Claude Platform (Claude Console) organizations"* — the surface that issues API keys has no
  spend-limit API at all** — and it disowns its meter (*"treat it as informational, not transactional"*).
  ✅ **The one hosted per-key ceiling that does exist is OpenRouter's**, with the best-documented lifecycle
  anywhere: `limit_reset` takes *"**daily**, weekly, monthly, or null"*, resetting *"at midnight UTC"*
  — ⚠️ with a BYOK undercount knob (`include_byok_in_limit`).
- ⚠️ **An exhausted budget's durable signal is a header, not a code**: Anthropic sends `429` +
  `x-should-retry: false` + `retry-after`; LiteLLM `422`; OpenRouter `402`/`403`, inconsistently documented.
  **Key a retry wrapper on `x-should-retry`, not a status code** — ⚠️ **a rule Claude Code itself broke
  twice (above).**
- **Two invariants: (a) every real ceiling overshoots by the in-flight requests** — **it bounds new work, not
  the bill** (*"between model requests, not mid-request"*, per-thread; Databricks: *"**Active requests in
  progress when the threshold is reached aren't interrupted**"*); **(b) an unpriceable call must be charged
  high, never zero** (⚠️ **Managed Agents took the weaker option** and simply stops metering, then offers only
  irreversible budget removal). **And vendors disclaim their own ceilings:** Databricks' are *"enforced
  approximately"*, *"**Do not use this feature as a way to ensure an absolute spend cap**"* while its overview
  markets *"hard caps"*; ⚠️ **Agent Router's `serviceQuota` is *"accepted for API consistency… but has no
  effect"*, unenforced in every released version.**
- **In-harness:** ✅ 🔴 **MartinLoop (v0.8.10) is the first external harness to carry all three stops plus a
  verifier — and it decides what this repo never has: *"`wall_clock`, `budget_cap`, and `turn_cap` all outrank
  `goal_met` — governance limits cannot be overridden by a simultaneously verified goal"*, while *"`goal_met`
  outranks `error_threshold` and `no_progress`"* and completing *"on the final permitted iteration is
  legitimate success, not an overrun."* It rejects `--budget-usd 0`.** **AgentGuard** enforces **before
  dispatch** and ships `agentguard hook claude-code`, a drop-in stall detector plus iteration cap; ⚠️ **its
  lesson: a dollar ceiling is only as good as its price table** (a release gate *"fails a release when any
  provider's prices are more than 90 days old"*). ⚠️ **LiteLLM still reads `max_budget = 0` as unlimited in
  all three router paths, and its fix sits on a branch dormant since 2026-10-02.**
