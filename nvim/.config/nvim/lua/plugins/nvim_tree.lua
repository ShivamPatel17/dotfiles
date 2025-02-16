return {
  "nvim-tree/nvim-tree.lua",
  opts = {
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
    actions = {
      open_file = {
        resize_window = false, -- Prevent NvimTree from resizing after opening a file
      },
    },
  },
}
