return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = { theme = "one_monokai", globalstatus = false },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}

