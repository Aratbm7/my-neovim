return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- "fredrikaverpil/neotest-golang",  -- پاک شد
        -- "leoluz/nvim-dap-go",             -- پاک شد
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                --require("neotest-golang")({  -- پاک شد
                --    dap = { justMyCode = false },
                --}),
                require("neotest-python")({
                    dap = { justMyCode = false },
                    runner = "pytest",
                }),
                require("neotest-rust")({}),
            },
        })

        local keymap = vim.keymap.set

        keymap("n", "<leader>tr", function()
            require("neotest").run.run({ suite = false, strategy = "integrated" })
        end, { desc = "Run nearest test" })

        keymap("n", "<leader>tv", function()
            require("neotest").summary.toggle()
        end, { desc = "Toggle test summary" })

        keymap("n", "<leader>ts", function()
            require("neotest").run.run({ suite = true })
        end, { desc = "Run test suite" })

        keymap("n", "<leader>td", function()
            require("neotest").run.run({ strategy = "dap" })
        end, { desc = "Debug nearest test" })

        keymap("n", "<leader>to", function()
            require("neotest").output.open()
        end, { desc = "Open test output" })

        keymap("n", "<leader>ta", function()
            require("neotest").run.run(vim.fn.getcwd())
        end, { desc = "Run all tests in cwd" })
    end,
}

