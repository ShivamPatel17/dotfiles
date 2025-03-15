return {
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins.conform" },
  { import = "plugins.csv" },
  { import = "plugins.dad_bod" },
  { import = "plugins.godoc" },
  { import = "plugins.nvim_tree" },
  { import = "plugins.telescope" },
  { import = "plugins.treesitter" },
  { import = "plugins.trouble" },
  { import = "plugins.snacks" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup {
        disable_when_zoomed = true, -- defaults to false
      }
    end,
  },
}
