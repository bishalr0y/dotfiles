-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- set text wrap
vim.cmd("set textwidth=0")
vim.cmd("set wrapmargin=0")
vim.cmd("set wrap")
vim.cmd("set linebreak")

-- disable cursor line
-- vim.cmd("set nocursorline")

-- make the cursor line bg transparent
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })

vim.opt.scrolloff = 8

vim.opt.hlsearch = false
vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false

-- Get rid of unneccessary highlights
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "NONE", fg = "NONE" })

-- Prevent SnippetTabstop from linking to Visual
vim.api.nvim_set_hl(0, "SnippetTabstop", { bg = "NONE", fg = "NONE" })

-- Remove any unwanted background colors
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
