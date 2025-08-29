return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,  -- use treesitter to ignore inside comments/strings
    enable_moveright = true,  -- jump over closing pair when typing
    enable_afterquote = true,  -- auto add closing quote
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)

    -- integrate with nvim-cmp
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done()
    )
  end,
}
