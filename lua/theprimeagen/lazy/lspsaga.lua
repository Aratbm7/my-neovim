return {
  {
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- اختیاری ولی بهتره داشته باشی
      'nvim-tree/nvim-web-devicons',     -- اختیاری برای آیکون‌ها
    },
    config = function()
      require('lspsaga').setup({})
    end,
  }
}

