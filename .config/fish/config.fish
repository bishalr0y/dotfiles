# Disable greeting
set fish_greeting

# Set Editor to neovim
set -gx EDITOR 'nvim'

# Set neovim as the program to open manpages
set -gx MANPAGER 'nvim +Man!'

# PATH setup
fish_add_path /usr/local/bin
fish_add_path $HOME/go
fish_add_path /usr/local/go/bin
fish_add_path $HOME/.local/bin
fish_add_path /Users/bishal/.cargo/bin
fish_add_path $HOME/.bun/bin

# NVM
set -gx NVM_DIR $HOME/.nvm

# Starship prompt
starship init fish | source

# Zoxide
zoxide init fish | source

# Direnv
direnv hook fish | source

# Aliases
alias vim nvim
alias l 'ls -la'
alias c clear
alias lg lazygit
alias oc opencode
alias update 'brew update && brew upgrade && brew cleanup --prune=all'

# Pomodoro functions
function work
    set duration (math "60 * $argv[1]")
    timer $duration
    terminal-notifier -message 'Pomodoro' -title 'Work Timer is up! Take a Break' -sound Crystal
end

function rest
    set duration (math "60 * $argv[1]")
    timer $duration
    terminal-notifier -message 'Pomodoro' -title 'Break is over! Get back to work' -sound Crystal
end