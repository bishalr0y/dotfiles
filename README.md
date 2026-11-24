# My dotfiles

Personal dotfiles managed with GNU Stow and the `dot` CLI in this repo.

## Requirements

- Git
- macOS: `dot init` installs [Homebrew](https://brew.sh/) if needed, then `brew bundle` (includes GNU Stow)

## Quick start

```bash
git clone git@github.com:bishalr0y/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x dot
./dot init
./dot link
```

## Commands

Run `dot help` or `dot package help` in the repo for the full CLI reference.

| Command | What it does |
|---------|----------------|
| `dot init` | Homebrew, Brewfile, stow, Bun, Vite+, fonts, SSH, Herdr, Rex, Scroll Reverser, pi |
| `dot init --skip-ssh` / `--skip-font` / `--headless` | Skip SSH, fonts, or both (headless) |
| `dot update` | `git pull`, Homebrew upgrade, Brewfile gap-fill, cleanup, stow, Vite+ Node, Herdr, Rex, pi; **warns** if brew/cask is installed but not in Brewfile |
| `dot stow` / `check` / `--adopt` | Stow `home/` → `~` |
| `dot check-packages` | Which Brewfile brew/cask entries are not installed on this machine |
| `dot retry-failed` | Retry `packages/failed_packages_*.txt`, or run `brew bundle install` if no failure list |
| `dot gen-ssh-key [email]` | Create `~/.ssh/id_ed25519` |
| `dot rex apply` / `reload` | Local Rex UI or Lua only (see below) |
| `dot package …` | Brewfile: `list`, `add`, `remove`, `update`, **`sync`** — see below |
| `dot doctor` | Tools, bundle, Rex drift, symlinks |
| `dot link` / `unlink` | Symlink to `/usr/local/bin` or `~/.local/bin` |
| `dot completions` | Zsh tab completion (`home/.config/zsh/completions/_dot` via stow) |

### Zsh completions

After `dot stow`, `~/.config/zsh/completions/_dot` provides tab completion for `dot` and `dot package …`. `.zshrc` adds that directory to `fpath` and runs `compinit`. Reload with `exec zsh` or `dot completions` for hints.

### Homebrew & Brewfile

`Brewfile` in the repo is the **source of truth**. `dot update` moves the machine toward it (install/upgrade/cleanup). It does **not** auto-run `brew bundle dump`; you record new installs deliberately.

| Direction | Command |
|-----------|---------|
| Routine | `dot update` |
| Brewfile → machine (missing) | `dot check-packages` → `dot retry-failed` |
| Machine → Brewfile (ad-hoc `brew install`) | `dot package sync` (preview) → `dot package sync --yes` |
| One package | `dot package add <name> [brew\|cask]` · `dot package remove <name>` |

**`dot package sync`** (default: casks only):

```bash
dot package sync              # preview extra casks
dot package sync --yes        # append to Brewfile
dot package sync --brew       # preview formulae (brew leaves -r)
dot package sync --brew --yes
dot package sync --all        # casks + formulae
dot package sync --all --yes
```

Typical loop after installing an app with Homebrew:

```text
dot update                    # may warn: installed but not in Brewfile
dot package sync              # review list
dot package sync --yes        # commit Brewfile when happy
```

### Daily workflow

```text
Routine:     dot update
Brew drift:  dot package sync && dot package sync --yes  (after update warns)
Rex UI/font: dot stow && dot rex apply   → Cmd+Q Rex
Rex Lua:     dot rex reload
```

### Rex font / UI settings

Edit `home/.config/rex/macos-defaults.conf`, then:

```bash
dot stow && dot rex apply
```

Quit Rex fully (Cmd+Q) and reopen. `rex config reload` does **not** apply font/UI prefs.

### Scroll Reverser

[Scroll Reverser](https://pilotmoon.com/scrollreverser/) is a separate macOS app (cask in Brewfile). `dot init` / `dot update` configure its prefs; grant Accessibility when prompted.

### Private fonts

Add one `git@github.com:…` URL per line in `fonts/sources.txt`. You need:

- SSH access to each private repo (same key as dotfiles / `dot gen-ssh-key`)
- Font files (`.otf` / `.ttf`) inside those repos

Skip with `dot init --skip-font` or `--headless`.

### Pi (Vite+ only)

`dot init` installs [Vite+](https://vite.plus), Node runtimes (`vp env install lts/latest`), and `vp install -g @earendil-works/pi-coding-agent`. Shell PATH comes from `home/.config/zsh/conf.d/vite-plus.zsh` (stowed, like Dillon’s `vite-plus.fish`).

Vite+ runtime files under `~/.config/vite-plus/` are gitignored (installer-owned). Do **not** install pi via Homebrew npm. `dot update` runs `pi update --all` when `pi` resolves under a `vite-plus` install dir.

**Migrating from brew pi:** `npm uninstall -g @earendil-works/pi-coding-agent`, then `dot stow && dot update`.

### Claude Code

`claude-code` cask in Brewfile. Upgrades with `dot update`. Policy in `home/.claude/settings.json` (stowed); login and sessions stay local (`home/.claude.json` and most of `~/.claude/` are gitignored).

Shared skills: `home/.agents/skills/`. Claude-only skills (e.g. `rex`) live under `~/.claude/skills/` and are not tracked.

First run: `claude auth login` (check with `claude auth status`).

**In pi:** [pi-claude-cli](https://github.com/dmmulroy/pi-claude-cli) is listed in `home/.pi/agent/settings.json`, so pi installs it on first start (or run `pi install git:github.com/dmmulroy/pi-claude-cli`). It uses the Claude login above. In pi, pick a model under `pi-claude-cli` with `/model`, and check it with `/pi-claude-cli-status`. Don't accept its `claude update` prompt — Homebrew owns updates (`dot update`); `autoUpdatesChannel: stable` keeps its version check matched to the stable cask.

## Stow layout

```bash
stow -R -d ~/dotfiles -t ~ home
```

Same as `dot stow`. Edit files under `home/` in the repo, not only under `~`.

### Stow conflicts

```bash
dot stow check
```

Back up and remove conflicting paths under `~`, or once: `dot stow --adopt`.