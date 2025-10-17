eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Added by `rbenv init` on Thu Oct 16 13:33:03 EDT 2025
eval "$(rbenv init - --no-rehash zsh)"
