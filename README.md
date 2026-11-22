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

| Command | What it does |
|---------|----------------|
| `dot init` | Homebrew, Brewfile, stow, Bun, Vite+, fonts, SSH, Herdr, Rex, Scroll Reverser, pi |
| `dot init --skip-ssh` / `--skip-font` / `--headless` | Skip SSH, fonts, or both (headless) |
| `dot update` | `git pull`, `brew outdated` → `upgrade --yes`, cleanup, stow, Vite+ Node, Herdr, Rex, pi |
| `dot stow` / `check` / `--adopt` | Stow `home/` → `~` |
| `dot check-packages` | Which Brewfile brew/cask entries are missing |
| `dot retry-failed` | Retry entries in `packages/failed_packages_*.txt` |
| `dot gen-ssh-key [email]` | Create `~/.ssh/id_ed25519` |
| `dot rex apply` / `reload` | Local Rex UI or Lua only (see below) |
| `dot package …` | Edit Brewfile |
| `dot doctor` | Tools, bundle, Rex drift, symlinks |
| `dot link` / `unlink` | Symlink to `/usr/local/bin` or `~/.local/bin` |

### Daily workflow

```text
Routine:     dot update
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