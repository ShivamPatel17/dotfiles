function add_path() {
    local path_to_add="$1"
    if [[ ":$PATH:" != *":$path_to_add:"* ]]; then
        export PATH="$path_to_add:$PATH"
    else
        echo "Path '$path_to_add' already exists in PATH."
    fi
}
