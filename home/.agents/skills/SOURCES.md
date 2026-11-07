# Skill sources

Pinned upstream for everything from Matt Pocock:

- Repo: <https://github.com/mattpocock/skills>
- Commit: `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d`
- Tree: `a73b182b5f22565e829e0969eb0bfd284508a7b8`
- Synced: 2026-11-07
- Verified: all 27 vendored skills byte-identical

Skills are vendored verbatim. Do not hand-edit them; update from upstream instead.
The rest of this file records what came from where, and what did not come from this
repo at all.

## Synced at the pinned commit

| Local skill | Upstream path |
| --- | --- |
| `ask-matt` | `skills/engineering/ask-matt` |
| `code-review` | `skills/engineering/code-review` |
| `codebase-design` | `skills/engineering/codebase-design` |
| `diagnosing-bugs` | `skills/engineering/diagnosing-bugs` |
| `implement-spec` | `skills/engineering/implement-spec` |
| `improve-codebase-architecture` | `skills/engineering/improve-codebase-architecture` |
| `pr` | `skills/engineering/pr` |
| `prototype` | `skills/engineering/prototype` |
| `research` | `skills/engineering/research` |
| `retro` | `skills/engineering/retro` |
| `setup-matt-pocock-skills` | `skills/engineering/setup-matt-pocock-skills` |
| `wayfinder` | `skills/engineering/wayfinder` |
| `wizard` | `skills/engineering/wizard` |
| `grill-me` | `skills/productivity/grill-me` |
| `to-questionnaire` | `skills/productivity/to-questionnaire` |
| `wait-what` | `skills/productivity/wait-what` |
| `writing-for-agents` | `skills/productivity/writing-for-agents` |
| `domain-modeling` | `skills/engineering/domain-modeling` |
| `grill-with-docs` | `skills/engineering/grill-with-docs` |
| `implement` | `skills/engineering/implement` |
| `tdd` | `skills/engineering/tdd` |
| `to-spec` | `skills/engineering/to-spec` |
| `to-tickets` | `skills/engineering/to-tickets` |
| `triage` | `skills/engineering/triage` |
| `grilling` | `skills/productivity/grilling` |
| `handoff` | `skills/productivity/handoff` |
| `teach` | `skills/productivity/teach` |

## Not from mattpocock/skills

| Local skill | Source |
| --- | --- |
| `plannotator`, `plannotator-annotate`, `plannotator-inbox`, `plannotator-last`, `plannotator-review` | Installed by Plannotator itself, not vendored here |
| `show-me` | Not in the pinned repo. `pr/CREDITS.md` credits Humanlayer's `show-me`; treat the source as unverified until recorded |

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
