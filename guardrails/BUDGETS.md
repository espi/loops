# Budgets

Owned by the human; the routines never edit this file. Every file a routine writes has a cap here, in words. At a cap, a new entry deletes an old one: git is the archive. A path over its cap may not grow, and a routine pass that touches it must leave it smaller (`scripts/kb_budget.py --base origin/main`, run by CI).

| path | cap | unit |
|---|---|---|
| `README.md` | 600 | words |
| `CLAUDE.md` | 900 | words |
| `knowledge/00-primer.md` | 8,000 | words |
| `knowledge/sources.md` | 30,000 | words |
| `knowledge/sources.md#Known caveats` | 25 | items |
| `knowledge/CHANGELOG.md` | 5,000 | words |
| `knowledge/archive` | 0 | words total |
| `knowledge` | 45,000 | words total |
| `.claude/skills/update-knowledge/SKILL.md` | 1,800 | words |
| `.claude/skills/artifact-audit/SKILL.md` | 900 | words |

A pull request body is capped at 600 words by the same CI job.
