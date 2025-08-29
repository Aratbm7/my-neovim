return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            "*", -- برای همه فایل‌ها
            css = { rgb_fn = true }, -- پشتیبانی از رنگ‌های CSS
            html = { names = true }, -- پشتیبانی از اسم رنگ‌ها
        }, {
            mode = "background", -- رنگ رو توی پس‌زمینه نشون میده (می‌تونی "foreground" یا "virtualtext" هم بذاری)
        })
    end,
}
