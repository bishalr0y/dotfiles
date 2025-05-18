return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  lazy = false,
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
      -- Keymap to open oil as a floating window
      vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating window" }),

      -- Autocommand to set keymap for closing Oil float with 'q'
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = true, desc = "Close Oil floating window" })
        end,
      }),
    })
  end,
}
