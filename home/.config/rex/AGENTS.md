# Rex config

Lua 5.1 for the Rex multiplexer. Stowed to `~/.config/rex/`. `init.lua` only
bootstraps; modules live in `bishalr0y/`.

## Structure

```
rex/
├── init.lua                 # require("bishalr0y")
├── bishalr0y/               # keymaps, actions, modes
├── themes/catppuccin-macchiato
├── macos-defaults.conf      # app UI prefs → `dot rex apply`
└── ssh_config               # from `rex terminfo setup` (gitignored)
```

## After editing

| What you changed | Command |
|------------------|---------|
| `bishalr0y/*.lua`, `init.lua` | `dot rex reload` or `rex config reload` |
| `macos-defaults.conf` (font, tabs, …) | `dot rex apply` then **quit & reopen Rex** |
| Both | `dot rex sync` |

`dot update` runs stow + full `rex sync` on macOS.

## Anti-patterns

- Expecting `stow` alone to change font (use `dot rex apply`)
- Putting font/tab prefs in Lua instead of `macos-defaults.conf`