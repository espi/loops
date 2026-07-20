# Archive: resolved caveats

Items move here from `sources.md`'s "Known caveats / things to re-verify"
list once they're resolved, confirmed non-useful, or superseded — so the live
caveats list stays a lean, *actionable* backlog instead of an
ever-growing history. Nothing here needs further action; it's provenance,
not a to-do list.

Each entry keeps the resolution date and a one-line reason it was archived
rather than carried forward.

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
