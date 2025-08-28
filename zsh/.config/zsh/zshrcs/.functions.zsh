function reload() {
    exec zsh
}

alias cdr='reporoot'

reporoot() {
    local repo_root
    repo_root=$(git rev-parse --show-toplevel 2>/dev/null)

    if [[ $? -eq 0 && -n "$repo_root" ]]; then
        cd "$repo_root" || return 1
    fi
}
