return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                rust = { "rustfmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                -- اگر tailwindcss formatter مستقل مدنظرته، می‌تونیم پلاگین یا دستور جدا بذاریم، اما prettier با پلاگین tailwindcss معمولا استفاده میشه
                elixir = { "mix" }
            }
        })
    end
}
