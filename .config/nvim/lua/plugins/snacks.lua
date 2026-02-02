return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  --@type Snacks.config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = {
      enabled = true,
      indent = {
        enabled = false,
      },
    },
    words = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "fancy",
    },
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
