return {
  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      -- باز کردن فایل اکسپلورر
      vim.keymap.set("n", "<leader>fe", function()
        require("mini.files").open()
      end, { desc = "File Explorer" })

      -- باز کردن در مسیر فایل فعلی
      vim.keymap.set("n", "<leader>fd", function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0))
      end, { desc = "File Explorer (cwd)" })
    end,
  },
}
