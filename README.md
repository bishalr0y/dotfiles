# My dotfiles

This directory contains the dotfiles for my system, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
.
├── home/          # Stow package — contents mirror $HOME layout
│   ├── .config/   #   → ~/.config/
│   ├── .pi/       #   → ~/.pi/
│   ├── .tmux.conf #   → ~/.tmux.conf
│   └── .zshrc     #   → ~/.zshrc
├── Brewfile       # Homebrew bundle (stays at repo root)
├── README.md
└── .gitignore
```

## Requirements

- **Git** — `brew install git`
- **GNU Stow** — `brew install stow`
- **TPM** (Tmux Plugin Manager):
  ```
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```

## Installation

Clone the repo into `$HOME`:

```
git clone git@github.com:bishalr0y/dotfiles.git ~/dotfiles
```

Create symlinks with GNU Stow (the `home` package maps to `$HOME`):

```
cd ~/dotfiles
stow home
```

## Homebrew

Install packages from the Brewfile:

```
brew bundle --file ~/dotfiles/Brewfile
```

Or from the repo directory:

```
cd ~/dotfiles && brew bundle
```
