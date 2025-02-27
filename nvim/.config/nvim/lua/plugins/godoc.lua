return {
  "fredrikaverpil/godoc.nvim",
  version = "*",
  dependencies = {
    { "folke/snacks.nvim" }, -- optional
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "go" },
      },
    },
  },
  build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
  cmd = { "GoDoc" }, -- optional
  opts = {
    adapters = {
      -- for details, see lua/godoc/adapters/go.lua
      {
        name = "go",
        opts = {
          command = "GoDoc", -- the vim command to invoke Go documentation
          get_syntax_info = function()
            return {
              filetype = "godoc", -- filetype for the buffer
              language = "go", -- tree-sitter parser, for syntax highlighting
            }
          end,
        },
      },
    },
    window = {
      type = "split", -- split | vsplit
    },
    picker = {
      type = "snacks", -- native (vim.ui.select) | telescope | snacks | mini

      -- see respective picker in lua/godoc/pickers for available options
      native = {},
      telescope = {},
      snacks = {},
      mini = {},
    },
  },
}
