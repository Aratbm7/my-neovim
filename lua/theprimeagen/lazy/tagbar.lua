return {
  {
    "preservim/tagbar",
    config = function()
      -- تنظیم کلید F8 برای باز/بسته کردن پنجره tagbar
      vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", { noremap = true, silent = true })

      -- اگر ctags در مسیر متفاوتی است، می‌توانید اینجا تنظیم کنید:
      -- vim.g.tagbar_ctags_bin = "/usr/local/bin/ctags"
    end,
  },
}

