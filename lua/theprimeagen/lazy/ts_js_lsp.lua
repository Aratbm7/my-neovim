return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- JS / TS
    lspconfig.ts_ls.setup({
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      cmd = { "typescript-language-server", "--stdio" },
    })
  end,
}

