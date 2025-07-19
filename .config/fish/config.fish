if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable greeting
set fish_greeting 

# Set Editor to neovim
set -gx EDITOR 'nvim'

# Set neovim as the program to open manpages
set -gx MANPAGER 'nvim +Man!'

# Clean duplicate paths
set -gx PATH (string split " " (string join " " -- (string match -v -r '(.+)(?= \1)' $PATH)))

