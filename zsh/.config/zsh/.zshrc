# import utils
source "$ZDOTDIR/utils/path.zsh"

# some basic zsh configs
HIST_SIZE=50000
SAVEHIST=$HIST_SIZE
HIST_DUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# Define the ZSHELLRCS directory
export ZSHELLRCS="$HOME/Repos/dotfiles/zsh/.config/zsh/zshrcs"

# Recursively source all regular files in ZSHELLRCS
if [ -d "${ZSHELLRCS}" ]; then
    find "${ZSHELLRCS}" -type f | while read -r file; do
        source "$file"
    done
else
    echo "Directory ${ZSHELLRCS} does not exist"
fi

add_path "/opt/homebrew/bin"
add_path "$HOME/bin"
add_path "$HOME/.config/bin"
add_path "/usr/local/bin"

