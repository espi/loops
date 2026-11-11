#!/usr/bin/env python3
"""kb_budget.py - word budgets for every file the routines write.

Reads guardrails/BUDGETS.md (human-owned). One table row per budget:
  | path | cap | unit |
unit is `words` (one file), `words total` (every file under a folder), or
`items` with a path of the form `file#Heading text` (the `- ` lines under
that heading, to the next heading of the same or higher level).

  kb_budget.py            print every row: size, cap, ok | OVER
  kb_budget.py --base REF also compare with REF. A path over its cap must not
                          be larger than it was at REF; a path under its
                          cap must stay under. Exit 1 otherwise.

A budget the agent grades itself on is no budget, so CI runs this
(.github/workflows/kb-size.yml). Raising a cap is a human-authored change.
"""
import argparse
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def rows():
    out = []
    for line in open(os.path.join(ROOT, "guardrails", "BUDGETS.md"), encoding="utf-8"):
        m = re.match(r"^\|\s*`?([^|`]+?)`?\s*\|\s*([\d,]+)\s*\|\s*(words total|words|items)\s*\|", line)
        if m:
            out.append((m.group(1).strip(), int(m.group(2).replace(",", "")), m.group(3)))
    return out


def at(ref, path):
    """File text at ref (None when absent); the working tree when ref is None."""
    if ref is None:
        try:
            return open(os.path.join(ROOT, path), encoding="utf-8").read()
        except OSError:
            return None
    p = subprocess.run(["git", "-C", ROOT, "show", "%s:%s" % (ref, path)], capture_output=True, text=True)
    return p.stdout if p.returncode == 0 else None


def files_under(ref, folder):
    if ref is None:
        base = os.path.join(ROOT, folder)
        return [os.path.relpath(os.path.join(dp, f), ROOT) for dp, _, fs in os.walk(base) for f in fs]
    p = subprocess.run(["git", "-C", ROOT, "ls-tree", "-r", "--name-only", ref, "--", folder], capture_output=True, text=True)
    return [l for l in p.stdout.splitlines() if l]


def section_items(text, heading):
    n, on, level = 0, False, 0
    for line in (text or "").splitlines():
        h = re.match(r"^(#+)\s+(.*)$", line)
        if h:
            if on and len(h.group(1)) <= level:
                break
            if not on and heading.lower() in h.group(2).lower():
                on, level = True, len(h.group(1))
            continue
        if on and re.match(r"^- ", line):
            n += 1
    return n


def size(ref, path, unit):
    if unit == "items":
        f, _, heading = path.partition("#")
        return section_items(at(ref, f), heading)
    if unit == "words total":
        return sum(len((at(ref, f) or "").split()) for f in files_under(ref, path))
    return len((at(ref, path) or "").split())


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base")
    a = ap.parse_args()
    bad = 0
    for path, cap, unit in rows():
        now = size(None, path, unit)
        line = "%-52s %9s of %7s %s" % (path, format(now, ","), format(cap, ","), unit)
        if now <= cap:
            print(line + "  ok")
            continue
        if a.base is None:
            print(line + "  OVER")
            continue
        was = size(a.base, path, unit)
        if was > cap and now <= was:
            print(line + "  OVER, not growing (was %s)" % format(was, ","))
        else:
            bad += 1
            print(line + "  OVER and larger than at %s (was %s): delete to fit" % (a.base, format(was, ",")))
    if bad:
        print("%d path%s over budget and growing. At a cap, a new entry deletes an old one; git is the archive." % (bad, "" if bad == 1 else "s"))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
