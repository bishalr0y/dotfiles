return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  name = "undotree",
  keys = {
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
  },
  config = function()
    require("undotree").setup({
      window = {
        winblend = 10,
      },
    })
  end,
}
