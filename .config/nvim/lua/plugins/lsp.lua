return {
  -- Lazydev for Lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { "${3rd}/luv/library" },
    },
  },

  -- Main LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
      { "saghen/blink.cmp" },
    },
    config = function()
      -- LSP Attach: Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          -- Twoslash queries
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == "ts_ls" then
            require("twoslash-queries").attach(client, event.buf)
          end

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("gra", vim.lsp.buf.code_action, "[C]ode [A]ction")
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          -- Keymap to show diagnostic float (optional, for details)
          map("gl", vim.diagnostic.open_float, "Show [L]ine Diagnostics")

          -- Remap K for rounded borders
          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({
              border = "rounded",
            })
          end, { buffer = event.buf })
        end,
      })

      -- Diagnostic configuration with virtual text
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = {
          source = true, -- Show the source (e.g., "pyright", "gopls")
          spacing = 2, -- Space between code and diagnostic
          prefix = "■", -- Symbol before diagnostic message
        },
        float = {
          border = "rounded",
          source = true,
        },
      })

      -- LSP capabilities with blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Language servers
      local servers = {
        gopls = { settings = { gopls = { gofumpt = true, staticcheck = true } } },
        pyright = {},
        ts_ls = {},
        bashls = {},
        prismals = {},
        lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
        oxlint = {
          root_markers = { ".oxlintrc.json" },
        },
        biome = {},
        prettierd = {},
        prettier = {},
      }

      -- Tools to install via Mason
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { "stylua", "ruff", "prettier", "shfmt", "gopls", "gofumpt" })

      -- Setup Mason and LSPs
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason").setup({ ui = { border = "rounded" } })
      require("lspconfig.ui.windows").default_options.border = "rounded"
      require("mason-lspconfig").setup({
        handlers = {
          -- The first entry (without a key) will be the default handler.
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              settings = servers.gopls.settings,
              capabilities = capabilities,
            })
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = servers.lua_ls.settings,
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },
}
