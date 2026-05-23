local plugins = {
  -- Disable LuaSnip and its cmp source
  { "L3MON4D3/LuaSnip", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },

  -- Override nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "nvchad.configs.cmp"
      local cmp = require "cmp"

      -- Remove luasnip source
      M.sources = vim.tbl_filter(function(s)
        return s.name ~= "luasnip"
      end, M.sources)

      -- Use Neovim's built-in snippet engine instead of luasnip
      M.snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      }

      M.mapping["<C-n>"] = nil
      M.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s" })
      M.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" })

      return M
    end,
  },
}

return plugins
