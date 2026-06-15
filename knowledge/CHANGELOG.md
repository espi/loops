# Knowledge base changelog

Dated record of substantive changes to `knowledge/`. The `update-knowledge`
skill appends a new entry here on each research pass. Newest first.

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
