-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Hide the diagnostic in Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("user-diagnostic-toggle", { clear = true }),
  callback = function()
    vim.diagnostic.hide(nil, 0)
  end,
})
