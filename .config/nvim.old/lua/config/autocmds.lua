-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable Unnecessary highlights
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Prevent LSP references from getting a background
    vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "NONE", fg = "NONE" })

    -- Prevent SnippetTabstop from linking to Visual
    vim.api.nvim_set_hl(0, "SnippetTabstop", { bg = "NONE", fg = "NONE" })

    -- Remove any unwanted background colors
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

    -- make the cursor line bg transparent
    -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
  end,
})
