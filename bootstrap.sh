#!/bin/zsh

# TODO: Run this script on a new macos machine to get started

# Define paths
DOTFILES_DIR="/Users/shivampatel/Toolbox/dotfiles"
TOOLBOX_DIR="/Users/shivampatel/Toolbox"

###
# tmux
###
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# be sure to run <C-a> shift+i to install the plugins
###
# end tmux
###


### HomeBrew
# These are the services you'll need from home HomeBrew
brew install rg
brew install neovim

### ASDF bootstrap
# whenever you install or switch nodejs with asdf, it will automatically install prettier
echo "prettier" >> ~/.default-npm-packages

