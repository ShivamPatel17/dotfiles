zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/Users/shivampatel/.config/zsh/.zshrc'

# Now also include the path to zsh-users/
fpath=(${ZDOTDIR:-$HOME}/.zsh_plugins/zsh-users/zsh-completions/src $fpath)

autoload -Uz compinit
compinit
