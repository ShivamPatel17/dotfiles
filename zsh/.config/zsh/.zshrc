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

# Function to add a path only if it doesn't already exist
# add_path() {
#   local path_to_add="$1"
#   if [[ ":$PATH:" != *":$path_to_add:"* ]]; then
#     export PATH="$path_to_add:$PATH"
#   fi
# }

# Use the function to add paths
add_path "/opt/homebrew/bin"
add_path "$HOME/bin"
add_path "$HOME/.config/bin"
add_path "/usr/local/bin"

#
# current path before making all these changes:
#
# /Users/shivampatel/.asdf/shims:/opt/homebrew/opt/asdf/libexec/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/Users/shivampatel/.local/share/mise/installs/terraform/1.9.8:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/Users/shivampatel/bin:/Users/shivampatel/.config/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/go/bin:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/Applications/Ghostty.app/Contents/MacOS


# new path
#
# /Users/shivampatel/.asdf/shims:/opt/homebrew/opt/asdf/libexec/bin:/Users/shivampatel/.local/share/mise/installs/terraform/1.9.8:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/opt/homebrew/bin:/usr/local/go/bin:/Applications/Ghostty.app/Contents/MacOS:/opt/homebrew/sbin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
#
# with out asdf
#
# export PATH="/Users/shivampatel/.local/share/mise/installs/terraform/1.9.8:/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/opt/homebrew/bin:/usr/local/go/bin:/Applications/Ghostty.app/Contents/MacOS:/opt/homebrew/sbin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"
#
#
# without mise
#
# export PATH="/Users/shivampatel/.config/bin:/Users/shivampatel/bin:/usr/local/bin:/opt/homebrew/bin:/usr/local/go/bin:/Applications/Ghostty.app/Contents/MacOS:/opt/homebrew/sbin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"
