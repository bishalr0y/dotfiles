vim.api.nvim_create_user_command("ConformDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable conform-autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("ConformEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable conform-autoformat-on-save",
})

return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = false,
    default_format_opts = {
      async = true,
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    format_after_save = function(buffer_number)
      if vim.g.disable_autoformat or vim.b[buffer_number].disable_autoformat then
        return
      end
      return {
        async = true,
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
      typescript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
      typescriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
      go = { "goimports", "gofumpt" },
    },
    formatters = {
      goimports = {
        command = vim.fn.stdpath("data") .. "/mason/bin/goimports",
        stdin = true,
      },
      golines = {
        command = vim.fn.stdpath("data") .. "/mason/bin/golines",
        args = { "-m", "120" },
        stdin = true,
      },
      gofumpt = {
        command = vim.fn.stdpath("data") .. "/mason/bin/gofumpt",
        stdin = true,
      },
      oxfmt = {},
      biome = {},
      prettierd = {},
      gofmt = {
        command = "gofmt",
        args = { "-s" },
        stdin = true,
      },
    },
  },
}
