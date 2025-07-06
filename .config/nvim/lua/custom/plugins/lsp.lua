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
    -- lazy = true,
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
        -- gopls = { settings = { gopls = { gofumpt = true, staticcheck = false } } },
        gopls = {},
        pyright = {},
        ts_ls = { filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "prisma" } },
        bashls = {},
        prismals = {},
        lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
      }

      -- Tools to install via Mason
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { "stylua", "ruff", "prettier", "shfmt" })

      -- Setup Mason and LSPs
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason").setup()
      require("mason-lspconfig").setup()

      for server_name, server in pairs(servers) do
        server.capabilities = capabilities
        require("lspconfig")[server_name].setup(server)
      end
    end,
  },
}
