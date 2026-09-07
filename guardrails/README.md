# Guardrails

The one rule of this repo: **never run an uncapped loop.** Every loop carries
all three hard stops. A cost *alert* is not *enforcement* — Anthropic's billing
layer has soft alerts and budget thresholds but **does not auto-disable**, so
the ceiling has to live in your loop harness.

## The three hard stops

1. **Max iteration count** — bound the number of turns. Anthropic's Agent SDK
   ships this as `max_turns`; `/ralph-loop` as `--max-iterations`; bash ralph as
   a counter. Default cap: **20**.
2. **No-progress / stall detection** — bail when the loop stops advancing
   (no git diff, repeated identical actions, unchanged test state) for **3**
   consecutive iterations; document blockers instead of looping.
3. **Token / dollar budget ceiling** — a hard enforcement stop. Agent SDK ships
   `max_budget_usd`. In a bash loop, wire a real cost meter and check it
   *before* the next paid call.

Plus, always: **verification inside the loop** — one deterministic check
(test/lint/typecheck) the agent runs itself, declaring done only on pass.

## Containment — the required companion (not a fourth hard stop)

The three hard stops bound what a loop **spends** and **how long it runs**. None
of them bounds **what an attacker-supplied input can make the harness do** — and
in 2026 that gap stopped being theoretical. Containment is therefore a
**required section of every loop's setup**, deliberately *not* numbered as a
fourth hard stop: the three are single, checkable numbers, while containment is
a posture made of several settings. Keeping the list at three preserves its
force; skipping this section is still incomplete.

**Why it's required.** Two mechanisms, both documented in 2026, land *before*
any of the three hard stops or the verification step can run:

- **GitSpawn** (Sep 2026) — a malicious repo's `.git/config` sets
  `core.fsmonitor`, which git executes during the agent's startup `git status`:
  before the workspace-trust prompt, outside the command sandbox, with no
  approval prompt. Triggered by *cloning the target repo*.
- **Instruction privilege escalation** (arXiv:2608.27299, replicated
  independently across 12 harnesses by arXiv:2609.01222) — a harness
  reconstructing context drops provenance and re-labels attacker text that
  arrived as a *file the agent read* into a genuine `user` message. It
  reproduces through `/goal`- and `/schedule`-shaped features, and automatic
  permission review does not stop it.

This repo's model is "loops run *from here* against other repositories," i.e.
**we clone untrusted code by design.** That is exactly the premise both attacks
need. See `knowledge/00-primer.md` §5A.

**The standard to hold** (arXiv:2609.00267): *"a correct system is one in which a
fully prompt-injected agent still cannot exceed the authority explicitly
delegated to it."*

### Containment defaults

- [ ] **Network egress is scoped.** Allowlist the domains the loop actually
      needs rather than granting full access. In Claude Code,
      `sandbox.network.strictAllowlist` denies non-allowlisted hosts without
      prompting. Note that a proxy is not sufficient on its own — agents have
      been observed editing `/etc/hosts` to masquerade blocked domains as
      allowed ones.
- [ ] **No long-lived credentials in the environment.** Assume anything in env
      vars is readable by whatever the loop runs. Isolate SSH keys, cloud
      credentials and the home directory; prefer short-lived tokens.
- [ ] **Unattended runs deny by default.** Use `--permission-prompts none`
      (Claude Code v2.1.259+) on headless hosts: *"anything that would prompt is
      denied automatically while the active permission mode (including auto
      mode) keeps deciding."* It also removes the tools that need a human answer
      (e.g. `AskUserQuestion`), and under `--output-format stream-json` denials
      surface as `permission_denied` messages with a `permission_denials` list
      on the final result — so a harness can *see* what it blocked. This is the
      single cheapest containment win available today.
- [ ] **The blast radius is a container/VM, not a flag.** `--restricted`
      (v2.1.248+) removes command-running tools and confines file tools to the
      working directory — but the primary docs describe it only as tool removal
      and settings scoping, say **nothing** about OS-level isolation, and it is
      **absent from Anthropic's own `sandbox-environments` comparison page**.
      Treat it as a *permission gate, not a sandbox*, and don't rely on it to
      protect secrets. For real isolation use a container, VM, or Claude Code on
      the web's ephemeral VMs.
- [ ] **Review of untrusted code is a privileged operation.** "Have an agent
      review it" is not a free safety check when the reviewer is the attack
      surface (cf. the "Friendly Fire" disclosure, primer §5A).

## Enforce them tool-agnostically (not just in Claude Code)

The three hard stops are a *discipline*, not a Claude Code feature — the same
loop runs on Codex, Goose, an Agent SDK harness, etc. (see primer §4 "Beyond
Claude Code"). Two enforcement locations, both agent-independent:

- **At the gateway** (strongest, covers #1 and #3 for *any* agent behind it):
  route every call through an LLM gateway that caps iterations and spend.
  **LiteLLM** enforces a per-session iteration cap + `max_budget_per_session`,
  returns 429 `budget_exceeded`, and supports `fail_closed_budget_enforcement:
  true` for a real ceiling under degradation. **OpenRouter** rejects over-limit
  requests (HTTP 402) on daily/weekly/monthly windows. **Portkey / Helicone**
  add budgets/guardrails (Helicone skews to alerts — confirm it *blocks*).
- **In the harness** (framework-agnostic libraries): **AgentGuard**
  (`BudgetGuard`/`LoopGuard`/`TimeoutGuard`) and **LoopGain** (convergence early
  stop + rollback; adapters for LangGraph/CrewAI/AutoGen/Claude Agent SDK) ship
  the three stops as a kill-switch you drop into any loop.
- **Native in Claude Code**: a session-wide WebSearch cap (default 200,
  `CLAUDE_CODE_MAX_WEB_SEARCHES_PER_SESSION`, v2.1.212), MCP calls running
  >2 min auto-moved to background, a **concurrent**-subagent cap (default 20,
  `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`) and a subagent **depth** cap (default
  3, `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`). Product-level backstops — they
  complement the three hard stops, they don't replace them (none is a dollar
  ceiling, and the defaults sit far above a sane per-loop cap — set them lower
  explicitly).
  **Corrected 2026-09-07 — do not rely on `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION`.**
  This file previously recommended it as a per-session spawn cap with a default
  of 200. That cap was **removed in v2.1.224 (Aug 7, 2026)** and the variable is
  now gone from the docs entirely; the `sub-agents` page states *"There's no
  limit on the total number of subagents Claude can spawn over a session."* The
  concurrency and depth caps above are the only native subagent backstops left,
  and **neither bounds a session's total lifetime spawns** — so that ceiling is
  yours to enforce. A native backstop being deleted is exactly why the three
  hard stops live in your harness rather than in a vendor default.

Confidence on specific gateway/library flags is **Medium** — verify against live
docs before relying on one (see `knowledge/sources.md`). The principle is firm;
the flag names drift.

## Why this matters (the receipts)

- Uber capped engineers at **$1,500/month per tool** after burning its annual AI
  budget in ~4 months.
- Tesla capped employee AI tool spending at **$200/week** (approval required
  above that) effective July 6, 2026 — the third named company, after Uber and
  Microsoft, enforcing hard per-person ceilings rather than billing alerts.
- A multi-agent system reportedly **looped 11 days and ran up $47K**.
- Every turn re-bills the full accumulated context; a 20-step loop can cost
  ~10x a naive per-step estimate.

See `guardrails/checklist.md` for the preflight, and `budget.env` for the
default thresholds the skills read.
