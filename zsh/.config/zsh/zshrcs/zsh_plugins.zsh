# Needs to be set before the zsh-vi-mode plugin is source
function zvm_config() {
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}

# assumes github and slash separated plugin names
github_plugins=(
    jeffreytse/zsh-vi-mode
    romkatv/powerlevel10k
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
)

for plugin in $github_plugins; do
    # clone the plugin from github if it doesn't exist
    if [[ ! -d ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin ]]; then
        echo $plugin
        mkdir -p ${ZDOTDIR:-$HOME}/.zsh_plugins/${plugin%/*}
        git clone --depth 1 --recursive https://github.com/$plugin.git ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin
    fi
    # load the plugin
    # refactor so that you have a map of every plugin's initscript that way we don't need to loop over to find a match
    for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh powerlevel10k.zsh-theme; do
        if [[ -f ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript ]]; then
            source ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript
            break
        fi
    done
done

# clean up
unset github_plugins
unset plugin
unset initscript


alias plugpull="find ${ZDOTDIR:-$HOME}/.zsh_plugins -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull"

# Config zsh-vi-mode
