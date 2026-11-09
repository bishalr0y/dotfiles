# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
brew install git
```

### Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
git clone git@github.com/bishalr0y/dotfiles.git
cd dotfiles
```

Then, use GNU stow to create symlinks

```
stow .
```

Pi packages are declared in `home/.pi/agent/settings.json` and installed under `~/.pi/agent/npm`, which is gitignored. After stow, install them:

```
pi install npm:pi-web-search
pi install npm:@plannotator/pi-extension
pi install npm:pi-cursor-sdk
```
