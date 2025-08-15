-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M = {
  base46 = {

    theme = "doomchad",

    hl_override = {
      LspSignatureActiveParameter = { fg = "#62de9c", bg = "#007ACC" },
    },
  },

  ui = {
    cmp = {
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = {
        lsp = true,
      },
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    statusline = {
      theme = "minimal", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "block",
      order = nil,
      modules = {
        lsp = function()
          local stbufnr = function()
            return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
          end
          if rawget(vim, "lsp") then
            for _, client in ipairs(vim.lsp.get_clients()) do
              if client.attached_buffers[stbufnr()] and client.name ~= "GitHub Copilot" then
                return (vim.o.columns > 100 and " " .. client.name .. " ") or "   LSP "
              end
            end
          end

          return "NA"
        end,
      },
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true,
      lazyload = true,
      order = { "treeOffset", "buffers" },
      modules = nil,
      bufwidth = 21,
    },
  },
}

return M
