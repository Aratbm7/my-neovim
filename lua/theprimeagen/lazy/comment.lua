return {
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',  -- برای پشتیبانی jsx/tsx
    },
    opts = {
      padding = true,
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = function(ctx)
        -- استفاده از pre_hook مربوط به nvim-ts-context-commentstring برای jsx/tsx
        local ts_context_commentstring = require('ts_context_commentstring.integrations.comment_nvim')
        return ts_context_commentstring.create_pre_hook()(ctx)
      end,
      ignore = nil,
    },
  }
}
-- | مد     | دستور        | کارکرد                                      |
-- | ------ | ------------ | ------------------------------------------- |
-- | Normal | `gcc`        | کامنت/آن‌کامنت خط جاری (linewise)           |
-- | Normal | `gbc`        | کامنت/آن‌کامنت خط جاری (blockwise)          |
-- | Normal | `gc{motion}` | کامنت/آن‌کامنت محدوده حرکت (linewise)       |
-- | Normal | `gb{motion}` | کامنت/آن‌کامنت محدوده حرکت (blockwise)      |
-- | Visual | `gc`         | کامنت/آن‌کامنت ناحیه انتخاب شده (linewise)  |
-- | Visual | `gb`         | کامنت/آن‌کامنت ناحیه انتخاب شده (blockwise) |
-- | Normal | `gco`        | اضافه کردن خط کامنت زیر خط جاری             |
-- | Normal | `gcO`        | اضافه کردن خط کامنت بالای خط جاری           |
-- | Normal | `gcA`        | اضافه کردن کامنت در انتهای خط جاری          |
--
