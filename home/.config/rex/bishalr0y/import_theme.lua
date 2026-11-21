rex.action({
  name = "import_catppuccin_macchiato",
  title = "Import Catppuccin Macchiato Theme",
  category = "Appearance",
  keywords = "theme catppuccin macchiato ghostty dotfiles",
  run = function()
    local home = os.getenv("HOME")
    rex.client.queue("client.theme.import", {
      path = home .. "/.config/rex/themes/catppuccin-macchiato",
    })
  end,
})