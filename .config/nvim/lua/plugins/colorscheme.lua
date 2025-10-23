return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        -- transparent_background = true,
        -- no_bold = false,
        -- no_italic = false,
        -- no_underline = false,
        styles = {
          comments = { "italic" },
        },
      })
      local palette = require("catppuccin.palettes").get_palette("macchiato")
      vim.cmd.colorscheme("catppuccin-macchiato")

      -- Telescope highlights to match editor background
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = palette.blue, bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = palette.blue, bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = palette.blue, bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = palette.blue, bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = palette.mauve, bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = palette.mauve, bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = palette.mauve, bg = palette.base })
      vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = palette.mauve, bg = palette.base })
    end,
  },
}
