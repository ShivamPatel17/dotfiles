# git aliases
alias g='git'
alias fza="git ls-files -m -o --exclude-standard | fzf --print0 -m | xargs -0 -t -o git add"

# file management
# alias rm="mv -t ~/.trash" # to prevent accidentally deleting files permanently
