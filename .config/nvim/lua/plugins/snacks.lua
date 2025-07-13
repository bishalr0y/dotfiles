return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  --@type Snacks.config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    words = { enabled = true },
    notifier = { enabled = true },
  },
  keys = {
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
  },
}
