This file contains information about specific shortcuts/commands to use in neovim

# Shortcuts and Keybindings to know about for your nvim set up

- <space>ch
  - nvim cheat sheet
- :Telescope keymaps
- use `"<backspace>` to see all your commands
- use `'<backspace>` to see all your motions
- use `<leader>u` to see Snacks settings

# Lsp & Formatting

:Mason

# Telescope

- `:Telescope diagnostics` to see all diagnostics in a buffer
- `:Telescope keymaps` to see all keymaps in neovim
- `:Telescope commands` to see all available built-in and user Commands in neovim

## NvimTree

- [full list of nvimtree commands](https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt)
- `y` to yank file name
- `Y` to file name relative to project root
- `gy` to to yank full path

## Themes

- :Telescope themes
  - themes I like
    - doomchad

# Neovim Tips and tricks

- refactor across a project
  - search for the variable with Live Grep `<space>fw` then use `<C-q>` to put the search results into a quick fix in quick fix, you can use `:cdo` to run a command from every result
    - so use `:cdo s/previous/next/gc`
      - `gc` for global check
    - then `:wa` to save all the changes
