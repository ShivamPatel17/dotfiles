return {
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins.telescope" },

  { import = "plugins.snacks" },

  { import = "plugins.conform" },

  { import = "plugins.dad_bod" },

  { import = "plugins.csv" },

  { import = "plugins.nvim_tree" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
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
