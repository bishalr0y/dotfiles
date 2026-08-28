-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Splits
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Close Window" })
vim.keymap.set("n", "<leader>qq", ":quit<CR>", { desc = "Exit" })

-- Move line/selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Line navigation
vim.keymap.set("n", "L", "$", { desc = "End of line" })
vim.keymap.set("n", "H", "^", { desc = "Start of line" })

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })
