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
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.bun/bin

# NVM
set -gx NVM_DIR $HOME/.nvm