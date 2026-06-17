return {
  "olexsmir/gopher.nvim",
  ft = "go",
  build = function()
    vim.cmd.GoInstallDeps()
  end,
  opts = {},
}
