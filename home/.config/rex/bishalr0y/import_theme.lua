rex.action({
  name = "import_carbonfox",
  title = "Import Carbonfox Theme",
  category = "Appearance",
  keywords = "theme carbonfox ghostty dotfiles",
  run = function()
    local home = os.getenv("HOME")
    rex.client.queue("client.theme.import", {
      path = home .. "/.config/rex/themes/carbonfox",
    })
  end,
})