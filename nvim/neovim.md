# Neovim Set Up

- everything was initally lifted from [NVChad](https://nvchad.com/)
  - run `NvChadReload` to reload your session with updated configs
- when you mess around with plugins (LSP included), you may need to do a `:Lazy sync` to get things "synced"
- [nvim](../nvim/.config/nvim/) contains your configs

## Things to know about my nvim set up

- [lazy.nvim](https://github.com/folke/lazy.nvim) - plugin manager
- [folke snacks](https://github.com/folke/snacks.nvim)
  - the **nvim.snacks** plugin will look for a lazygit config file which apparently is not created by default so you'll want to create one there
  - [lazygit](https://github.com/jesseduffield/lazygit) - great git terminal ui - the snacks lazygit plugin wraps the lazygit project
- [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter) handles syntax highlightin (run `TSInstallInfo` to see what's installed, and use `TSInstall <language>` here)
  - you'll need to install the actual formatting tool (like "prettier") yourself locally
- [mason]() manages external tools, such as language servers, linters, formatters, and debugger
  - run `:Mason` to see which LSPs are installed
- [nvimtree](https://github.com/nvim-tree/nvim-tree.lua) is your file explorer
- [telescope](https://github.com/nvim-telescope/telescope.nvim) lets your fuzzy find & preview lists
  - find files
  - live grep
- [lspconfig](../nvim/.config/nvim/lua/configs/lspconfig.lua) for autocompletes, go to definition, etc.
- [lazygit](https://github.com/jesseduffield/lazygit) for git UI. I mostly use git cli, but this is useful for viewing diffs & file history

### [lazy.nvim](https://github.com/folke/lazy.nvim)

- you can find the config in `~/.local/share/nvim/`
- lazy gets loaded up by this line `require("lazy").setup "plugins"`
  - Neovim is doing the following:
    - It looks for lazy.nvim in the runtime path.
      - Since NvChad automatically adds lazy.nvim to runtimepath, the require("lazy") statement works.
      - You can verify this by running in Neovim: `echo nvim_list_runtime_paths()`
        - This will show a list of paths where Neovim looks for plugins, including lazy.nvim.
    - It calls the setup function from lazy.nvim.
      - The argument "plugins" refers to a Lua module that should be defined as:

## Cool features from my workflow

- zen mode (`<leader>z`)

## What I like I about neovim

- it only has the features that I want/need/use. After switching to neovim from an IDE, I realize there are so many features in an IDE that I never used or possibly even knew about. By just having the features I want/need, neovim is blazingly fast.
- markdown is a huge part of my workflow - I take all my notes in markdown and I take lots of notes
  - vim's conceallevel setting makes my markdown much more enjoyable to read as I don't need to open a preview of Markdown to get the a nice visual

### Features that I have available to me

- lazygit (git ui)
- Telescope
  - file/text search search
- TreeSitter - for syntax highlighting
- Scratch files
- beautiful ui
  - Zen mode
  - Dimming
  - concealment (great for markdown)
