# GUIDE
# symlink your shells .zshrc (probably ~/.zshrc) to this file

# More todos
#
# oh-my-zsh uses some custom plugins. Clone these plugin in the .oh-my-zsh.zshrc if they don't already exist
# - git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# - git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# on a new computer, if you don't clone this repo to ~
# might consider creating another file to export ZSHELRCS
# and gitignore it
export ZSHELLRCS="$HOME/Repos/dotfiles/zsh/.config/zsh/zshrcs"

HIST_SIZE=50000
SAVEHIST=$HIST_SIZE
HIST_DUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups


# Homebrew path (ensure it's correctly set)
export PATH="/opt/homebrew/bin:$PATH"

# Add user binaries
export PATH="$HOME/bin:$HOME/.config/bin:/usr/local/bin:$PATH"
export PATH=$HOME/bin:/usr/local/bin:$PATH

# add the executables you've got in the bin folder
export PATH=$HOME/.config/bin:$PATH

# Define the ZSHELLRCS directory
# Recursively source all regular files in ZSHELLRCS
if [ -d "${ZSHELLRCS}" ]; then
    find "${ZSHELLRCS}" -type f | while read -r file; do
        source "$file"
    done
else
    echo "Directory ${ZSHELLRCS} does not exist"
fi


# Ensure the FZF backsearch is loaded last
if [ -f "${ZSHELLRCS}/../.fzf.zshrc" ]; then
    source "${ZSHELLRCS}/../.fzf.zshrc"
fi

