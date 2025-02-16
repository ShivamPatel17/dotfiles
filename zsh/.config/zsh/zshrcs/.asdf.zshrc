#### ASDF SCRIPT FROM JON F ###
function asdf() {
    COMMAND="$1"
    [ "$#" -gt 0 ] && shift

    asdf_plugin() {
        local action="$1"
        [ "$#" -gt 0 ] && shift

        local name="$1"
        [ "$#" -gt 0 ] && shift

        case "$action" in
            add)
                if [ -z "$name" ]; then
                    local name=$( asdf plugin list all | awk '{ print $1 }' | tr ' ' '\n' | fzf )
                fi

                [ -n "$name" ] && command asdf "$COMMAND" "$action" "$name" "$@"
                ;;
            remove)
                if [ -z "$name" ]; then
                    local name=$( asdf plugin list | fzf )
                fi

                [ -n "$name" ] && command asdf "$COMMAND" "$action" "$name"
                ;;
            update)
                if [ -z "$name" ]; then
                    local name=$( asdf plugin list | fzf )
                fi
                [ -n "$name" ] && command asdf "$COMMAND" "$action" "$name"
                ;;
            *)
                command asdf "$COMMAND" "$action" "$name" "$@"
                ;;
        esac
    }

    asdf_install() {
        local name="$1"
        [ "$#" -gt 0 ] && shift

        local vers="$1"
        [ "$#" -gt 0 ] && shift

        if [ -z "$vers" ]; then
            vers=$( asdf list all "$name" | sort -r | fzf )
        fi

        [ -n "$vers" ] && command asdf "$COMMAND" "$name" "$vers" "$@"
    }

    asdf_package_def() {
        local name="$1"
        if [ "$#" -eq 0 ]; then
            command asdf "$COMMAND"
            return
        fi

        shift

        local vers="$1"
        [ "$#" -gt 0 ] && shift

        if [ -z "$vers" ]; then
            if ! asdf list "$name" &> /dev/null; then
                echo "No such plugin: $name"
                return
            fi

            vers=$( asdf list "$name" | fzf | xargs )
        fi

        if [ -n "$vers" ]; then
            case "$COMMAND" in
                shell) eval "$( asdf export-shell-version sh "$name" "$vers" )" ;;
                *) command asdf "$COMMAND" "$name" "$vers" "$@" ;;
            esac
        fi
    }

    if ! command -v fzf > /dev/null ; then
        command asdf "$COMMAND" "$@"
    fi

    case "$COMMAND" in
        plugin) asdf_plugin "$@" ;;
        install) asdf_install "$@" ;;
        local|global|shell) asdf_package_def "$@" ;;
        *) command asdf "$COMMAND" "$@" ;;
    esac
}
#### END OF ASDF SCRIPT FROM JON F ####

# runtime version manager
# [asdf](https://asdf-vm.com/guide/getting-started.html)
. /opt/homebrew/opt/asdf/libexec/asdf.sh
