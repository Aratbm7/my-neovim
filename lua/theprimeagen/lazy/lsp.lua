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
					"pyright",
					"ts_ls",
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
			"mason.nvim",
			"mason-lspconfig.nvim",
			"cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				-- فعال کردن Inlay Hints در نئوویم 0.11+
				if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
				-- کی‌مپ‌های مفید می‌تونی اینجا بذاری، مثلا:
				-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_config = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			lspconfig.rust_analyzer.setup(default_config)

			lspconfig.pyright.setup(default_config)

			lspconfig.ts_ls.setup(vim.tbl_extend("force", default_config, {
				settings = {
					typescript = {
						preferences = {
							disableSuggestions = false,
						},
					},
				},
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			}))

			lspconfig.eslint.setup(vim.tbl_extend("force", default_config, {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				settings = {
					codeActionOnSave = {
						enable = true,
						mode = "all",
					},
				},
			}))

			lspconfig.html.setup(vim.tbl_extend("force", default_config, {
				filetypes = { "html", "htmldjango" },
			}))

			lspconfig.cssls.setup(vim.tbl_extend("force", default_config, {
				settings = {
					css = {
						validate = true,
						lint = { unknownAtRules = "ignore" },
					},
				},
			}))

			lspconfig.emmet_ls.setup(vim.tbl_extend("force", default_config, {
				filetypes = {
					"html",
					"htmldjango",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			}))

			lspconfig.tailwindcss.setup(vim.tbl_extend("force", default_config, {
				filetypes = {
					"html",
					"htmldjango",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			}))

			lspconfig.lua_ls.setup(vim.tbl_extend("force", default_config, {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } },
					},
				},
			}))

			lspconfig.yamlls.setup(vim.tbl_extend("force", default_config, {
				settings = {
					yaml = {
						schemas = {
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
							["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml",
							kubernetes = "*.yaml",
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci*.yml",
						},
						validate = true,
						completion = true,
						hover = true,
					},
				},
				filetypes = { "yaml", "yml" },
			}))

			lspconfig.jsonls.setup(default_config)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
