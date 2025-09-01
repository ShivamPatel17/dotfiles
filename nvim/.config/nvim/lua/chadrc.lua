-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M = {
  base46 = {

    theme = "doomchad",

    hl_add = {
      ["NormalNC"] = { bg = "black" },
    },

    hl_override = {
      LspSignatureActiveParameter = { fg = "#62de9c", bg = "#007ACC" },
      Normal = {
        bg = { "black", 3 },
      },
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
      theme = "vscode_colored",
      separator_style = "block",
      order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd" },

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
          return ""
        end,

        -- macro = function()
        --   local ok, noice = pcall(require, "noice")
        --   if not ok then
        --     return "macro error in chadrc.lua"
        --   end
        --   if noice.api.status.mode.has() then
        --     return " " .. noice.api.status.mode.get_hl() .. " "
        --   end
        --   return ""
        -- end,
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
