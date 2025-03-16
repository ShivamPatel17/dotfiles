# GUIDE
# symlink your shells .zshrc (probably ~/.zshrc) to this file

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
