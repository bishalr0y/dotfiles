return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        styles = {
          comments = { italic = true },
        },
      })
      vim.cmd.colorscheme("tokyonight-night")
      -- Make the Cursor line transparent
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
    end,
  },
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
        no_italic = false,
        no_underline = false,
      })
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
}
