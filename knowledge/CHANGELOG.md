# Knowledge base changelog

Dated record of substantive changes to `knowledge/`. The `update-knowledge`
skill appends a new entry here on each research pass. Newest first.

## 2026-07-20 — Human verification round, archive introduced, process amendments

Same-day follow-up to the reconciled pass below, prompted by a human
reviewing the three items that pass flagged as needing verification.

### Human verifications

- **`/schedule` is real** — confirmed directly against
  `code.claude.com/docs/en/routines#schedule`. Correction to the earlier
  Medium-confidence secondary-sourced framing: it is **not** a fourth loop
  type distinct from Routines — it's the CLI alias (also `/routines`) for
  creating a Routine. Also newly documented: a Routine now supports three
  trigger types (Schedule, API via a `/fire` endpoint, GitHub event),
  combinable on one routine, with no permission prompts during a run. Primer
  §3–4 and sources.md updated; confidence upgraded to **High** for the
  mechanics (blog post's own byline/view-count claim stays Medium — still
  unconfirmed).
- **Gas City's July release confirmed real**, but misnamed in the prior
  pass: the actual title is **"Gas City 1.3: Now We're Looping With Gas"**
  (blog.gascity.com), not "Formulas 2.0" — that was a secondary-source guess.
  URL confirmed by direct human visit; the specific feature list (convoys,
  drain, Mayor-as-skill, JSON CLI) remains secondary-sourced only since
  automated fetch still 403's. Confidence: **Medium-High**.
- **"Graph engineering"** — human-reviewed: still just warm signals (a
  Steinberger tease tweet + one thin blog post), no primary essay. Stays
  **Low**, carried forward to the next pass rather than resolved.

### Process amendments

- **Standing re-verify backlog**: `update-knowledge` now re-checks every open
  item in `sources.md`'s caveats list at the *start* of each pass (not just
  reports new findings), and the PR must list every still-open item, not only
  what's new. See the skill's new step 2.
- **Archive introduced**: `knowledge/archive/resolved-caveats.md` now holds
  caveats that have resolved, been corrected, or been checked and found not
  worth tracking further, so the live "known caveats" list stays an
  actionable backlog rather than an ever-growing history. Initial archive
  pass moved 6 items: the roborev-creator correction, the Fable 5/Mythos 5
  suspension, Dynamic Workflows Pro-GA (all resolved in earlier passes but
  never archived), the Steinberger/Osmani "Loop Engineering" verbatim
  caveat (resolved when Osmani's O'Reilly Radar mirror turned out to be
  directly accessible), the Gas City v1.3.3/LangGraph 1.2.7 note (checked,
  confirmed non-useful), and the now-superseded "Formulas 2.0" naming.
  `update-knowledge`'s new step 6 makes this pruning a standing part of every
  pass, not a one-off cleanup.
- **Repo mission amendment**: `CLAUDE.md` and `README.md` reframed from
  "my personal loop tooling" to an explicit **central, up-to-date practice
  hub** — the ambition is that any AI agent or human landing here cold can
  pick up loop engineering as a practiced methodology (skills to invoke,
  templates to run, guardrails to apply), not just read about it. The
  standing-backlog and archive disciplines above are part of what keeps that
  ambition true rather than aspirational — a stale or cluttered knowledge
  base can't serve as a practice hub.

## 2026-07-20 — Reconciled pass (Jul 13–20 delta + merge with the unmerged Jul 13 PR)

This pass was kicked off believing the last merge was 2026-07-06 (a 14-day
gap), and ran a full five-agent research pass across July 6–20 on that
assumption. Mid-flight, the PR for the **2026-07-13** pass (below) — open
but unmerged for a week — was merged into `main`, so this branch's PR
conflicted with it. Rather than discard either pass, the two were
reconciled by hand: duplicate findings from the overlapping Jul 6–13 window
were merged into single entries (not double-counted), and only what's
genuinely new since Jul 13 is recorded as new below. Net effect: the two
passes together cover July 6–20 with no gaps and no duplication.

### Reconciled during merge (found by both passes independently — merged, not duplicated)

- Anthropic's own "Getting started with loops" post (Jul 7) and Osmani's "Own
  the Outer Loop" (Jul 9) were each found by both the Jul 13 and Jul 20
  passes with different supporting detail (author names/view count vs.
  `/schedule` detail for the Anthropic post; survey stats vs. the
  cognitive-surrender/debt/orchestration-tax framing for Osmani). Combined
  into single primer/sources entries carrying the union of detail.
- roborev version history (v0.61.3 through v0.63.0) was split across both
  passes' text — consolidated into one version-history bullet in primer §5A
  instead of two overlapping narratives.

### New facts added (genuinely new since the Jul 13 pass, i.e. the Jul 13–20 delta)

- **Claude Code v2.1.208–215 (Jul 14–19)**: opt-in screen-reader mode
  (`--ax-screen-reader`, v2.1.208); `--forward-subagent-text` flag (v2.1.211);
  three new **native runaway-loop caps** — WebSearch cap, subagent-spawn cap,
  MCP auto-background on >2min (v2.1.212) — direct product-level
  reinforcement of this repo's §6 hard stops; `/fork` now spawns a background
  session, old in-session behavior moved to `/subtask` (v2.1.212); new
  `EndConversation` tool + ~58 security fixes including permission-bypass
  closures (v2.1.214); **`/verify` and `/code-review` no longer auto-invoke —
  require explicit calls** (v2.1.215), which directly affects this repo's own
  `verify` and `code-review` skills. **High** (official changelog, read
  directly).

- **Boris Cherny "Steps of AI Adoption"** (~Jul 16–17, 2026): five-level org
  maturity framework (Gated → Assisted → Parallel → Supervised autonomy →
  AI-native); Anthropic org-wide at Step 3, Cherny claims Step 4 personally.
  **High** (verbatim tweet confirmed).

- **roborev v0.62.1–v0.63.0** (Jul 14–16, 2026, beyond the Jul 13 pass's
  v0.61.3–v0.62.0 baseline): persistent CI panel metrics + export command
  (v0.62.1); CI quiet-hours throttling + machine-readable launch receipts for
  automation (v0.63.0). **High** (GitHub releases read directly).

- **Microsoft Agent Skills for .NET reaches stable/GA** (Jul 7, 2026): another
  first-party adopter of the Agent Skills open standard beyond the ~40-product
  figure already in the primer. **High** (Microsoft dev blog).

- **Ramp launched cross-provider AI Token Spend Management** (Jul 16, 2026):
  finance-side dashboard across OpenAI/Anthropic/Gemini token spend; reports
  20.7× YoY token-spend growth across its customer base. New entrant in the
  budget-observability category, complementing the Tesla/Copilot/Codex items
  the Jul 13 pass already added. **High** (multi-outlet + primary blog).

- **Peter Steinberger tweet** (Jul 18, 2026): "Are we still talking loops or
  did we shift to graphs yet?" — paired with a thin secondary
  (datasciencedojo.com) gesturing at "graph engineering" as a possible
  successor term. **Low** — two independent hints, no primary essay; added to
  sources.md re-verify list, not promoted to primer as a real trend.

### Corrected / clarified

- **Anthropic Agent SDK billing split**: confirmed still paused as of Jul 20
  with no revised plan announced (distinct from the Fable 5 metered-billing
  date the Jul 13 pass already tracked, which did move). Flagged and rejected
  a spurious search-summary claim that the billing split itself "went live
  July 10, 2026" — unverified, contradicted by independent June reporting,
  not promoted.

### Not promoted (evidence insufficient or peripheral)

- EvoAgentBench (arXiv:2607.05202) and SkillCheck (getskillcheck.com) — too
  new/thin; added to sources.md only, not primer, consistent with prior
  treatment of standalone academic papers.
- OpenAI's "useful work per dollar" cost-governance guidance (Jul 14) —
  competitor context, added to sources.md only.
- Orca (stablyai/orca) point releases, HN "Show HN" loop-derivative posts
  (Ralphex, LoopFlow), InfoQ billing-lag synthesis piece — dates unconfirmed
  or purely incremental; not promoted.
- Gas City "Formulas 2.0" (~early Jul 2026) — the Jul 13 pass found no Gas
  City update at all ("quiet week"); this pass surfaced the claim via two
  searches with identical detail, but primary blog.gascity.com 403'd both
  times. **Medium**, not promoted to primer, added to sources.md re-verify
  list.

## 2026-07-13 — Seven-day follow-up pass

Research pass covering July 6–13, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.
Primary sources: official Claude Code changelog/Week 28 digest (v2.1.202–207),
Dynamic Workflows docs page, roborev GitHub releases, AI Now Institute; several
claims Medium confidence due to 403s on primary blogs/Substacks/arXiv full text
— corroborated via secondaries.

### New facts added

- **Claude Code v2.1.202–207 (July 6–11, 2026)**: "Dynamic workflow size"
  `/config` setting (advisory cap only — a prompt calling for larger scale
  overrides it); "Large workflow" warning at >25 agents/>1.5M tokens (warning
  only, doesn't pause the run — another alert-vs-enforcement instance);
  `/doctor` upgraded from read-only diagnostic to a full fix-capable checkup
  (aliased `/checkup`), gained a check for trimming `CLAUDE.md` content
  derivable from the codebase; auto mode now blocks session-transcript
  tampering and confirms before `rm -rf` on unresolved variables; auto mode
  turned on by default (no opt-in) on Bedrock/Vertex/Foundry; Agent Teams
  crash-loop fix; default model on Bedrock/Vertex/Foundry changed to Opus 4.8
  (subscription default unchanged, still Sonnet 5). **High** (official
  changelog/Week 28 digest).

- **Dynamic Workflows GA confirmed, confidence upgraded Medium → High**:
  primary docs page confirms GA on all paid plans + API + Bedrock/Vertex/
  Foundry (v2.1.154+). Correction to the prior claim: on Pro it's off by
  default requiring manual `/config` enablement, not an automatic Pro-wide
  turn-on. **High** (primary docs page).

- **Tesla caps employee AI spending at $200/week** (effective July 6, 2026,
  xAI/Grok exempt) — third named company after Uber and Microsoft with a
  hard per-person AI spend ceiling. **High** (multiple outlets).

- **"Friendly Fire" exploit disclosure** (AI Now Institute, July 8, 2026):
  Claude Code auto-mode and Codex CLI auto-review can be hijacked into RCE via
  prompt injection hidden in an ordinary reviewed repo — no hooks/skills/MCP
  needed. Directly undercuts "have an agent review it" as sufficient
  verification; the reviewer becomes the attack surface. Added to primer §5A
  as a caution alongside the existing skills-supply-chain material. **High**
  (multiple independent outlets, primary is the AI Now Institute brief).

- **roborev v0.61.3–v0.62.0** (July 9–11, 2026): git-hook auto-repair on
  daemon startup, `roborev cancel` command, and — directly responsive to the
  Snyk ToxicSkills findings — an explicit human-approval gate before Codex/
  Claude Code can invoke a skill. **High** (GitHub releases read directly).

- **Anthropic's own "Loop engineering: Getting started with loops"** (July 7,
  2026, claude.com/blog) — the Claude Code team's own definitional post on
  the pattern, reportedly 1.2M views on X within a day. **Medium** (primary
  403'd; consistent secondary reporting).

- **Osmani "Own the Outer Loop"** (Substack, July 9, 2026): agents run the
  inner loop (investigate/implement/test/report), engineers own the outer
  loop (verify/verdict/responsibility); cites 96% don't fully trust AI code,
  only 48% always verify before commit. **Medium** (primary 403'd; corroborated
  by independent secondaries).

- **GitHub Copilot cost centers and OpenAI Codex rollout token budgets**
  (early July 2026): both competitors shipped harness-level spend-enforcement
  features (capped/shared credit pools, per-session limits; configurable
  token budgets with turn-abort on exhaustion) — reinforces that enforcement,
  not alerting, is becoming the industry-standard shape of a budget ceiling.
  **Medium** (changelog-confirmed, exact dates within window imprecise).

- **"The Harness Effect" arXiv paper** (arXiv:2607.06906, ~July 6, 2026):
  controlled six-model study — an optimized orchestration harness cuts
  cost/task 41%, wall-clock 44%, tokens/task 38%, raises quality-per-dollar
  82%; efficiency gains model-invariant, quality gains scale with model
  strength. Supports the primer's harness-not-just-prompt framing. **Medium-
  High** (primary arXiv abstract identified; full-text fetch blocked).

- **Fable 5 metered-billing deadline moved twice** (July 7 → 12 → 19, 2026)
  after user pushback on the original cutover date. **Medium-High** (Anthropic's
  own "Redeploying Fable 5" post, corroborated).

### Not promoted (evidence insufficient or peripheral)

- "Loop Engineering Is Dead" backlash piece (Medium, reported within the
  window) — opinion piece, no primary data cited, exact date unconfirmed;
  added to sources.md re-verify list as an early backlash signal.
- GitHub Copilot CLI 1.0.70 (GPT-5.6 support, July 9) — competitor model
  availability, not a new loop pattern; noted in sources.md only.
- SkillCoach (arXiv:2607.01874, Jul 2) and "When Agents Do Not Stop"
  (arXiv:2607.01641, ~Jul 1–2) — both submitted just before the research
  window; flagged in sources.md to read fully next pass.
- No update found to the paused Agent SDK billing split (distinct from the
  Fable 5 metered-billing date, which did move).
- Gas Town/Gas City and Loom (Huntley) — no updates found in-window; quiet
  week for ecosystem orchestration news generally.

## 2026-07-06 — Seven-day follow-up pass

Research pass covering June 29–July 6, 2026. Five parallel agents across:
tooling & versions, ecosystem, key voices, guardrails & cost, verification &
skills. Primary sources: official Claude Code changelog (v2.1.197–201),
roborev GitHub releases; several claims Medium-confidence due to 403s on
primary blogs (Anthropic, Substack, Gartner) — corroborated via secondaries.

### New facts added

- **Claude Sonnet 5 becomes Claude Code's default model** (v2.1.197, June 30,
  2026): native 1M-token context, promotional pricing $2/$10 per MTok
  input/output through August 31, 2026. **High** (official changelog).

- **Claude Code v2.1.198 (July 1)**: subagents now run in the background by
  default; background agents launched via `claude agents` auto-commit, push,
  and open a draft PR on finishing worktree work instead of stopping to ask
  first; Explore agent inherits the session's model (capped at Opus) instead
  of always using Haiku; `/agents` wizard removed; Claude in Chrome reaches
  GA; `/dataviz` skill added. **High** (official changelog). Flagged in the
  primer as a real autonomy increase worth weighing against this repo's
  confirm-before-hard-to-reverse-actions default.

- **Claude Code v2.1.199 (July 2)**: subagents cut off by rate limits or
  server errors now return partial work instead of silently misreporting
  success — closes a gap where a loop harness could log a false "done" on a
  truncated subagent run. `CLAUDE_CODE_RETRY_WATCHDOG` raises the default
  retry count to 300 and removes the previous 15-retry cap on
  `CLAUDE_CODE_MAX_RETRIES`. Stacked slash-skill invocations now load up to 5
  leading skills. **High** (official changelog).

- **Claude Code v2.1.200 (July 3)**: `AskUserQuestion` dialogs no longer
  auto-continue by default (opt-in idle timeout via `/config`) — a loop can no
  longer silently sail past a question it raised. Default permission mode
  renamed "Manual" (previously `default`). **High** (official changelog).

- **Dynamic Workflows reported at Pro-plan GA** (~July 2, 2026): off by default
  on Pro (enable via `/config`), on by default for Max/Team, off by default
  for Enterprise (admin-enabled). **Medium** (consistent secondaries; no
  primary changelog line identified — flagged to re-verify).

- **Anthropic Claude Enterprise spend controls** (July 2, 2026): model-level
  entitlements, spend-threshold alerts at 75%/90% of an org's limit, per-user/
  per-group cost analytics dashboard, Admin API endpoints for cost-control
  scripting. First Anthropic-native building block toward a product-level
  budget ceiling, complementing the harness-level ceiling in primer §6.
  **Medium-High** (Anthropic's own blog, corroborated by two secondaries;
  primary blog fetch 403'd).

- **Gartner: $234B of enterprise app spend "at risk" from agentic AI by 2030**
  (July 1, 2026 press release) — ~20% of enterprise app SaaS spend exposed to
  "agentic arbitrage." **Medium** (title/date confirmed via search; primary
  newsroom page 403'd).

- **roborev v0.61.0–v0.61.2** (June 30–July 4, 2026): export support for
  completed reviews, a "lookahead" review type for detecting time-series bias,
  Factory Droid hook/skill support, per-analysis agent configuration,
  configurable post-commit hook timeouts, incremental export cursors. **High**
  (GitHub releases read directly).

- **Addy Osmani "Agentic Autonomy Levels"** (July 3, 2026): follow-on to
  "Agentic Code Review" — autonomy granted to an agent should be earned by
  accumulated verification evidence, not asserted by a task label. **Medium**
  (search-snippet corroborated; primary Substack fetch blocked).

### Not promoted (evidence insufficient or peripheral)

- AI Engineer World's Fair 2026 (Jun 29–Jul 2) sessions by Steve Yegge and
  reportedly Addy Osmani — no verbatim quotes recovered, aggregator-sourced
  only; added to sources.md re-verify list.
- Cobus Greyling "HarnessX" essay (reported Jul 2026) — existence corroborated
  by search but not directly fetched; added to sources.md re-verify list.
- Gas City v1.3.3 hotfix and LangGraph 1.2.7 — routine maintenance releases,
  not new orchestration techniques.
- No update found to the paused Agent SDK billing split; no new runaway-cost
  incidents or Copilot pricing changes this window.

## 2026-06-29 — Seven-day follow-up pass

Research pass covering June 22–29, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.
Primary sources: official GitHub releases (v2.1.191/193/195), Anthropic blog,
TechCrunch, O'Reilly Radar, Snyk.

### New facts added

- **Claude Code v2.1.191 (June 24)**: `/rewind` command resumes a conversation
  from the state before the last `/clear`. CPU usage during streaming cut ~37%
  via text-update coalescing to 100ms. MCP OAuth in headless environments skips
  the browser popup and presents a paste-the-URL prompt directly. Sandbox
  network host approvals now remembered for the session. **High** (official
  GitHub releases).

- **Claude Code v2.1.193 (June 25)**: `autoMode.classifyAllShell` setting
  routes all Bash/PowerShell commands through the auto-mode classifier (not
  just those the agent auto-approved). Auto-mode denial reasons now appear in
  the transcript, denial toast, and `/permissions` UI — directly useful for
  diagnosing loops that stall on auto-mode blocks. Live file-path autocomplete
  in bash mode (`!`-triggered). `claude_code.assistant_response` OpenTelemetry
  log event with redaction controls added. **High** (official GitHub releases).

- **Claude Code v2.1.195 (June 26)**: Hook matcher fix for hyphenated MCP
  server names (e.g., `mcp__brave-search`) — previously could accidentally
  substring-match sibling tools; now exact-match only. `CLAUDE_CODE_DISABLE_MOUSE_CLICKS`
  env var disables mouse interactions while keeping scroll. Voice dictation
  fixes for languages without spaces (Japanese, Chinese, Thai) and macOS
  silence-capture bug after input device changes. **High** (official GitHub
  releases).

- **Permission tool-name globs in deny/ask rules**: Official docs now cover
  tool-name glob patterns in deny and ask rules — `mcp__*` blocks all MCP
  tools; `Agent(model:opus)` and `Bash(run_in_background:true)` use the
  existing `Tool(param:value)` syntax. Allow rules accept globs only after a
  literal `mcp__<server>__` prefix; unanchored allow globs are rejected with
  a warning. **High** (official permissions docs).

- **Claude Code Artifacts beta (June 18, 2026)** — missed from previous KB
  pass: Claude Code can now produce interactive single-page HTML artifacts
  (≤16 MiB rendered) from session work. Available to Team and Enterprise
  subscribers. **High** (official Anthropic blog).

- **Boris Cherny at Meta @Scale (June 22, 2026)**: First major conference
  appearance positioning loops as a fundamental platform transition: *"Two
  years ago, we wrote source code by hand. We started to transition so agents
  write the code. And now we're transitioning to the point where agents are
  prompting agents that then write the code."* And: *"As big as the step from
  source code to agents was, loops are just as important and as big a step."*
  Production example given: architecture-improvement and abstraction-deduplication
  agents running as **permanent background loops** that submit PRs continuously
  without a completion condition. **High** (TechCrunch direct reporting).

- **Addy Osmani "Loop Engineering" on O'Reilly Radar (June 22, 2026)**:
  Formal crystallization of the term for a mainstream technical audience. His
  definition of a loop turn as five moves: **discovery** (find the work),
  **handoff** (pass context to the agent), **verification** (confirm done),
  **persistence** (write back to durable state), and **scheduling** (decide
  when to run again). **High** (O'Reilly Radar primary; Osmani Substack
  mirror).

- **Snyk ToxicSkills report (June 23, 2026)**: Audit of 3,984+ public Agent
  Skills found prompt injection vulnerabilities in **36%** and critical-level
  issues (malware distribution, exposed secrets) in **13.4%**. Directly
  relevant to loops that import third-party skills from public registries.
  **High** (Snyk primary report).

### Not promoted (evidence insufficient or peripheral)

- Praxen open-source agent behavior verification tool (June 24) — too new to
  assess maturity; added to sources.md under Verification.
- Anthropic-Alibaba allegation (June 24, Bloomberg) — governance context, not
  loop engineering patterns.
- The Register "loop engineering still needs humans in the loop" (June 24) —
  editorial; no new technical claim.
- Gas Town v1.2.1 / gastownhall GitHub org — version date uncertain relative
  to June 22 baseline; not promoted.

## 2026-06-22 — PR triage: salvage from the orphaned 06-09 second pass

Resolved two open PRs so the repo best represents the research they held.

- **PR #3** (2026-06-22 pass) **merged** — current and built on `main`; carries
  the critical billing-split-paused correction.
- **PR #1** ("second update pass", opened 2026-06-09 from a stale base) **closed
  without merging** — superseded by the later 06-15 pass (PR #2, merged) and the
  06-22 pass. Merging it would have regressed dates and reintroduced two claims
  later corrected: the billing split as "confirmed/effective Jun 15" (actually
  *paused*) and roborev's author as "Dan Kornas" (actually **Wes McKinney**).

Before closing PR #1, the unique, still-valid research it contained — absent
from both later passes — was salvaged into the KB:

- **Cost/guardrails** (sources.md §Guardrails & cost + primer §5B): GitHub
  Copilot token billing ($29→$750, Jun 1); Goldman Sachs 24× token demand by
  2030; TechCrunch runaway roundup ($6K/$2,847/$4,200, Jun 5); Anthropic **Rate
  Limits API** (Apr 25) and **Claude Code Analytics Admin API** (Mar 2026) as
  programmatic spend-enforcement hooks (also added to primer §6); Gartner
  governance press release (40% demote/decommission by 2027, "FinOps for agentic
  AI", guardian agents 10–15% by 2030).
- **Verification & skills**: the **Agent Skills open standard** (Dec 18, 2025,
  Linux Foundation / AAIF; cross-platform adopters; commands merged into skills)
  — primer §4 + sources.md; roborev `$roborev-review` installable skill and
  `--panel N` multi-reviewer fan-out added to the existing roborev entry.
- **Ecosystem / voices**: Codex `/goal` GA (May 21) noted as cross-industry
  confirmation of the validator-model pattern; Steinberger joined OpenAI (Feb
  2026) context note.

Deliberately *not* salvaged: anything already in `main`, and PR #1's two
later-corrected claims above.

## 2026-06-22 — Seven-day follow-up pass

Research pass covering June 15–22, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.
Primary source for Claude Code: changelog read directly at code.claude.com.

### Critical correction

- **Anthropic billing split PAUSED** (June 15, 2026): The primer previously said
  the billing split was "effective June 15, 2026." Anthropic reversed course on
  the effective date itself — billing for Agent SDK, `claude -p`, and GitHub
  Actions remains on existing subscription limits until further notice. The
  credit-pool architecture (hard stop on exhaustion) remains the structure to
  watch. **High** (multiple independent outlets). Primer corrected; sources.md
  updated.

### New facts added

- **Foreground subagents now also capped at 5 levels** (v2.1.181, Jun 17, 2026):
  Previously only background chains were depth-limited. Foreground chains now
  also respect the 5-level cap. **High** (official changelog).

- **Agent Teams now implicit** (v2.1.178, Jun 15, 2026): `TeamCreate`/`TeamDelete`
  tools removed; every session with `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` now
  has one implicit team. Spawn teammates via `Agent(name:...)`. **High**.

- **`Tool(param:value)` permission rule syntax** (v2.1.178, Jun 15, 2026): match
  a tool's input parameters with `*` wildcards in permission rules — e.g.,
  `Agent(model:opus)` to block Opus subagents. **High**.

- **Nested `.claude/skills/` directories** now load automatically (v2.1.178).
  Name clashes appear as `<dir>:<name>`. **High**.

- **`/config key=value`** prompt syntax (v2.1.181) sets any config key inline in
  any mode. **High**.

- **Auto mode safety hardening** (v2.1.183, Jun 19, 2026): destructive git
  commands (`git reset --hard`, `git checkout -- .`, `git clean -fd`,
  `git stash drop`, `git commit --amend` on non-agent commits) and IaC destroy
  commands are blocked by default unless explicitly requested. **High**.

- **Claude Fable 5 reinstatement**: suspension (Jun 12–13) was short-lived;
  platform docs confirm Fable 5 available as of Jun 22. **Claude Mythos 5**
  available via Project Glasswing (limited). **Claude Opus 4.1 deprecated**,
  retiring August 5, 2026. **High** (platform docs read directly).

- **Osmani "Agentic Code Review"** (June 16, 2026): four-dataset empirical
  analysis — AI adoption quadruples code volume but ~12% real productivity gain;
  defect rates 9%→54%; review times +441%; zero-review merges +31%. Directly
  quantifies the verification bottleneck thesis. **Medium** (primary URLs 403'd;
  consistent across multiple aggregators).

- **Microsoft dropping Claude Code** (Experiences & Devices division, effective
  June 30, 2026): per-engineer costs $500–$2,000/month drove the cancellation;
  engineers redirected to Copilot CLI. **Medium** (multiple tech outlets).

- **Databricks Unity AI Gateway hard spend caps** (announced Jun 15–18, 2026
  Data+AI Summit): hard enforcement stops requests at budget limit, not just
  alerts; granular by user/team/tool. **Medium-High**.

### Confidence upgrades

- **Fable 5 / Mythos 5 suspension** removed from "to re-verify" — resolved.
- **Billing split**: "to re-verify" entry updated to reflect pause; watch for
  revised plan announcement.

### Not promoted (evidence insufficient or out of scope)

- Yegge "The Flat Curve Society" (~Jun 19) — about model capability plateau,
  not loop patterns. Added to sources.md as context; not in primer.
- Loop Engineering Orange Book (alchaincyf, Jun 15 GitHub) — community guide,
  not primary source; noted in sources.md only.
- LangChain "Art of Loop Engineering" (Jun 16) — Medium confidence, no primary
  fetch; ecosystem signal only.
- arXiv skill-evaluation papers (Jun 6–9 submission) — academic, not yet
  operational; added to sources.md under Verification.
- SDK TaskUpdatedMessage typed events (0.2.101) — too implementation-specific
  for primer; noted in changelog entry only.

## 2026-06-15 — Six-day follow-up pass

Research pass covering June 9–15, 2026. Five parallel agents across: tooling &
versions, ecosystem, key voices, guardrails & cost, verification & skills.

### New facts added

- **5-level nested sub-agents** (v2.1.172, Jun 10, 2026): Sub-agents can
  now spawn their own sub-agents up to five levels deep — first structural
  change to the orchestration model since Dynamic Workflows shipped. Cost
  compounds geometrically with depth. **High** (official changelog).

- **Dynamic Workflows trigger renamed to `ultracode`** (v2.1.160, Jun 2;
  previously undocumented in KB): the keyword that triggers a workflow run
  changed from `workflow` to `ultracode`. **Medium** (multiple secondaries).

- **Hook `if` path-pattern fix** (v2.1.176, Jun 12): patterns like
  `Edit(src/**)`, `Read(~/.ssh/**)`, `Read(.env)` now match correctly —
  directly relevant to targeted guardrail hooks. **High** (official changelog).

- **Claude Fable 5** (`claude-fable-5`; 1M context, $10/$50 per MTok I/O)
  launched Jun 9 in v2.1.170, then **suspended globally Jun 12–13** following
  a US government export-control directive. Mythos 5 also suspended; all other
  models unaffected. **High** launch (official docs); **Medium** suspension
  (consistent secondaries; no primary Anthropic notice read directly).

- **`security-guidance` plugin** (Anthropic, Week 22, May 29, 2026; missing
  from previous KB pass): three-tier review-in-the-loop embedded in Claude Code
  — fast pattern scan per edit → model review per turn → deeper agentic review
  on commit or push. **High** (official Week 22 docs).

- **`--safe-mode` / `CLAUDE_CODE_SAFE_MODE=1`** (v2.1.169, Jun 8): disables all
  customizations for debugging. **`fallbackModel`** setting (v2.1.166+) chains
  up to three fallback models on overload/error. **High** / **Medium**.

- **Gas City** (Yegge, Apr 25, 2026; missing from previous KB pass): Gas Town
  rewritten as an SDK for building arbitrary orchestrators (MEOW stack, composable
  "packs"). Added to Yegge entry in §3 and sources.md. **Medium**.

- **Roborev v0.57.1** (Jun 9) and **v0.58.0** (Jun 11): new releases add Kata
  integration, queue pause/resume, and aggregate review cost tracking. **High**
  (GitHub releases read directly).

### Confidence upgrades

- **June 15 billing split** promoted from **Medium → High**: Anthropic Help
  Center article `support.claude.com/articles/15036540` confirmed; announcement
  email May 13, 2026; canonical gist + 15+ independent outlets with identical
  specifics. Credit amounts now documented: Pro ~$20/mo, Max 5× ~$100/mo,
  Max 20× ~$200/mo, Team/Enterprise ~$100–$200/seat. Credit pool functions as
  a de-facto hard stop (requests halt on exhaustion unless overflow enabled).
  Removed from "to re-verify"; primary URL noted as 403'd to automated fetch.

### Key-voice quotes added

- Cherny (Fortune, Jun 11): *"I haven't written a line of code by hand in...
  eight months now."* **High**.
- Cherny (Jun 2026): *"I'm not doing the prompting — I create the routines that
  do the prompting."* **Medium**.
- Osmani (Substack, Jun 9): *"verification, not generation, is the next
  development bottleneck."* **Medium** (primary URL 403'd).

### Added to re-verify

- **Roborev creator**: KB said Dan Kornas; research attributes to Wes McKinney
  (@wesmckinn). Re-verify before citing.
- **Fable 5 suspension**: no primary Anthropic URL confirmed.

### Post-PR corrections (Jun 15, human-verified)

- **Roborev creator**: confirmed **Wes McKinney** (@wesmckinn). Previous
  attribution to Dan Kornas (a content creator) was wrong. Corrected in
  sources.md; re-verify entry updated.
- **Fable 5 suspension**: primary Anthropic notice confirmed at
  `anthropic.com/news/fable-mythos-access` (403'd to automated fetch; URL
  verified by user). Suspension confidence upgraded to **High**.

### Not promoted (evidence insufficient)

- Stack Overflow for Agents (Jun 10 beta) — Medium, too peripheral to core loop
  engineering to warrant primer space.
- SkillClaw / SkillFlow arXiv papers — Medium; academic, not yet operational.
- Microsoft dropping Claude Code — Low (single newsletter).

## 2026-06-09 — Initial knowledge base

Seeded from a five-angle deep-research pass triggered by Matt Van Horn's
"WTF Is a Loop? Peter Steinberger vs. Boris Cherny" article.

- Established the primer: definition, lineage (ReAct → AutoGPT → ralph → `/goal`
  → orchestration), key voices, Claude Code mechanics, verification, cost, and
  the three hard stops.
- Curated `sources.md` with confidence levels.
- Corrections captured vs. the source article: the "$297 programming language"
  conflates a YC hackathon datapoint with the separate CURSED project; Gas Town
  patrol loops are run by the Deacon/watchdog tier, not the Mayor.

## 2026-06-09 — First update pass (validation run)

Bounded `update-knowledge` run (baseline was same-day seed): one agent verified
the version-sensitive facts against live docs; one scanned for anything newer
than the seed. All six version facts **confirmed unchanged**. New material added:

- **Dynamic Workflows** (`/workflows`, research preview) — native Claude Code
  orchestration with runtime-enforced caps (16 concurrent, 1,000 agents/workflow,
  token budget). Added to lineage §2 and mechanics §4. **High** (official docs).
- **Anthropic billing split (~Jun 15 2026)** — programmatic entry points move to
  a separate metered credit pool at API list prices; re-prices unattended loops.
  Added to cost §5. **Medium** (secondary incl. Axios; flagged to re-verify).
- Refinements (**High**, docs): Routines marked *research preview*; ralph
  `--max-iterations` *defaults to unlimited* (reinforces the cap rule); `/usage`
  spend breakdown by subagent/skill noted for observability.
- Added, caveated: Huntley's **Loom** (ralph-orchestration evolution; repo more
  modest than talk framing), the **"Loop Engineering"** coinage (Osmani), and a
  reported **$500M uncapped-usage** incident (unnamed — figure unverified).

Open to verify before promoting: the Jun-15 billing terms (primary Anthropic
notice), the $500M figure, and Loom's "orchestrator" framing.

<!-- update-knowledge appends new dated entries above this line -->
