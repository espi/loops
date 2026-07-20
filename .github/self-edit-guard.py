#!/usr/bin/env python3
"""self-edit-guard — enforce the update-knowledge routine's self-improvement envelope.

The `update-knowledge` skill may fold a fix to *its own* file into the PR it
opens (see `.claude/skills/update-knowledge/SKILL.md` step 7). Those edits ride
commits whose subject starts with `self-edit:`. This guard makes the mechanical
half of that gate real rather than self-graded: it FAILS the PR (exit 1) if any
`self-edit:` commit in the PR range breaks the fenced envelope —

  - scope: the commit touches ONLY the update-knowledge SKILL.md
  - cap:   at most ONE self-edit: commit per PR (one auto-edit per pass)
  - size:  <= MAX_CHANGED_LINES changed lines (added + deleted)
  - frozen: the protected regions of SKILL.md (frontmatter + the sentinel-fenced
            verification step, the gate step itself, and the "Guardrails for
            this skill" section) are byte-identical before and after.

Human merge remains the ultimate gate; this just guarantees an auto-applied
self-edit can't quietly exceed its blast radius. The judgment checks (is it
non-semantic? is it repo-internal, not web-sourced?) stay with the agent and the
human reviewer — this enforces only what a machine can enforce deterministically.

Run in CI via .github/workflows/self-edit-guard.yml, or locally:
    BASE_SHA=<base> HEAD_SHA=<head> python3 .github/self-edit-guard.py
    python3 .github/self-edit-guard.py <base> <head>
"""
import os
import re
import subprocess
import sys

SKILL = ".claude/skills/update-knowledge/SKILL.md"
MAX_CHANGED_LINES = 10
SENTINEL_REGIONS = ("verification", "gate", "guardrails")


def git(*args):
    return subprocess.run(
        ["git", *args], capture_output=True, text=True, check=True
    ).stdout


def protected_blocks(text):
    """Extract the protected regions from a version of SKILL.md.

    Returns {name: block_text_or_None}. None means the region could not be
    extracted (missing/malformed sentinel or frontmatter) — treated as tampering
    by the caller, i.e. fail-safe.
    """
    blocks = {}
    lines = text.splitlines()
    # Frontmatter: content between the first two '---' fence lines.
    if lines and lines[0].strip() == "---":
        try:
            end = lines.index("---", 1)
            blocks["frontmatter"] = "\n".join(lines[1:end])
        except ValueError:
            blocks["frontmatter"] = None
    else:
        blocks["frontmatter"] = None
    # Sentinel-fenced regions.
    for name in SENTINEL_REGIONS:
        pat = (
            r"<!--\s*self-edit:protected:start:%s\s*-->(.*?)"
            r"<!--\s*self-edit:protected:end:%s\s*-->" % (name, name)
        )
        m = re.search(pat, text, re.S)
        blocks[name] = m.group(1) if m else None
    return blocks


def main():
    base = os.environ.get("BASE_SHA") or (sys.argv[1] if len(sys.argv) > 1 else None)
    head = os.environ.get("HEAD_SHA") or (sys.argv[2] if len(sys.argv) > 2 else "HEAD")
    if not base:
        print("self-edit-guard: no BASE_SHA/head range given; nothing to check.")
        return 0

    log = git("log", "--format=%H%x09%s", f"{base}..{head}").splitlines()
    self_edits = [
        row.split("\t", 1)[0]
        for row in log
        if "\t" in row and row.split("\t", 1)[1].startswith("self-edit:")
    ]

    fails = []
    if len(self_edits) > 1:
        fails.append(
            f"{len(self_edits)} self-edit: commits in this PR; the per-pass cap is 1."
        )

    for sha in self_edits:
        short = sha[:8]
        files = git("diff", "--name-only", f"{sha}^", sha).split()
        if files != [SKILL]:
            fails.append(
                f"{short}: self-edit touches {files or '[]'}; must touch ONLY {SKILL}."
            )
            continue  # scope already wrong; protected-region check would be moot
        numstat = git("diff", "--numstat", f"{sha}^", sha).split()
        if len(numstat) >= 2 and numstat[0] != "-" and numstat[1] != "-":
            changed = int(numstat[0]) + int(numstat[1])
            if changed > MAX_CHANGED_LINES:
                fails.append(
                    f"{short}: {changed} changed lines > cap {MAX_CHANGED_LINES}."
                )
        old = protected_blocks(git("show", f"{sha}^:{SKILL}"))
        new = protected_blocks(git("show", f"{sha}:{SKILL}"))
        for name in old:
            if old[name] is None or new.get(name) is None:
                fails.append(
                    f"{short}: protected region '{name}' missing/malformed "
                    f"(sentinel tampering)."
                )
            elif old[name] != new[name]:
                fails.append(f"{short}: modifies protected region '{name}'.")

    if fails:
        print("self-edit-guard FAILED:")
        for f in fails:
            print("  -", f)
        print(
            "\nA `self-edit:` commit exceeded the auto-apply envelope "
            "(SKILL.md step 7). Move the change to the PR's 'Suggested' lane, or "
            "make it a normal human-authored commit (no `self-edit:` prefix)."
        )
        return 1
    print(f"self-edit-guard OK — {len(self_edits)} self-edit: commit(s) checked.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
