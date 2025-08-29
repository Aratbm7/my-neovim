return {
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

			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- یا "off" برای حذف strict error
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
				on_attach = function(client, bufnr)
					if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			})
		end,
	},
}

