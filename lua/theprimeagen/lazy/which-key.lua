return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"echasnovski/mini.icons", -- برای آیکون‌های بهتر
		"nvim-tree/nvim-web-devicons", -- برای آیکون‌ها
	},
	opts = {
		preset = "modern", -- ظاهر زیبا
		delay = 200, -- تأخیر در نمایش
		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = " Key Hints ",
			title_pos = "center",
			zindex = 1000,
		},
		icons = {
			mappings = true,
			keys = {
				["<leader>"] = "󰘳 ",
				["<space>"] = "␣",
				["<cr>"] = "↵",
				["<tab>"] = "⇥",
			},
		},
		triggers = { "<auto>" }, -- در تمام مودها خودکار فعال بشه
		layout = {
			height = { min = 4, max = 25 },
			width = { min = 20, max = 80 },
			spacing = 3,
			align = "left",
		},
		plugins = {
			marks = true,
			registers = true,
			spelling = { enabled = true, suggestions = 15 },
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}
