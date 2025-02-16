# Basic set up

[Inspiration taken from JFenstermacher](https://github.com/JFenstermacher/dotfiles/)

## zsh

- plugin manager:

  - [oh-my-zsh](https://ohmyz.sh/)
    - custom plugins I like:
      - [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
      - [auto suggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [theme](https://github.com/romkatv/powerlevel10k)

- [fzf](https://github.com/junegunn/fzf)
  - got some shortcuts set up
- stow

# HomeBrew

## These are the services you'll need from home HomeBrew

brew install rg
brew install neovim
brew install fzf
brew install stow
brew install --cack ghostty
brew install --cask nikitabobko/tap/aerospace
brew install jesseduffield/lazydocker/lazydocker
brew install skhd
brew install zoxide
[brew install SketchyBar](https://github.com/FelixKratz/SketchyBar)
brew install --cask font-hack-nerd-font (used for sketchy bar icons)
[brew install JankyBorders](https://github.com/FelixKratz/JankyBorders)

### tmux

`brew install tmux`
`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

- be sure to run <C-a> shift+i to install the plugins

## [Stow](https://www.gnu.org/software/stow/)

- all configuration is set up to be stow'd

  - every folder in this repo should be stowable (symlinked)
  - example: `stow -t ~ nvim` (stow -t <target_dir> <directory_you_want_to_stow>)
    - so everything in the `/nvim` will get copied over to `~`
      - and if you look at `/nvim` structure, you'll noticed all the config lives in `/nvim/.config/nvim`, because neovim will look for the conconfig in `~/.config/nvim`...
  - there's a `make stow` to stow everything
    - you can manually stow each of these folders to the home directory
      - git, nvim, psql, skhd, tmux, and zsh can all be stowed

- the repo still needs to be set up in this way..

## ASDF

- runtime version manager

## aerospace

- for tiling

## JankyBorders

- for adding colored borders to my applications

## SketchyBar

- for a cooler menu bar

## Ghostty

- my terminal emulator

## Fonts

- use the FontBook app to downloand and install whatever font you want
