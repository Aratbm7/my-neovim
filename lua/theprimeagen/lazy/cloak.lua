return {
    "laytan/cloak.nvim",
    config = function()
        local cloak = require("cloak")


        cloak.setup({
            enabled = true,
            cloak_character = "*",
            highlight_group = "Comment",
            patterns = {
                {
                    file_pattern = {
                        ".env*",
                        "wrangler.toml",
                        ".dev.vars",
                    },
                    cloak_pattern = "=.+"
                },
            },
        })

        -- کلید میانبر برای روشن/خاموش کردن Cloak
        vim.keymap.set("n", "<leader>q", function()
            cloak.toggle()
        end, { desc = "Toggle Cloak" })
    end
}
