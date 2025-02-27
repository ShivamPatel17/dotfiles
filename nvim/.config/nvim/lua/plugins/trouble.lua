return {
  "folke/trouble.nvim",
  opts = {
    win = {
      wo = {
        cursorcolumn = false,
        cursorline = true,
        cursorlineopt = "both",
        fillchars = "eob: ",
        list = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
        spell = false,
        winbar = "",
        statuscolumn = "",
        winfixheight = true,
        winfixwidth = true,
        winhighlight = "Normal:TroubleNormal,NormalNC:TroubleNormalNC,EndOfBuffer:TroubleNormal",
        wrap = true,
      },
    },
    preview = {
      win = "split", -- Options: "split", "float", or "main" (shows preview in the main editor window)
    },
  }, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
