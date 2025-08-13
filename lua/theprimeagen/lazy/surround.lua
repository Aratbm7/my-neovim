return {
  {
    'tpope/vim-surround',
    event = "VeryLazy", -- به صورت lazy بارگذاری می‌شود، هنگام شروع سریع نئووی‌آی‌ام لود نمی‌شود
    config = function()
      -- پلاگین vim-surround تنظیم خاصی نیاز نداره چون بیشتر کی‌مپ‌ها خودش ساخته شده‌اند.

      -- توضیح کلی کی‌مپ‌های surround:
      -- cs{old}{new}   : change surrounding {old} to {new}
      -- ds{char}       : delete surrounding {char}
      -- ys{motion}{char} : add surrounding {char} around text covered by motion
      -- ysiw{char}     : add surrounding {char} around inner word
      -- yss{char}      : add surrounding {char} around entire line
      -- Visual Mode:
      -- S{char}        : add surrounding {char} around selected text

      -- مثال‌ها:
      -- cs"'   : تبدیل "Hello" به 'Hello'
      -- ds"    : حذف کوتیشن از اطراف متن
      -- ysiw]  : دور کلمه فعلی کروشه []
      -- yss(   : دور کل خط پرانتز ()

      -- نکته: این پلاگین نیازی به تنظیمات پیچیده نداره و کی‌مپ‌ها از پیش تعریف شدند.
      -- می‌تونی با اجرای :help surround.vim داخل نئووی‌آی‌ام کامل مستندات رو ببینی.
    end,
  }
}

