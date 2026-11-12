# Skill sources

Pinned upstream for everything from Matt Pocock:

- Repo: <https://github.com/mattpocock/skills>
- Commit: `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d`
- Tree: `a73b182b5f22565e829e0969eb0bfd284508a7b8`
- Synced: 2026-11-07
- Verified: the vendored skills below are byte-identical to that commit

Skills are vendored verbatim. Do not hand-edit them; update from upstream instead.

## Vendored from mattpocock/skills

| Local skill | Upstream path |
| --- | --- |
| `diagnosing-bugs` | `skills/engineering/diagnosing-bugs` |
| `writing-for-agents` | `skills/productivity/writing-for-agents` |
| `grilling` | `skills/productivity/grilling` |
| `handoff` | `skills/productivity/handoff` |

## Not from mattpocock/skills

| Local skill | Source |
| --- | --- |
| `bro` | Authored locally (see `Restore bro skill for plain-language restatements.`) |
| `show-me` | Unverified. `pr/CREDITS.md` (now removed) credited Humanlayer's `show-me`; confirm provenance before updating |
| `plannotator`, `plannotator-annotate`, `plannotator-inbox`, `plannotator-last`, `plannotator-review` | Installed by Plannotator itself, not vendored here |

Record a source for these before updating them.

## Checking drift

Compare each local file's git blob hash with the upstream tree at the pinned commit:

```bash
SHA=4ae2317ddb22b046e26455e4f9c9b3aaaf62212d
TREE=$(curl -fsSL "https://api.github.com/repos/mattpocock/skills/commits/$SHA" \
  | python3 -c 'import sys,json;print(json.load(sys.stdin)["commit"]["tree"]["sha"])')
curl -fsSL "https://api.github.com/repos/mattpocock/skills/git/trees/$TREE?recursive=1" \
  | python3 -c '
import sys,json,os,subprocess
blobs={x["path"]:x["sha"] for x in json.load(sys.stdin)["tree"] if x["type"]=="blob"}
for name in sorted(os.listdir(".")):
    if not os.path.isfile(os.path.join(name,"SKILL.md")): continue
    hits=[p for p in blobs if p.endswith("/"+name+"/SKILL.md")]
    if not hits:
        print(f"UNVENDORED {name}"); continue
    up=hits[0][:-len("/SKILL.md")]
    local={os.path.relpath(os.path.join(r,f),name) for r,_,fs in os.walk(name) for f in fs}
    remote={p[len(up)+1:] for p in blobs if p.startswith(up+"/")}
    bad=[f for f in local & remote
         if subprocess.run(["git","hash-object",os.path.join(name,f)],capture_output=True,text=True).stdout.strip()!=blobs[up+"/"+f]]
    if local-remote or remote-local or bad:
        print(f"DRIFT {name}: missing={sorted(remote-local)} extra={sorted(local-remote)} differs={sorted(bad)}")
    else:
        print(f"OK    {name}")
'
```

## Updating a skill

1. Pick the new upstream commit and record it here.
2. Copy the whole skill directory from that commit, preserving structure.
3. Hash-verify every file against upstream.
4. Re-run the drift check.
5. Never edit a vendored `SKILL.md` in place. If local behaviour is needed,
   add a wrapper skill and point at the vendored one.
