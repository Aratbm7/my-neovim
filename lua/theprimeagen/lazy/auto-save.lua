return {
  {
    "okuuva/auto-save.nvim",
    lazy = false, -- لود همیشگی (مشکلات event پیش نمیاد)
    config = function()
      require("auto-save").setup() -- فقط پیش‌فرض‌ها
      vim.keymap.set("n", "<leader>as", "<cmd>ASToggle<CR>", { desc = "Toggle AutoSave" })
    end,
  },
}
