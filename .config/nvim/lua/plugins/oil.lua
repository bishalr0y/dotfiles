return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    view_options = {
      show_hidden = true,
    },
    confirmation = {
      border = "rounded",
    },
    float = {
      border = "rounded",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>e",
      function()
        require("oil").toggle_float()
      end,
      desc = "Open parent directory in floating window",
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = true, desc = "Close Oil floating window" })
        vim.opt_local.colorcolumn = ""
      end,
    })
  end,
}
