# Skills

My global skill set for coding agents. Mostly Matt Pocock's engineering workflow
([mattpocock/skills](https://github.com/mattpocock/skills)), plus a review surface
and a few utilities. Where everything came from is recorded in [SOURCES.md](SOURCES.md).

## Start here

- **Can't remember which skill to use?** Run `/ask-matt` and describe the situation
  in plain language. It reads the actual `SKILL.md` files and routes you.
- **Want the map?** This file.

Most workflow skills are slash-invoked on purpose. A few are model-invoked because
the agent should reach for them unprompted: `diagnosing-bugs`, `pr`, `prototype`,
`wizard`, `domain-modeling`, `codebase-design`, `research`, `writing-for-agents`.

## The main flow: idea → ship

```
/grill-with-docs
   │   optional detour: /prototype, bridged by /handoff both ways
   ▼
/to-spec ──► /to-tickets ──┬─► /implement       one ticket at a time, fresh context
   │                       └─► /implement-spec  whole spec, parallel sub-agents
   ▼
/implement drives /tdd, then /code-review ──► /pr ──► /retro
```

- **Single-session work** skips the middle: go straight to `/implement`.
- **`/to-spec` and `/to-tickets`** publish to the issue tracker configured by
  `/setup-matt-pocock-skills` and label the work `ready-for-agent`.
- **`/retro`** is not about the code. It proposes changes to this environment:
  navigation pointers, automated checks, coding standards.

## On-ramps

| Situation | Flow |
| --- | --- |
| Incoming issues or external PRs | `/triage` → agent brief → `/implement` |
| Something is broken | `/diagnosing-bugs` → `/retro` (and `/improve-codebase-architecture` if there is no seam to lock the fix down) |
| A huge, foggy effort | `/wayfinder` → `/to-spec` → `/to-tickets` → `/implement` |
| Codebase upkeep | `/improve-codebase-architecture` → `/grill-with-docs` |

`/triage` is only for work you did **not** create. Tickets from `/to-tickets` are
already agent-ready; triaging them wastes the work.

## Vocabulary underneath

- **`/domain-modeling`** — the project's domain language: challenge fuzzy terms,
  write `GLOSSARY.md`, record hard-to-reverse decisions as ADRs.
- **`/codebase-design`** — the deep-module vocabulary: module, interface, depth,
  seam, adapter, leverage, locality.

These are pulled in by other skills, but reach for them directly when the words,
not the process, are the problem.

## Standalone

`/prototype`, `/research`, `/to-questionnaire`, `/wizard`, `/wait-what`, `/handoff`,
`/teach`, `/show-me`, `/plannotator-*`.

## Artifacts and where they live

| Artifact | Created by | Consumed by |
| --- | --- | --- |
| `GLOSSARY.md` / `GLOSSARY-MAP.md` | `domain-modeling`, `grill-with-docs` | nearly everything |
| `docs/adr/NNNN-*.md` | `domain-modeling` | `codebase-design`, `improve-codebase-architecture` |
| `docs/agents/{issue-tracker,domain,triage-labels}.md` | `setup-matt-pocock-skills` | `to-spec`, `to-tickets`, `triage`, `code-review` |
| Spec issue | `to-spec` | `to-tickets`, `code-review` |
| Tickets (with blocking edges) | `to-tickets` | `implement`, `implement-spec` |
| Agent brief (comment) | `triage`, `to-spec` | `implement` |
| `.out-of-scope/<concept>.md` | `triage` | `triage` |
| `prototype/<name>` branch | `prototype` | the implementation issue |
| Handoff doc in `$TMPDIR` | `handoff` | a fresh session |
| Research note in the repo | `research` | `grill-with-docs` |

## Scope policy

- **Global (this folder):** the workflow, vocabulary, meta skills, and review
  surfaces. These are repo-agnostic.
- **Project-level:** vendor and stack skills (Vercel, Cloudflare, Supabase),
  PStack experiments, anything that only makes sense in one repo.

Don't install a platform skill globally. Don't install a second workflow
methodology next to this one.

## Maintenance

- `/setup-matt-pocock-skills` runs **once per repo**, before the first workflow.
- Vendored skills are never hand-edited. Update from upstream, or wrap them.
- `SOURCES.md` pins the upstream commit. Check drift before adding anything new.
- If a skill needs a local change to be useful, write a small wrapper skill
  instead of forking the text.

## Quick lookup

| I want to… | Skill |
| --- | --- |
| turn a fuzzy idea into a plan | `/grill-with-docs` |
| test whether a state model or UI feels right | `/prototype` |
| write a spec | `/to-spec` |
| split a spec into tickets | `/to-tickets` |
| build one ticket | `/implement` |
| build a whole spec in parallel | `/implement-spec` |
| fix a hard bug | `/diagnosing-bugs` |
| handle an incoming issue or PR | `/triage` |
| plan something too big for one session | `/wayfinder` |
| improve module boundaries | `/improve-codebase-architecture` |
| review a branch or PR | `/code-review` or `/plannotator-review` |
| write a PR body | `/pr` |
| improve my setup after a session | `/retro` |
| explain a term or record a decision | `/domain-modeling` |
| design a module's interface | `/codebase-design` |
| understand something visually | `/show-me` |
| learn something over time | `/teach` |
| do manual setup (secrets, dashboards) | `/wizard` |
| ask someone else for information | `/to-questionnaire` |
| hand off to a fresh session | `/handoff` |
| ask "what did you mean?" | `/wait-what` |
| research external facts | `/research` |
