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
SAVEHIST=50000


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

# Ensure Oh My Zsh is only sourced once. The reason for this is because reloading it again causes the zsh-vi-mode to not work for some reason
if [[ "$ZSH_SESSION_ID" != "$$" ]]; then
    export ZSH_SESSION_ID=$$
    if [ -f "${ZSHELLRCS}/../.oh-my-zsh.zshrc" ]; then
        source "${ZSHELLRCS}/../.oh-my-zsh.zshrc"
    fi
fi

# Ensure the FZF backsearch is loaded last
if [ -f "${ZSHELLRCS}/../.fzf.zshrc" ]; then
    source "${ZSHELLRCS}/../.fzf.zshrc"
fi

