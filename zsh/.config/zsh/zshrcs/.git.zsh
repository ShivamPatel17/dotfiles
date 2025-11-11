gundo() {
    git reset --soft HEAD~"$1"
}

ghard() {
    git reset --hard
}

goriginhard() {
    git fetch origin && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
}

export GPG_TTY=$TTY
