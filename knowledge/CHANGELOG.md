# Knowledge base changelog

Dated record of substantive changes to `knowledge/`. The `update-knowledge`
skill appends a new entry here on each research pass. Newest first.

## 2026-06-09 — Second update pass (five-angle research)

Research pass covering: Claude Code tooling/versions, ecosystem & orchestration,
key voices, guardrails & cost, verification & skills. All findings verified against
primary sources where accessible; Low/Medium items flagged to re-verify.

### New facts added

**Tooling & versions (High, official docs/changelog):**
- **Claude Fable 5** launched June 9, 2026 (v2.1.170): new Mythos-class flagship,
  $10/M input, $50/M output tokens; Boris Cherny: "better self-verification, longer
  running sessions, higher trust & autonomy."
- `--safe-mode` / `CLAUDE_CODE_SAFE_MODE` (v2.1.169): starts Claude Code with all
  customizations disabled.
- `disableBundledSkills` (v2.1.169): hides bundled skills and built-in slash
  commands from the model.
- `--thinking disabled` and multi-fallback models (up to 3, tried in order)
  added in v2.1.166.
- Dynamic Workflows: trigger keyword changed to `"ultracode"` (v2.1.157); `/deep-
  research` bundled workflow added as canonical example with adversarial cross-
  checking across subagents.

**Ecosystem (Medium, primary sources partially blocked):**
- **Gas City** (Apr 24, 2026): Gas Town rewritten as composable Go SDK by Julian
  Knutsen and Chris Sells. Hardcoded roles replaced by declarative packs; Dolt-
  backed versioned audit trail; controller/supervisor convergence loop; "Gastown
  pack" migration path.
- **Codex CLI `/goal`** (GA May 21, 2026): OpenAI independently shipped the same
  validator-model stop-condition pattern. Cross-industry confirmation of the pattern.
- **Loom**: now confirmed as a full Rust monorepo (30+ crates, LLM proxy, web UI);
  proprietary license; no public releases. Previous "repo still experimental"
  description updated.

**Key voices (Medium, primary X/Substack URLs 403'd):**
- Steinberger joined OpenAI February 2026 (predates his loops/skills advocacy).
- Cherny (Jun 9): "Fable is the biggest step up since Opus 4.5."
- Cherny (Sequoia AI Ascent, ~May 2026): "every night I have a few thousand agents
  running"; 150 PRs in one day from phone; cron loops babysit PRs and fix CI.
- Osmani's "Agent Harness Engineering" thesis (Apr 2026): "the model is one input
  into a running agent. The rest is the harness."

**Guardrails & cost:**
- **Billing split CONFIRMED HIGH**: Primary Anthropic Help Center article found.
  Upgraded from Medium. Credits: Pro $20/mo, Max 5× $100/mo, Max 20× $200/mo.
  Interactive terminal use stays on subscription. Removed from re-verify list.
- GitHub Copilot token billing (Jun 1, 2026): developer reports $29→$750/mo.
  (High, GitHub official blog.)
- Goldman Sachs (May 2026): 24× token demand increase projected by 2030. (High.)
- TechCrunch runaway cost roundup (Jun 5, 2026): $6K overnight run, $2,847 four-
  hour runaway, $4,200 long-weekend refactor. (Medium, self-reported.)
- Anthropic Rate Limits API (Apr 25, 2026) and Claude Code Analytics Admin API
  (Mar 2026) available for programmatic spend monitoring. (High, docs.)
- Gartner May 2026: 40% of enterprises will demote/decommission agents post-
  production due to governance gaps; "FinOps for agentic AI" on Hype Cycle;
  guardian agents predicted at 10–15% of market by 2030.

**Verification & skills:**
- **Agent Skills open standard** (Dec 18, 2025): Anthropic open-sourced spec,
  Linux Foundation / AAIF governance; adopted by Codex CLI, GitHub Copilot, Cursor,
  VS Code. Skills now cross-platform portable. (Medium — primary blog 403.)
- Custom commands (`.claude/commands/`) merged into skills.
- roborev now ships installable `$roborev-review` Agent Skill; `--panel N` fans
  review to N independent subagents. (High, GitHub README.)

### Human verification needed
- Agent Skills open standard primary Anthropic URL (blog 403'd)
- Gas City "Gastown pack" migration docs
- Cherny Fable 5 verbatim quote (X post 403'd)
- Codex `/goal` validator model identity (not named in accessible sources)

<!-- update-knowledge appends new dated entries above this line -->

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

Open to verify before promoting: the $500M figure and Loom's "orchestrator"
framing. (Jun-15 billing terms confirmed High this pass — removed from re-verify.)
