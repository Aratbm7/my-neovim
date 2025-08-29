return {
  -- 🎨 تم TokyoNight (شبیه VSCode)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night", transparent = false },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- ⚙️ تنظیمات پایه
  {
    "LazyVim/LazyVim",
    opts = function()
      -- همیشه UTF-8
      vim.o.encoding = "utf-8"
      vim.o.fileencoding = "utf-8"
      vim.o.fileencodings = "utf-8,utf-16,ucs-bom,latin1"

      -- ❌ بدون RTL یا arabic
      vim.o.rightleft = false
      vim.o.arabic = false
      vim.o.arabicshape = true
      vim.o.termbidi = true

      -- 🎨 فقط یک فونت GUI (JetBrains Mono)
        if vim.g.neovide then
          vim.o.guifont = "JetBrains Mono:h13"  -- فونت فارسی و لاتین
        elseif vim.g.goneovim then
          vim.o.guifont = "JetBrains Mono:h13"
        end

      -- 📋 کلیپ‌بورد
      vim.o.clipboard = "unnamedplus"
    end,
  },
}

