
return {
  {
    "echasnovski/mini.trailspace",
    version = false,
    config = function()
      -- پاک کردن اسپیس‌های اضافی آخر خط
      vim.keymap.set("n", "<leader>ts", function()
        require("mini.trailspace").trim()
      end, { desc = "Trim spaces" })

      -- پاک کردن خط‌های خالی انتهای فایل
      vim.keymap.set("n", "<leader>tl", function()
        require("mini.trailspace").trim_last_lines()
      end, { desc = "Trim last lines" })

      -- حذف خودکار قبل از سیو
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require("mini.trailspace").trim()
        end,
      })
    end,
  },
}

