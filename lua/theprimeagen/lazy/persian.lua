-- فایل: ~/.config/nvim/lua/plugins/persian.lua
-- تنظیمات فارسی برای LazyVim (بدون پلاگین خارجی)

return {
  -- پلاگین بهبود cursor و highlight
  {
    "yamatsum/nvim-cursorline",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('nvim-cursorline').setup({
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 2,
          hl = { underline = true },
        }
      })
    end,
  },

  -- تنظیمات فارسی با استفاده از پلاگین dummy
  {
    "LazyVim/LazyVim",
    opts = function()
      -- تنظیمات پایه فارسی
      vim.opt.encoding = 'utf-8'
      vim.opt.fileencoding = 'utf-8'
      vim.opt.fileencodings = 'utf-8,ucs-bom,default,latin1'

      -- تنظیمات RTL و فارسی
      vim.opt.rightleft = false
      vim.opt.rightleftcmd = 'search'
      vim.opt.ambiwidth = 'single'
      vim.opt.arabicshape = true
      vim.opt.termbidi = true
      vim.opt.arabic = false

      -- تنظیم فونت برای GUI
      if vim.g.neovide then
        vim.o.guifont = "JetBrains Mono,Vazir Code:h12"
      elseif vim.g.goneovim then
        vim.o.guifont = "Vazir Code:h12"
      end

      -- بهبود clipboard برای متن فارسی
      vim.opt.clipboard = 'unnamedplus'
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- توابع کمکی برای فارسی
      _G.PersianUtils = {
        -- تبدیل اعداد انگلیسی به فارسی
        to_persian_numbers = function(text)
          local persian_digits = {"۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"}
          return text:gsub("%d", function(d) return persian_digits[tonumber(d) + 1] end)
        end,

        -- تبدیل اعداد فارسی به انگلیسی
        to_english_numbers = function(text)
          local english_digits = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
          local persian_digits = {"۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"}
          for i, persian in ipairs(persian_digits) do
            text = text:gsub(persian, english_digits[i])
          end
          return text
        end,

        -- toggle RTL mode
        toggle_rtl = function()
          vim.opt.rightleft = not vim.opt.rightleft:get()
          if vim.opt.rightleft:get() then
            vim.notify("حالت راست به چپ فعال شد", vim.log.levels.INFO, { title = "Persian Mode" })
          else
            vim.notify("حالت چپ به راست فعال شد", vim.log.levels.INFO, { title = "Persian Mode" })
          end
        end,

        -- فعال کردن حالت فارسی
        enable_persian = function()
          vim.opt.rightleft = true
          vim.opt.arabic = true
          vim.notify("حالت فارسی/عربی فعال شد", vim.log.levels.INFO, { title = "Persian Mode" })
        end,

        -- فعال کردن حالت انگلیسی
        enable_english = function()
          vim.opt.rightleft = false
          vim.opt.arabic = false
          vim.notify("English mode enabled", vim.log.levels.INFO, { title = "Persian Mode" })
        end,
      }

      -- دستورات کاربردی
      vim.api.nvim_create_user_command("PersianNumbers", function()
        local line = vim.api.nvim_get_current_line()
        local new_line = PersianUtils.to_persian_numbers(line)
        vim.api.nvim_set_current_line(new_line)
      end, { desc = "Convert numbers to Persian" })

      vim.api.nvim_create_user_command("EnglishNumbers", function()
        local line = vim.api.nvim_get_current_line()
        local new_line = PersianUtils.to_english_numbers(line)
        vim.api.nvim_set_current_line(new_line)
      end, { desc = "Convert numbers to English" })
    end,

    keys = {
      -- استفاده از F9 به جای F8 (چون F8 برای tagbar است)
      {
        "<F9>",
        function()
          PersianUtils.toggle_rtl()
        end,
        desc = "Toggle RTL/LTR",
        mode = "n"
      },

      -- تغییر زبان در Insert mode
      {
        "<C-Space>",
        "<C-^>",
        desc = "Toggle language input",
        mode = "i"
      },

      -- فعال کردن حالت فارسی کامل
      {
        "<leader>pa",
        function()
          PersianUtils.enable_persian()
        end,
        desc = "Enable Persian/Arabic mode",
        mode = "n"
      },

      -- بازگشت به حالت انگلیسی
      {
        "<leader>ea",
        function()
          PersianUtils.enable_english()
        end,
        desc = "Enable English mode",
        mode = "n"
      },

      -- تبدیل اعداد به فارسی
      {
        "<leader>pn",
        ":PersianNumbers<CR>",
        desc = "Convert numbers to Persian",
        mode = "n"
      },

      -- تبدیل اعداد به انگلیسی
      {
        "<leader>pN",
        ":EnglishNumbers<CR>",
        desc = "Convert numbers to English",
        mode = "n"
      },
    },
  },

  -- بهبود آیکون‌ها برای فایل‌های فارسی
  {
    "nvim-tree/nvim-web-devicons",
    optional = true,
    opts = {
      override_by_extension = {
        ["fa"] = {
          icon = "ف",
          color = "#519aba",
          cterm_color = "74",
          name = "Persian"
        },
      },
    },
  },

  -- تنظیمات which-key برای نمایش کلیدهای فارسی
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      local wk = require("which-key")
      wk.add({
        { "<leader>p", group = "persian", icon = "ف" },
        { "<F9>", desc = "Toggle RTL/LTR", icon = "⇄" },
        { "<leader>pf", desc = "Enable Persian mode", icon = "ف" },
        { "<leader>pe", desc = "Enable English mode", icon = "E" },
        { "<leader>pn", desc = "Convert to Persian numbers", icon = "۱" },
        { "<leader>pN", desc = "Convert to English numbers", icon = "1" },
      })
    end,
  },
}
