# this outputs the whole diff
bda() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

bdm() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    if [ "$current_branch" = "main" ]; then
        echo "already on main"
        return 1
    fi

    if ! git rev-parse --verify main &>/dev/null; then
        echo "Error: 'main' branch not found locally."
        return 1
    fi

    # This command will output the full diff (all types of changes)
    # The 'main...' syntax compares the common ancestor of main and current_branch to current_branch
    git diff --relative main..."${current_branch}" | bat -l=diff
}


# this uses fzf to select files to pass to bat diff
bdf() {
    local fzf_flags=""

    # Check if the -m flag was passed
    if [[ "$1" == "-m" ]]; then
        fzf_flags="-m"
    fi

    # Use fzf with optional multi-select and pass selected files to bat
    # Using --read0 ensures filenames are read correctly when git diff outputs them with -z (null-terminated).
    #
    # By default, git diff --name-only outputs filenames line-by-line (\n-separated).
    # This works fine unless a filename contains spaces, special characters, or newlines, which can break scripts.
    # Using -z ensures filenames are correctly passed to fzf --read0 and xargs -0.
    git diff --name-only --relative --diff-filter=dAM -z | fzf $fzf_flags --read0 | xargs bat --diff
}

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
