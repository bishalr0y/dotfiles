# Add Homebrew's executable directory to the front of the PATH
export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/bishal/.cargo/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export GOPATH=$HOME/go
export EDITOR=nvim
export BUN_INSTALL="$HOME/.bun"
export NVM_DIR="$HOME/.nvm"

# fzf: search box on top, results below
export FZF_DEFAULT_OPTS='--layout=reverse'

# shortcuts
alias vim="nvim"
alias l="ls -la"
alias c="clear"
alias lg="lazygit"
alias oc="opencode"
alias update="brew update && brew upgrade && brew cleanup --prune=all"
alias wr="wrangler"

# dotfiles management
# Re-stows the home package from anywhere (no cd needed) — uses -d for stow dir and -t for target
alias stowdot="stow -d ~/dotfiles -t ~ home"
# Installs/updates packages from the Brewfile
alias brewdot="brew bundle --file ~/dotfiles/Brewfile"
# Captures your current Homebrew state back into the Brewfile
alias brewdump="brew bundle dump --force --file ~/dotfiles/Brewfile"

# fzf shell integration (Ctrl+R, Ctrl+T, Alt+C)
eval "$(fzf --zsh)"

# prompt
eval "$(starship init zsh)"

# smarter cd with frecency
eval "$(zoxide init zsh)"

# auto-load .envrc files
eval "$(direnv hook zsh)"

# autocomplete suggestions as you type
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# colorize valid command lines
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# node version manager
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
# bun completions
[ -s "/Users/bishal/.bun/_bun" ] && source "/Users/bishal/.bun/_bun"
