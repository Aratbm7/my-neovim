return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				start_in_insert = true,
	 			direction = "float",
				shade_terminals = true,
				persist_size = true,
				persist_mode = true,
				float_opts = {
					border = "curved",
					width = function()
						return math.floor(vim.o.columns * 0.8)
					end,
					height = function()
						return math.floor(vim.o.lines * 0.8)
					end,
				},
			})

			local map = vim.keymap.set

			-- حالت‌های مختلف ترمینال
            local Terminal = require("toggleterm.terminal").Terminal
            local float_tmux_term = Terminal:new({
                cmd = "tmux", -- میتونی اینو بزاری "~/.local/scripts/tmux-sessionizer"
                hidden = true,
                direction = "float",
            })
            local horizontal_tmux_term = Terminal:new({
                cmd = "tmux", -- میتونی اینو بزاری "~/.local/scripts/tmux-sessionizer"
                hidden = true,
                direction = "horizontal",
            })
            function toggle_horizontal_tm()
                horizontal_tmux_term:toggle()

            end
            function toggle_float_tm()

                float_tmux_term:toggle()

            end
			-- map("n", "<C-t>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle Terminal افقی" })
			map("n", "<C-t>", toggle_horizontal_tm , { desc = "Toggle Terminal افقی" })
			map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ترمینال Float" })
			map(
				"n",
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical size=80<cr>",
				{ desc = "ترمینال عمودی" }
			)
			map("n", "<leader>to", "<cmd>ToggleTerm direction=tab<cr>", { desc = "ترمینال در تب جدید" })

			-- 🆕 ترمینال اختصاصی برای اجرای tmux


			map("n", "<leader>tm", toggle_float_tm, { desc = "باز کردن tmux در ترمینال شناور" })

			-- سوئیچ راحت بین پنجره‌ها
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				map("t", "<esc>", [[<C-\><C-n>]], opts)
				map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
		end,
	},
}
