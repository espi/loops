# Knowledge base changelog

Dated record of substantive changes to `knowledge/`. The `update-knowledge`
skill appends a new entry here on each research pass. Newest first.

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
