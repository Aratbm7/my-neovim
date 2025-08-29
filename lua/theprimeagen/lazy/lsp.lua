return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
          "tsserver",
          "eslint",
          "html",
          "cssls",
          "tailwindcss",
          "emmet_ls",
          "lua_ls",
          "jsonls",
          "yamlls",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- generic on_attach for all LSPs
      local on_attach = function(client, bufnr)
        -- Enable inlay hints if supported (Neovim 0.10+)
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- keymaps for LSP
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end

      -- Rust analyzer config
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
            inlayHints = {
              enable = true,
              typeHints = true,
              parameterHints = true,
              chainingHints = true,
              closingBraceHints = true,
            },
          },
        },
      })

      -- Lua LSP config
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Default setup for others
      local servers = { "tsserver", "eslint", "html", "cssls", "tailwindcss", "emmet_ls", "jsonls", "yamlls" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end
    end,
  },
}

