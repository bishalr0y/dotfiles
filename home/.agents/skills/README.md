# Skills

My global skill set for coding agents, trimmed to the skills shared with
[dmmulroy/.dotfiles](https://github.com/dmmulroy/.dotfiles/tree/main/home/.agents),
plus a standalone grill skill and the Plannotator suite. Where everything came from
is recorded in [SOURCES.md](SOURCES.md).

## What's here

| Skill | Invocation | What it does |
| --- | --- | --- |
| `bro` | `/bro` | Restate the last message in plain language, no jargon. |
| `diagnosing-bugs` | model | Diagnosis loop for hard bugs and performance regressions. |
| `grilling` | model | Relentless interview that stress-tests a plan or design. Self-contained: pulls in no other skill. |
| `handoff` | `/handoff` | Compact the conversation into a handoff document for a fresh agent. |
| `show-me` | `/show-me` | Explain the current topic visually with diagrams and HTML artifacts. |
| `writing-for-agents` | model | Reference for writing skills, `AGENTS.md` / `CLAUDE.md`, and agent-facing docs. |
| `plannotator` | model | Plannotator reference: plan review, code review, annotate, Inbox. |
| `plannotator-annotate` | `/plannotator-annotate` | Annotate a file, folder, or URL in Plannotator. |
| `plannotator-inbox` | `/plannotator-inbox` | Open the Plannotator Inbox. |
| `plannotator-last` | `/plannotator-last` | Annotate the latest assistant message. |
| `plannotator-review` | `/plannotator-review` | Review changes or a PR in Plannotator. |

`rex` is installed separately under `~/.claude/skills/rex` and is not tracked here.

## Notes

- `/grilling` is the standalone grill. The old `grill-me` and `grill-with-docs`
  wrappers were removed; the latter pulled in `domain-modeling`, which is gone.
- The Plannotator skills are installed by Plannotator itself, not vendored.
- Vendored skills are never hand-edited. Update from upstream, or wrap them.
- `SOURCES.md` pins the upstream commit. Check drift before adding anything new.
