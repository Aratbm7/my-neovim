return {

    -- اضافه کردن mason و mason-lspconfig
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },

    -- پلاگین‌های دیگه که نیاز داری مثلا nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
    },
}

