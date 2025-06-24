return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = "InsertEnter",
  version = "1.*",
  opts = {
    keymap = { preset = "enter" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
  },
}
