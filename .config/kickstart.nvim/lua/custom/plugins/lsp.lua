return {
  -- Lazydev for Lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Main LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason for LSP and tool management
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },

      -- LSP status updates
      { "j-hui/fidget.nvim", opts = {} },

      -- Completion capabilities
      { "saghen/blink.cmp" },
    },
    config = function()
      -- LSP Attach: Keymaps and buffer-specific settings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          -- Helper function for key mappings
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Keymaps for LSP actions
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("gra", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gO", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
          map("grt", require("telescope.builtin").lsp_type_definitions, "[T]ype [D]efinition")

          -- Toggle inlay hints if supported
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method("textDocument/inlayHint", { bufnr = event.buf }) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end

          -- Highlight references under cursor
          if client and client.supports_method("textDocument/documentHighlight", { bufnr = event.buf }) then
            local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "user-lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = true },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        },
        virtual_text = { source = true, spacing = 2 },
      })

      -- LSP capabilities with blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Language servers for Go, Python, JavaScript/TypeScript, Bash, and Prisma
      local servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true, -- Stricter formatting
              staticcheck = true, -- Static analysis
              hints = { -- Inlay hints for Go
                parameterNames = true,
                assignVariableTypes = true,
              },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        ts_ls = {
          filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "prisma" },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionLikeReturnTypeHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionLikeReturnTypeHints = true,
              },
            },
          },
        },
        bashls = {},
        prismals = {}, -- Prisma language server
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } }, -- Recognize Neovim globals
            },
          },
        },
      }

      -- Tools to install via Mason
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        "stylua", -- Lua formatter
        "ruff", -- Python linter/formatter
        "prettier", -- JS/TS/Prisma formatter
        "shfmt", -- Bash formatter
      })

      -- Setup Mason and LSPs
      require("mason-tool-installer").setup({
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        ensure_installed = ensure_installed,
      })

      -- Setup Mason for managing external LSP servers
      require("mason").setup({ ui = { border = "rounded" } })
      require("mason-lspconfig").setup()

      -- Configure borders for LspInfo UI and diagnostics
      require("lspconfig.ui.windows").default_options.border = "rounded"

      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        require("lspconfig")[server_name].setup(server)
      end
    end,
  },
}
