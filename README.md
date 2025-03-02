# High level set up

- [Inspiration from JFenstermacher](https://github.com/JFenstermacher/dotfiles/)

## zsh

- plugin manager:

  - [oh-my-zsh](https://ohmyz.sh/)
    - custom plugins I like:
      - [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
      - [auto suggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [theme](https://github.com/romkatv/powerlevel10k)

## HomeBrew

- running on arm64
  - `uname -m` should print arm64

### Tools to download from HomeBrew

- brew install asdf
- brew install rg
- brew install neovim
- brew install fzf
- brew install stow
- brew install --cack ghostty
- brew install --cask nikitabobko/tap/aerospace
- brew install jesseduffield/lazydocker/lazydocker
- brew install skhd
- brew install zoxide
- [brew install SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [brew install JankyBorders](https://github.com/FelixKratz/JankyBorders)
- brew install lazygit
- brew install envchain
- brew install eza

#### tmux

`brew install tmux`
`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

- be sure to run <C-a> shift+i to install the plugins

#### [Stow](https://www.gnu.org/software/stow/)

- all configuration is set up to be stow'd

  - every folder in this repo should be stowable (symlinked)
  - example: `stow -t ~ nvim` (`stow -t <target_dir> <directory_you_want_to_stow>`)
    - so everything in the `/nvim` will get copied over to `~`
      - and if you look at `/nvim` structure, you'll noticed all the config lives in `/nvim/.config/nvim`, because neovim will look for the conconfig in `~/.config/nvim`...
  - there's a `make stow` to stow everything and `make unstow` to remove the symlinks
    - you can manually stow each of these folders to the home directory
      - git, nvim, psql, skhd, tmux, and zsh can all be stowed

#### asdf

- runtime version manager

#### aerospace

- for tiling

#### jankyborders

- for adding colored borders to my applications

#### sketchybar

- for a cooler menu bar

#### ghostty

- my terminal emulator

#### fonts

- use the FontBook app to downloand and install whatever font you want
  - whenever you install a new font, clear the cache with `fc-cache -fv`

#### Cli Tools

- [eza](https://github.com/eza-community/eza): drop in replacement for `ls`
- [bat](https://github.com/sharkdp/bat): a better `cat`

## TODO

- still need to figure out all the dependencies for my set up. For now, I'll throw them into a list here as I see fit and long term I'd like to have a script that installs all dependencies in one full sweep
