require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy_init")

-- Disable netrw (must be before plugins)
-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
--i end
-- DO NOT INCLUDE THIS
-- For Neovide
vim.g.neovide_font = "JetBrains Mono:h13" -- h14 is size, adjust as needed
vim.g.neovide_opacity = 0.9 -- optional transparency
vim.o.mouse = "a"
vim.o.autoread = true
vim.o.autowrite = true
vim.o.confirm = false
vim.g.neovide_fullscreen = false -- باز شدن در حالت فول‌اسکرین
vim.g.neovide_window_width = 1200
vim.g.neovide_window_height = 800

-- یا به صورت نسبتی (scale factor مثل زوم VS Code)
vim.g.neovide_scale_factor = 1.0
vim.keymap.set("n", "<C-=>", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
end, { desc = "Zoom in" })

vim.keymap.set("n", "<C-->", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
end, { desc = "Zoom out" })
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_cursor_vfx_mode = "torpedo"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_input_use_logo = 1
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<leader>co", function()
  local cmd = vim.fn.input("Command: ")
  if cmd == "" then return end
  local output = vim.api.nvim_exec2(cmd, { output = true }).output
  vim.fn.setreg("+", output)
  print("Output of :" .. cmd .. " copied to clipboard!")
end, { desc = "Copy command output to clipboard" })
-- DO.not
-- viim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.lazyvim_check_order = false
local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup("ThePrimeagen", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = ThePrimeagenGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("BufEnter", {
	group = ThePrimeagenGroup,
	callback = function()
	if vim.bo.filetype == "zig" then
			pcall(vim.cmd.colorscheme, "tokyonight-night")
		else
			pcall(vim.cmd.colorscheme, "rose-pine-moon")
		end
	end,
})

autocmd("LspAttach", {
	group = ThePrimeagenGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
