local plugins = {
  -- Skip jsregexp build (broken submodule), everything else stays as NvChad default
  { "L3MON4D3/LuaSnip", build = "" },

  -- Override nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "nvchad.configs.cmp"

      -- Remove C-n (conflicts with jumplist remap)
      M.mapping["<C-n>"] = nil

      return M
    end,
  },
}

return plugins
