return {
  {
    "folke/tokyonight.nvim",
    lazy = false,     -- قبل از بقیه لود بشه
    priority = 1000,  -- مطمئن بشه که زودتر ست میشه
    opts = {
      style = "night", -- می‌تونی "storm", "day", "moon" هم بذاری
      transparent = false, -- یا true اگه بک‌گراند شفاف می‌خوای
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}

