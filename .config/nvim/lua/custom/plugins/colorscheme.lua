return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        no_bold = false,
        no_italic = true,
        no_underline = false,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
