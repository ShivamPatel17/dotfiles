zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/Users/shivampatel/.config/zsh/.zshrc'

# zsh-users/zsh-completion
fpath=(${ZDOTDIR:-$HOME}/.zsh_plugins/zsh-users/zsh-completions/src $fpath)

# include additional autocompletions
fpath=(${ZDOTDIR:-$HOME}/.autocompletions $fpath)

autoload -Uz compinit
compinit
