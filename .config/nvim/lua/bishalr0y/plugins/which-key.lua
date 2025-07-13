return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<leader>c",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "code",
    },
    {
      "<leader>x",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "trouble",
    },
    {
      "<leader>l",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "lazygit",
    },
    {
      "<leader>f",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "find/files",
    },
    {
      "<leader>w",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "window",
    },
    {
      "<leader>q",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "quit",
    },
  },
}
