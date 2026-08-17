# Archive: resolved caveats

Items move here from `sources.md`'s "Known caveats / things to re-verify"
list once they're resolved, confirmed non-useful, or superseded — so the live
caveats list stays a lean, *actionable* backlog instead of an
ever-growing history. Nothing here needs further action; it's provenance,
not a to-do list.

Each entry keeps the resolution date and a one-line reason it was archived
rather than carried forward.

## Archived 2026-08-17

- **Agent Plugins 1.0 spec not read directly — resolved.** Opened 2026-08-10 when
  the Aug-6 standard was confirmed only via a secondary quoting the spec + AAIF
  post. This pass read the primary spec repo (`agentplugins/agent-plugins-spec`)
  first-hand: `spec/1.0.0.md` §5.2 confirms the closed root manifest permits exactly
  10 top-level fields with `$schema` + `name` required; MAINTAINERS.md confirms the
  five founding Core Maintainers (Amazon / Cursor-Anysphere / Microsoft / OpenAI /
  Vercel-as-Lead, Jonathan Hefner) and GOVERNANCE.md's no-single-vendor-majority
  charter; Google joined day-of per GitHub's blog. sources.md upgraded to High. (One
  minor residual: the roster read still lists only the five, not a Google seat —
  noted inline, not a standing caveat.) No further action.
- **"Loop Engineering Is Dead: Here's the Data Behind the AI Backlash" — resolved.**
  Open since the Jul 13 pass as a possible early-backlash signal. Read directly this
  pass: the Medium piece (AI Engineering Simplified, dated **Jul 4, 2026**) cites
  **no** benchmarks, cost figures, or survey data — its only concrete claim (Uber's
  budget) is unsourced. It's narrative, not a documented trend. The genuine
  empirical anchor for the "code erosion as agents iterate" critique is
  **SlopCodeBench** (arXiv:2603.24755, ~Mar 2026: erosion in ~80% of trajectories,
  no agent solving any problem end-to-end across 11 models), now recorded in
  sources.md's academic section as the thing to cite instead. No further action.

## Archived 2026-08-10

- **"Graph engineering" primary definition — resolved.** The long-tracked "the
  meme is heating but has no primary long-form definition" caveat is closed: the
  earliest-documented use lead (Josh Simmons, Jul 4) checks out as a genuine
  *definitional* essay — Josh C. Simmons, "We Are Entering the Graph Engineering
  Phase" (drjoshcsimmons.com, Jul 4, 2026), read directly this pass: *"graph
  engineering is designing agentic systems as explicit graphs instead of implicit
  loops"*, framing it as *demoting* the loop, not killing it (*"The loop is not
  dead. It got demoted"*). Reinforced in-window by Steve Yegge's Aug 4 essay
  (*"any sufficiently large project is a graph"*). Recorded in primer §2 as the
  orchestration-loop rung at higher altitude, **not** a new lineage stage — and
  its status as a *successor* to loop engineering remains contested (Turing Post:
  "a loop is already a graph"), which is a framing debate, not an open
  verification item. No further action.

## Archived 2026-08-03

- **Subagent-nesting default — resolved to depth-3.** After the twice-flipped
  week (v2.1.217 Jul 21 disabled nesting → v2.1.219 Jul 24 reinstated at
  depth-3), the default held steady: subagents may spawn nested subagents up to
  **depth 3**, disabled via `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH=1`. v2.1.220
  (Jul 25) didn't touch it and no newer release exists as of Aug 3. Confirmed
  against the primary changelog. No further action.
- **roborev repo identity — resolved to `kenn-io/roborev`.** The KB tracked
  `roborev-dev/roborev`; that path now redirects to `kenn-io/roborev` (Go,
  canonical, last pushed Aug 2), so treat it as a rename/move. sources.md
  citations updated. No further action (Medium on the exact rename date/mechanism,
  which no dated notice confirmed).
- **AgentGuard + LoopGain re-findability — resolved.** Both repos confirmed
  live at their cited URLs: `github.com/bmdhodl/agent47` (AgentGuard — still
  documents BudgetGuard `max_cost_usd`, LoopGuard `max_repeats`, FuzzyLoopGuard,
  Retry/Timeout/RateLimit guards) and `github.com/loopgain-ai/loopgain` (LoopGain
  — still documents `max_iterations` default-50 backstop, convergence classifier,
  adapters incl. Claude Agent SDK). The Jul-27 search miss was not disproof; both
  exist. No further action.
- **Gateway ownership changes — resolved.** Portkey acquired by Palo Alto
  Networks (closed May 29, 2026, folding into Prisma AIRS; routing/rate-limiting/
  policy enforcement retained) and Helicone acquired by Mintlify (~Mar 2026, now
  in **maintenance mode** — patches/new-model support only, no new feature dev,
  customers being migrated off). Primer §6 updated to flag Helicone as sunsetting.
  No further action.
- **Cobus Greyling "HarnessX" — resolved.** The Substack post is now fetchable
  and dated **Jul 1, 2026** (pre-window); it is Greyling's *commentary on*
  **arXiv:2606.14249 "HarnessX: A Composable, Adaptive, and Evolvable Agent
  Harness Foundry"** (harness as a first-class versioned artifact that evolves
  from execution traces; +14.5% avg, up to +44%), not his own framework. Existence
  and date confirmed; not promoted to primer (peripheral). No further action.
- **Cherny "5 tips for running agents autonomously" — resolved.** It IS a real
  Cherny numbered-list tweet (Jun 8, 2026): "Five tips for running Opus
  autonomously for hours/days: 1. auto mode for permissions … 2. dynamic
  workflows …" plus /goal-or-/loop, sub-agent orchestration, run in cloud. The
  prior caveat ("real in substance but not published as a numbered list") is
  corrected. Medium-High (verbatim search snippet; x.com not directly fetchable,
  tweet ID decodes to Jun 8). No further action.
- **GuardFall — resolved (corroborated + figure corrected).** Was single-
  aggregator/unverified. Now: primary is Adversa AI (published **Jun 30, 2026**,
  researcher Omer Ben Simon), amplified by The Hacker News / SC Media / Security
  Affairs; the "July 2026" attribution came from Adversa's July roundup, not the
  disclosure date. **No CVE by design** (structural shell-expansion flaw, not a
  patchable component). The ">500k deployments" figure is a **misread of "~548k
  combined GitHub stars"** across the 10 affected tools. Now a proper sources.md
  entry under Guardrails & cost. No further action.
- **Agent Skills governance — resolved to "not AAIF-governed."** Multiple
  independent confirmations now: the Linux Foundation's Agentic AI Foundation
  founding-project list names only **MCP / `AGENTS.md` / goose**; Agent Skills /
  `SKILL.md` is Anthropic-authored and community-maintained (agentskills.io),
  outside LF governance. Primer §4 states this directly. Portability therefore
  rests on vendor goodwill, not a neutral standard. (The narrower *execution*
  question — which tools actually run a `SKILL.md` — stays open in sources.md.)
  No further action.

## Archived 2026-07-27

- **SkillCoach (arXiv:2607.01874) and "When Agents Do Not Stop"
  (arXiv:2607.01641) — both read in full.** Flagged across the Jul 13 and Jul
  20 passes as "not yet read." Both abstracts were read directly this pass and
  promoted to sources.md's academic section with their actual findings
  (SkillCoach: process rubrics complement a deterministic check; "When Agents
  Do Not Stop": IAL-Scan static analysis, 91.9% precision, empirical support
  for the max-iteration/stall hard stops — now cited in primer §6). No further
  action.
- **Fable 5 metered-billing deadline — resolved.** Tracked in primer §4 as a
  "live-moving deadline" after three slips (Jul 7 → 12 → 19). Metered billing
  **went live July 20, 2026 as planned**: Max & Team Premium keep Fable 5
  included up to 50% of the weekly usage limit (stated permanent), Pro & Team
  Standard move to usage credits at $10/$50 per MTok with a one-time $100
  credit (Jul 20–Aug 2). Primer prose updated from "not settled" to the settled
  outcome; the moving-deadline history lives in the CHANGELOG. No further
  action.

## Archived 2026-07-20

- **Roborev creator confirmed**: Wes McKinney (@wesmckinn, author of Pandas).
  Previous KB said Dan Kornas (a content creator, not the author). Corrected
  in the 2026-06-15 pass; no further action needed.
- **Fable 5 / Mythos 5 suspension resolved**: suspension (Jun 12–13, 2026) was
  short-lived; platform docs confirmed both models available as of Jun 22.
  Opus 4.1 deprecation (retiring Aug 5, 2026) confirmed via docs. Resolved in
  the 2026-06-22 pass.
- **Dynamic Workflows Pro-plan GA**: was Medium confidence (secondary-source
  only) as of the 2026-07-06 pass; the 2026-07-13 pass confirmed GA directly
  against the primary docs page (upgraded to High). See primer §4.
- **Steinberger / Osmani "Loop Engineering" verbatim**: flagged unconfirmed
  (primary X/Substack 403'd) as of the 2026-06-15 pass. The 2026-06-22 pass
  found Osmani's O'Reilly Radar mirror of the same essay directly accessible
  — primary sources now confirmed, quotes verified. See sources.md Key
  voices.
- **Gas City v1.3.3 hotfix (Jul 2, 2026) and LangGraph 1.2.7 (Jun 30,
  2026)**: reviewed and explicitly determined to be routine maintenance
  releases, not new orchestration techniques worth tracking. Archived as
  "checked, confirmed non-useful" rather than carried forward as an open
  question.
- **Gas City "Formulas 2.0"**: this was a secondary-source-only guess at the
  release name (Medium confidence, primary blog 403'd) as of the 2026-07-13
  pass. Human verification on 2026-07-20 confirmed the real release and its
  title: **Gas City 1.3** ("Now We're Looping With Gas",
  https://blog.gascity.com/posts/gas-city-1-3-now-were-looping-with-gas/).
  The corrected entry now lives in sources.md's Key voices section; this
  archive entry exists only so the "Formulas 2.0" name doesn't resurface as
  if it were still an open question.
- **Anthropic's loops-taxonomy post — is `/schedule` real?**: flagged
  unconfirmed across the 2026-07-06 and 2026-07-13 passes (primary blog
  403'd both times). Human verification on 2026-07-20 confirmed `/schedule`
  directly against `code.claude.com/docs/en/routines` — it's real, but it's
  the CLI alias for creating a **Routine** (also aliased `/routines`), not a
  separate fourth loop type as the secondary sources framed it. The blog
  post's own byline/view-count claims remain unconfirmed and stay in
  sources.md at Medium confidence, but the actionable technical question
  (does `/schedule` exist, what does it do) is resolved. See primer §3–4.
