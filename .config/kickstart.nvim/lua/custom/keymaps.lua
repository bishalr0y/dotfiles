-- Split screen
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical Split" })

-- Navigate between splits
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to Left Window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to Lower Window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to Upper Window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to Right Window" })

-- Delete (close) a split
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Close Window" })

-- Close Neovim
vim.keymap.set("n", "<leader>qq", ":quit<CR>", { desc = "Exit" })
