return {
	"nvzone/showkeys",
	cmd = "ShowkeysToggle",
	opts = {
		position = "top-center", -- نمایش بالا وسط
		timeout = 3,
		maxkeys = 5,
		show_count = true,
		winopts = {
			width = 50,
			height = 1,
			border = "rounded",
			zindex = 200,
		},

		-- رنگ و استایل پنجره
		winhl = "Normal:ShowKeysNormal,FloatBorder:ShowKeysBorder",
	},
	config = function(_, opts)
		require("showkeys").setup(opts)

		-- 🎨 رنگ نئونی آبی براق
		vim.api.nvim_set_hl(0, "ShowKeysNormal", {
			fg = "#00FFAA", -- آبی روشن برای متن
			bg = "#0D1117", -- پس‌زمینه تیره برای کنتراست
			bold = true,
		})

		vim.api.nvim_set_hl(0, "ShowKeysBorder", {
			fg = "#00BFFF", -- آبی براق (Deep Sky Blue)
			bg = "#0D1117",
		})
	end,
}
