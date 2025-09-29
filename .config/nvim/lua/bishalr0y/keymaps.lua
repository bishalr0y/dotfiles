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

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>cl", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show line diagnostic" })
vim.keymap.set("n", "<leader>cm", ":Mason<CR>", { desc = "Mason" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Move line up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Reselect visual selection after indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Press "H" and "L" to jump to start and end of the line
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")

-- Press U for redo
vim.keymap.set("n", "U", "<C-r>")
