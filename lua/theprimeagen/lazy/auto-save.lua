return {
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" }, -- lazy load
    opts = {
      enabled = true,
      trigger_events = { "TextChanged" },  -- save on every text change
      condition = function(buf)
        return vim.api.nvim_buf_get_option(buf, "modifiable")
      end,
      write_all_buffers = false,
      debounce_delay = 100,  -- milliseconds
    },
    config = function(_, opts)
      require("auto-save").setup(opts)

      -- optional: toggle with <leader>as
      vim.keymap.set("n", "<leader>as", "<cmd>ASToggle<CR>", { desc = "Toggle AutoSave" })
    end,
  },
}

