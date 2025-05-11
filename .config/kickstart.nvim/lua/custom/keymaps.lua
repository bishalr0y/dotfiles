-- Split screen
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical Split" })

-- Navigate between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })

-- Delete (close) a split
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close Window" })
