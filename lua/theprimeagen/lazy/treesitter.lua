-- =========================
-- NVIM TREESITTER CONFIG
-- =========================
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                    "jsdoc", "bash", "python",
                },
                sync_install = false,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },

                indent = {
                    enable = true,
                },
            })

            -- Fold با Tree-sitter
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            vim.opt.foldlevel = 99      -- همه fold ها باز باشند
            vim.opt.foldenable = true   -- فعال کردن fold

            -- میانبرهای fold
            vim.keymap.set("n", "zo", "zo", { desc = "Open fold" })
            vim.keymap.set("n", "zc", "zc", { desc = "Close fold" })
            vim.keymap.set("n", "za", "za", { desc = "Toggle fold" })
            vim.keymap.set("n", "zR", "zR", { desc = "Open all folds" })
            vim.keymap.set("n", "zM", "zM", { desc = "Close all folds" })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require'treesitter-context'.setup{
                enable = true,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = 'outer',
                mode = 'cursor',
                separator = nil,
                zindex = 20,
            }

            -- میانبر برای روشن/خاموش کردن پنجره context
            vim.keymap.set("n", "<leader>tc", function()
                require("treesitter-context").toggle()
            end, { desc = "Toggle Treesitter Context" })
        end
    }
}

