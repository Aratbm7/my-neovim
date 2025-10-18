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
					"ts_ls",
					"eslint",
					"html",
					"cssls",
					"tailwindcss",
					"emmet_ls",
					"lua_ls",
					"jsonls",
					"yamlls",
					"rust_analyzer",
					"pyright",
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

			local default_on_attach = function(client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint(bufnr, true)
				end

				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim", "Snacks" } },
					},
				},
				on_attach = default_on_attach,
			})

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
				on_attach = default_on_attach,
			})

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
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
				on_attach = default_on_attach,
			})

			-- TypeScript / JavaScript
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = default_on_attach,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				cmd = { "typescript-language-server", "--stdio" },
			})

			-- ESLint
			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormatingProvider = false
					default_on_attach(client, bufnr)

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			-- Generic servers
			local servers = { "html", "cssls", "tailwindcss", "emmet_ls", "jsonls", "yamlls" }
			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = default_on_attach,
				})
			end
		end,
	},
}
