local nvimtree = require "nvim-tree"

nvimtree.setup {
  git = {
    ignore = false, -- Show gitignored files
  },
  filters = {
    dotfiles = false, -- Show dotfiles
    custom = {}, -- Ensure no extra filters
  },
  view = {
    width = 30, -- Adjust width if needed
  },
}
