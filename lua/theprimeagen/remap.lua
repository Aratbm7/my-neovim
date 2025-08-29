vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- Toggle Snacks Explorer with <leader>pv

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.api.nvim_set_keymap("n", "<leader>tp", "<Plug>PlenaryTestFile", { noremap = false, silent = false })
--
--Change copy keymaps
vim.api.nvim_set_keymap(
	"n",
	"<leader>o",
	":lua require('snacks').explorer.open()<CR>",
	{ noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- =========================
-- 🔹 Yank/Cut -> System Clipboard
-- =========================

-- Normal mode: همه yanks به clipboard
vim.keymap.set("n", "y", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "yy", '"+yy', { noremap = true, silent = true })
vim.keymap.set("n", "yw", '"+yw', { noremap = true, silent = true })

-- Visual mode: همه yanks به clipboard
vim.keymap.set("v", "y", '"+y', { noremap = true, silent = true })
vim.keymap.set("v", "d", '"+d', { noremap = true, silent = true }) -- cut به clipboard

-- Normal mode: cut به clipboard
vim.keymap.set("n", "d", '"+d', { noremap = true, silent = true })
vim.keymap.set("n", "dd", '"+dd', { noremap = true, silent = true })

-- Paste از clipboard سیستم
vim.keymap.set("n", "p", '"+p', { noremap = true, silent = true })
vim.keymap.set("n", "P", '"+P', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })

-- اگر بخوای yank کلمه زیر cursor هم مستقیم بره clipboard
vim.keymap.set("n", "yiw", '"+yiw', { noremap = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
--vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

--vim.keymap.set("n", "<leader>vwm", function()
--    require("vim-with-me").StartVimWithMe()
--end)

-- greatest remap ever
vim.keymap.set("n", "<A-k>", ":horizontal resize +3<CR>", { silent = true })
vim.keymap.set("n", "<A-j>", ":horizontal resize -3<CR>", { silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
--
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This isgoing to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- جابجایی بین پنجره‌ها با <leader>w + j/k/h/l
vim.keymap.set("n", "<leader>wh", "<C-w>h", { silent = true, desc = "پنجره سمت چپ" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { silent = true, desc = "پنجره پایین" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { silent = true, desc = "پنجره بالا" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { silent = true, desc = "پنجره سمت راست" })

vim.keymap.set("n", "<leader>wf", ":w<CR>", { desc = "Save file" })
--[[ vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a"
)

vim.keymap.set(
    "n",
    "<leader>ef",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)
--]]

vim.keymap.set("n", "<leader>ca", function()
	require("cellular-automaton").start_animation("make_it_rain")
end)

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

local opts = { noremap = true, silent = true }

-- رفتن به تعریف (Function/Class/Variable)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))

-- رفتن به Declaration (معمولاً برای تعریف متغیرهای global یا imports)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))

-- پیدا کردن Implementations (وقتی Interface داری یا متد override شده)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))

-- لیست References (کجا این متغیر/تابع استفاده شده)
vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to References" }))

-- رفتن به Type Definition (نوع داده/کلاس اصلی)
vim.keymap.set(
	"n",
	"gt",
	vim.lsp.buf.type_definition,
	vim.tbl_extend("force", opts, { desc = "Go to Type Definition" })
)
vim.keymap.set("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end, { desc = "Toggle Inlay Hints" })

