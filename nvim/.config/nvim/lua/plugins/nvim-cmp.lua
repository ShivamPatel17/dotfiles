-- Example: lua/plugins/init.lua
local plugins = {

  -- Override nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "nvchad.configs.cmp"
      local cmp = require "cmp"

      -- Setting to nil removes it from the table
      M.mapping["<C-n>"] = nil

      -- -- Setting to cmp.config.disable ensures it's completely ignored
      -- M.mapping["<C-n>"] = cmp.config.disable

      return M
    end,
  },

  -- Your other plugins...
}

return plugins
