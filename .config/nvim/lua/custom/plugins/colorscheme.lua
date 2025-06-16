return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_transparent_background = 0 --values (0,1,2)

      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
      })
      -- vim.cmd.colorscheme("tokyonight-night")
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
