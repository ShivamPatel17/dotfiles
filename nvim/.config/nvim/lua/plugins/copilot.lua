return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Set up Copilot keybindings
      vim.keymap.set("i", "<C-S>", "<Plug>(copilot-next)", { silent = true, desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-A>", "<Plug>(copilot-previous)", { silent = true, desc = "Previous Copilot suggestion" })
      vim.keymap.set("i", "<C-Z>", "<Plug>(copilot-suggest)", { silent = true, desc = "Trigger Copilot suggestion" })
      vim.keymap.set("i", "<C-Q>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.keymap.set("i", "<C-W>", "<Plug>(copilot-accept-word)", {
        silent = true,
        desc = "Accept next Copilot word",
      })
      vim.g.copilot_enabled = false
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_suggestion_auto_trigger = true
      vim.g.copilot_suggestion_multi_line = true
    end,
  },
}
