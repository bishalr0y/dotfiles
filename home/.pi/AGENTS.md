# Pi agent workspace

TypeScript, ESM-only. Dotfiles source for `~/.pi` (stow from repo root). Local extensions under `agent/extensions/`; published pi packages declared in `agent/settings.json` and installed with `pi install` (local install tree, not in git).

**Stow:** `stow .` symlinks `home/.pi/` → `~/.pi/`. Edit this repo, not only the live tree — the next stow overwrites `~/.pi` with what is tracked here.

## Structure

```
home/.pi/
├── AGENTS.md
├── .gitignore                     # build/env noise under this tree (tracked)
└── agent/
    ├── settings.json              # theme, npm packages (tracked)
    ├── themes/
    │   └── catppuccin-macchiato.json
    ├── npm/                       # pi install target (~/.pi/agent/npm); entire dir gitignored
    └── extensions/
        ├── whimsical.ts           # standalone: random working message each turn
        ├── continue-after-compaction.ts
        ├── git-interceptor.ts     # standalone: no git editor hangs, block --no-verify
        ├── pi-skill-toggle/       # package: /toggle-skills UI
        ├── save-md/               # package: /save-md command
        └── tests/                 # e.g. continue-after-compaction tests
```

Skills live in `home/.agents/skills/` (stow to `~/.agents/skills/`). Do not copy skills under `agent/`.

## Where to look

| Task | Location |
|------|----------|
| Theme, npm packages | `agent/settings.json` |
| Add npm pi package | `agent/settings.json` → `packages[]`; mirror dep in `agent/npm/package.json` if you version it; then `pi install npm:…` (see repo `README.md`) |
| Install npm pi packages after stow | Repo `README.md` → `pi install npm:…`; install tree is `~/.pi/agent/npm` (gitignored) |
| Standalone extension | `agent/extensions/*.ts` (auto-discovered) |
| Packaged extension | `agent/extensions/<name>/` with `package.json` → `pi.extensions` |
| New skill | `home/.agents/skills/<name>/SKILL.md` |
| Working / thinking label in TUI | `agent/extensions/whimsical.ts` |
| Resume after compaction | `agent/extensions/continue-after-compaction.ts` |
| Agent git guards | `agent/extensions/git-interceptor.ts` |
| Skill agent/manual toggle | `agent/extensions/pi-skill-toggle/` |
| Save last assistant reply | `agent/extensions/save-md/` |
| What is safe to commit under `.pi` | This file → **Git tracking** |
| Change skill inventory / toggles | `home/.agents/skills/` (separate stow tree, not under `agent/`) |

## Workflow

1. Edit `home/.pi/` in the dotfiles repo (not only `~/.pi`).
2. From repo root: `stow .` (re-links `home/.pi` → `~/.pi`; overwrites unmanaged live files).
3. New npm pi package: add to `agent/settings.json` `packages[]`, then `pi install npm:…` (see repo `README.md`).
4. Local extension change: edit under `agent/extensions/`, run package tests if applicable, then `/reload` in pi (or restart).

## Extensions

| Extension | Type | Behavior |
|-----------|------|----------|
| **whimsical** | `whimsical.ts` | On each turn, sets a random whimsical `setWorkingMessage` until the turn ends. |
| **continue-after-compaction** | `continue-after-compaction.ts` | After compaction, sends a steer prompt to resume the task from session JSONL. |
| **git-interceptor** | `git-interceptor.ts` | On bash calls containing `git`: prefixes `GIT_EDITOR=true GIT_SEQUENCE_EDITOR=true GIT_MERGE_AUTOEDIT=no` so git never opens an editor; blocks `--no-verify`. From dmmulroy/.dotfiles. |
| **pi-skill-toggle** | package | `/toggle-skills` — inventory skills, flip agent-invocable vs manual-only via frontmatter. |
| **save-md** | package | `/save-md name` — write latest assistant Markdown to `name.md` in cwd (no overwrite). |

## npm packages (settings)

```jsonc
// agent/settings.json
{
  "theme": "catppuccin-macchiato",
  "editorPaddingX": 1,
  "packages": [
    "git:github.com/dmmulroy/pi-web-tools",
    "npm:@plannotator/pi-extension",
    "npm:pi-cursor-sdk"
  ]
}
```

- **pi-cursor-sdk** — Cursor-backed runs; auth and runtime state stay local (not in git).
- **@plannotator/pi-extension** — plan/review; related skills under `home/.agents/skills/plannotator*`.
- **pi-web-tools** — `websearch` / `webfetch` via Exa (or Parallel) MCP; works with any Pi model including cursor-sdk. Set `EXA_API_KEY` in `~/.zshrc.local` and derive `PI_WEB_TOOLS_EXA_ENDPOINT` in `~/.envrc` (see repo `README.md`).

Local extensions load from `agent/extensions/` without listing them in `settings.json`. Reload after edits: `/reload`.

## Notes

- **pi-cursor-sdk** — model/auth and Cursor bridge state stay under ignored `agent/` paths; default model is not set in tracked `settings.json`.
- **continue-after-compaction** — after compact, sends a steer prompt; resume by reading session JSONL (parentId chain), not by nesting `pi --session`.
- **pi-skill-toggle** — UI under `src/ui/` (overlay, render, view-model); mutates skill frontmatter for agent vs manual invocation.
- **whimsical** — TUI working label only; does not change tools or model behavior.
- **save-md** — uses `@earendil-works/pi-ai` message shapes when stripping assistant output.

## Conventions

- `"type": "module"` on packaged extensions; ESM TypeScript throughout.
- Standalone files: `export default function (pi: ExtensionAPI)`.
- Packaged extensions: `"pi": { "extensions": ["./index.ts"] }` or `"./src/index.ts"`.
- Dependencies: `@earendil-works/pi-coding-agent`, `@earendil-works/pi-tui`; add `@earendil-works/pi-ai` when handling message content.
- **Published** pi packages (`@plannotator/pi-extension`, etc.): deps only in `agent/settings.json` + `pi install` — not in local extension `package.json`. Git pi packages (`pi-web-tools`, `pi-claude-cli`) same: list in `settings.json`, then `pi install git:…`.
- **Local** extension devDeps: that extension’s own `package.json` only — never `agent/npm/package.json` (gitignored install dir).
- Typecheck/tests per package: `npm run check` or `npm run typecheck` / `npm run test` inside the extension directory.

## Anti-patterns

- Putting local extension dependencies in `agent/npm/package.json` (install dir for published packages only).
- Committing `node_modules` (`agent/npm/node_modules`, `extensions/**/node_modules`).
- Tracking runtime under `agent/` (see **Git tracking**).
- Editing only `~/.pi` on disk — stow will overwrite those changes from this repo on the next `stow .`.
- Duplicating skills inside `agent/` instead of `home/.agents/skills/`.
- Committing, pushing, or co-authoring git changes without explicit user instruction (see **Git (agent)**).

## Git tracking

Agents often work in `~/.pi` and see ignored files next to tracked ones. Rules live in repo root `.gitignore` plus `home/.pi/.gitignore`; this section is the allow/deny cheat sheet (source of truth: those files).

### Tracked (edit in dotfiles, then stow)

- `home/.pi/AGENTS.md`
- `home/.pi/.gitignore`
- `home/.pi/agent/settings.json`
- `home/.pi/agent/themes/*.json` (e.g. `catppuccin-macchiato.json`)
- `home/.pi/agent/extensions/**` — `.ts`, `package.json`, `tsconfig.json`, `README.md`, tests
- Skills (separate path): `home/.agents/skills/**` — not under `agent/`

### Ignored — `home/.pi/` (repo root `.gitignore`)

- `home/.pi/node_modules/`
- `home/.pi/todos/`
- `home/.pi/.pi/`

### Ignored — `home/.pi/agent/` (default `agent/*`, minus explicit un-ignores)

Un-ignored only: `settings.json`, `themes/`, `extensions/**` (see above). Everything else under `agent/`, including:

- `home/.pi/agent/npm/` — full tree (`package.json`, lockfiles, `node_modules/` from `pi install`)
- `home/.pi/agent/sessions/` — JSONL, journals, usage files
- `home/.pi/agent/auth.json` — API keys / credentials
- `home/.pi/agent/mcp.json` — MCP server config (local)
- `home/.pi/agent/models-store.json` — provider/model cache
- Ad hoc runtime files pi writes under `agent/` not covered by un-ignores

### Ignored — MCP adapter (repo root `.gitignore`)

- `home/.pi/agent/mcp-oauth/`
- `home/.pi/agent/mcp-cache.json`
- `home/.pi/agent/mcp-npx-cache.json`
- `home/.pi/agent/mcp-auth.json`

### Re-ignored under extensions (last match wins)

- `home/.pi/agent/extensions/**/node_modules/`

### Ignored — local builds (`home/.pi/.gitignore`)

Applies under the stowed tree; do not force-add:

- `node_modules/`, `out/`, `dist/`, `*.tgz`
- `.env`, `.env.*`
- `.cache/`, `*.tsbuildinfo`
- `.DS_Store`

## Git (agent)

- Do **not** `git commit` or `git push` unless the user explicitly asks in the current task.
- Never add the model, agent, or AI as a **co-author** on commits (no `Co-authored-by`, no `git commit --author` for the agent, no trailer attributing the assistant).

## Commands (quick reference)

```text
/toggle-skills          # pi-skill-toggle
/save-md <name>         # save-md
/reload                 # reload extensions after code changes
```

Tests:

```bash
cd home/.pi/agent/extensions/save-md && npm run check
cd home/.pi/agent/extensions/pi-skill-toggle && npm run typecheck && npm run test
```