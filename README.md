# High level set up

- [Inspiration from JFenstermacher](https://github.com/JFenstermacher/dotfiles/)

## zsh

- [plugins are manually downloaded and sourced](./zsh/.config/zsh/zshrcs/zsh_plugins.zsh)

## HomeBrew

- running on arm64
  - `uname -m` should print arm64

#### [Mise](https://mise.jdx.dev/)

- for dev tools and environment management

#### [Stow](https://www.gnu.org/software/stow/)

- all configuration is set up to be stow'd

  - every folder in this repo should be stowable (symlinked)
  - example: `stow -t ~ nvim` (`stow -t <target_dir> <directory_you_want_to_stow>`)
    - so everything in the `/nvim` will get copied over to `~`
      - and if you look at `/nvim` structure, you'll noticed all the config lives in `/nvim/.config/nvim`, because neovim will look for the conconfig in `~/.config/nvim`...
  - there's a `make stow` to stow everything and `make unstow` to remove the symlinks
    - you can manually stow each of these folders to the home directory
      - git, nvim, psql, skhd, tmux, and zsh can all be stowed

#### aerospace

- for tiling
  - run `restart_aerospace` when you first turn on your machine and log in

#### jankyborders

- for adding colored borders to my applications

#### sketchybar

- for a cooler menu bar

#### Wezterm

- my terminal emulator

#### fonts

- use the FontBook app to downloand and install whatever font you want
  - whenever you install a new font, clear the cache with `fc-cache -fv`

#### Cli Tools

- [eza](https://github.com/eza-community/eza): drop in replacement for `ls`
- [bat](https://github.com/sharkdp/bat): a better `cat`

## TODO

- still need to figure out all the dependencies for my set up. For now, I'll throw them into a list here as I see fit and long term I'd like to have a script that installs all dependencies in one full sweep
