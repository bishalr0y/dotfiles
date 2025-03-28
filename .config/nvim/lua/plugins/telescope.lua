return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "bottom" },
      sorting_strategy = "ascending",
      winblend = 0,
      find_command = { "rg", "--files", "--hidden", "--no-ignore" },
    },
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },

    pickers = {
      find_files = {
        hidden = true,
        no_ignore = true,
      },
    },
  },
}
