return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { "${3rd}/luv/library" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
      { "saghen/blink.cmp" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_clients({ id = event.data.client_id })[1]
          if client and client.name == "vtsls" then
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
          map("gl", vim.diagnostic.open_float, "Show [L]ine Diagnostics")

          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
          end, { buffer = event.buf })
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = false,
        float = { border = "rounded", source = true },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

      local servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              staticcheck = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        vtsls = {
          filetypes = {
            "javascript", "javascriptreact", "javascript.jsx",
            "typescript", "typescriptreact", "typescript.tsx",
          },
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
              },
            },
            javascript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
              },
            },
          },
        },
        tailwindcss = {
          filetypes = { "typescriptreact", "javascriptreact", "html", "svelte", "astro" },
        },
        html = {},
        cssls = {},
        pyright = {},
        bashls = {},
        prismals = {},
        lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
        oxlint = { root_markers = { ".oxlintrc.json" } },
        biome = {},
        prettierd = {},
        prettier = {},
      }

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        "stylua", "ruff", "prettier", "shfmt", "gopls", "gofumpt",
        "goimports", "oxfmt", "biome", "prisma-language-server",
      })

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason").setup({ ui = { border = "rounded" } })
      require("lspconfig.ui.windows").default_options.border = "rounded"
      require("mason-lspconfig").setup()
      require("fidget").setup({})

      for name, config in pairs(servers) do
        vim.lsp.config(name, {
          cmd = config.cmd,
          capabilities = capabilities,
          filetypes = config.filetypes,
          settings = config.settings,
          root_markers = config.root_markers,
        })
        vim.lsp.enable(name)
      end
    end,
  },
}
