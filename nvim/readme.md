# Getting Started

- followed along the "Turn VIM into a full featured IDE with only one command" by dreams of code youtube

## Prereqs

1. neovim

```
brew install neovim
```

2. lazygit

```
brew install lazygit
```

3. formatters

- prettier (through ASDF node.js)
- stylua (through ASDF)

4. mic

`brew install luarocks`

# about this set up

- everything was initally lifted from [NVChad](https://nvchad.com/)
  - run `NvChadReload` to reload your session with updated configs
- when you mess around with plugins (LSP included), you may need to do a `:Lazy sync` to get things "synced"
- the [lua config](./lua/configs) contains your configs
  - to get more language support, you need to update the [lspconfg](./lua/configs/lspconfig.lua)

## Things to know about my nvim set up

- [folke snacks](https://github.com/folke/snacks.nvim)
  - the **nvim.snacks** plugin will look for a lazygit config file which apparently is not created by default so you'll want to create one there
  - [lazygit](https://github.com/jesseduffield/lazygit) - great git terminal ui - the snacks lazygit plugin wraps the lazygit project
- [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter) handles syntax highlightin (run `TSInstallInfo` to see what's installed, and use `TSInstall <language>` here)
  - you'll need to install the actual formatting tool (like "prettier") yourself locally
- [mason]() manages external tools, such as language servers, linters, formatters, and debugger
  - run `:Mason` to see which LSPs are installed
- [nvimtree](https://github.com/nvim-tree/nvim-tree.lua) is your file explorer

## Cool features from my workflow

- zen mode (`<leader>z`)

## What I like I about neovim

- it only has the features that I want/need/use. After switching to neovim from an IDE, I realize there are so many features in an IDE that I never used or possibly even knew about. By just having the features I want/need, neovim is blazingly fast.
- markdown is a huge part of my workflow - I take all my notes in markdown and I take lots of notes
  - vim's conceallevel setting makes my markdown much more enjoyable to read as I don't need to open a preview of Markdown to get the a nice visual

### Features that I have available to me

- Lsp client by language for code complete
- diagnostics
- lazygit (git ui)
- Telescope
  - file/text search search
- TreeSitter - for syntax highlighting
- Scratch files
- beautiful ui
  - Zen mode
  - Dimming
  - concealment (great for markdown)
