# Vite+ environment setup (https://vite.plus)
#
# Source of truth for PATH in zsh. dot init uses VP_SELF_SETUP_NO_MODIFY_PATH so the
# installer does not overwrite this file or edit shell startup. Runtime state
# (~/.config/vite-plus/, ~/.local/share/vite-plus/) is not tracked in git.
# macOS installs to ~/.vite-plus; Linux uses the XDG data dir.
local __vp_bin="${HOME}/.vite-plus/bin"
[[ -d "$__vp_bin" ]] || __vp_bin="${XDG_DATA_HOME:-$HOME/.local/share}/vite-plus/bin"
export PATH="${__vp_bin}:${PATH}"