#!/usr/bin/env bash
# Smart Ctrl+h/j/k/l for herdr-app (same idea as herdr-tui vim-herdr-navigation):
# if the focused pane's foreground is Vim/Neovim, forward the chord into it;
# otherwise move herdr-app pane focus.
#
# Usage: vim-nav.sh <left|down|up|right>
# Does not touch herdr-tui config or plugins.

set -euo pipefail

dir="${1:?usage: vim-nav.sh <left|down|up|right>}"

case "$dir" in
  left)  key="ctrl+h" ;;
  down)  key="ctrl+j" ;;
  up)    key="ctrl+k" ;;
  right) key="ctrl+l" ;;
  *) echo "vim-nav.sh: unknown direction: $dir" >&2; exit 2 ;;
esac

vim_re='^g?(view|l?n?vim?x?)(diff)?$'

status_json="$(herdr-app status 2>/dev/null || true)"
if [ -z "$status_json" ]; then
  exit 0
fi

pane="$(printf '%s' "$status_json" | jq -r '.focused_pane // empty')"
if [ -z "$pane" ] || [ "$pane" = "null" ]; then
  herdr-app do pane.go --direction "$dir" >/dev/null
  exit 0
fi

term="$(herdr-app ls 2>/dev/null | jq -r --arg p "$pane" '
  .spaces[]?.tabs[]?.terminals[]?
  | select(.pane == $p)
  | .terminal
' | head -n1)"

if [ -z "$term" ] || [ "$term" = "null" ]; then
  herdr-app do pane.go --direction "$dir" >/dev/null
  exit 0
fi

fg_name="$(hc get "$term" --json 2>/dev/null | jq -r '.foreground.name // empty' | tr '[:upper:]' '[:lower:]')"

if [ -n "$fg_name" ] && printf '%s' "$fg_name" | grep -Eq "$vim_re"; then
  exec hc keys "$term" "$key"
fi

exec herdr-app do pane.go --direction "$dir"
