return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      -- Map of filetypes to formatters
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt", lsp_format = "fallback" },

        -- Dynamic Python handling:
        -- If ruff is available, use it; otherwise, fallback to isort + black
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,

        -- Frontend & web formats
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },

        -- Elixir
        elixir = { "mix" },

        -- Apply to all filetypes
        ["*"] = { "codespell" },

        -- Fallback if no specific formatter exists
        ["_"] = { "trim_whitespace" },
      },

      -- Default formatting options
      default_format_opts = {
        lsp_format = "fallback", -- Use LSP if no formatter is found
      },

      -- Format on save
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },

      -- Optional: async format after save (you can disable if not needed)
      format_after_save = {
        lsp_format = "fallback",
      },

      -- Logging & notifications
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = true,
    })
  end,
}
