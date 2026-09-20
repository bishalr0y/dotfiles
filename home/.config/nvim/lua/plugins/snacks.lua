return {
  {
    "folke/snacks.nvim",
    opts = {
      words = {
        enabled = false,
      },
      explorer = {
        hidden = true,
      },
      picker = {
        sources = {
          files = {
            hidden = true,
            exclude = { "node_modules" },
          },
          git = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
    },
  },
}
