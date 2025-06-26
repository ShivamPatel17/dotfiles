# Getting started with tmux

```
brew install tmux
```

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# tmux Quick Reference

| **Action**                | **Command**                                    |
| ------------------------- | ---------------------------------------------- | --- |
| **Working with Sessions** |                                                |
| Start a new session       | `tmux new -s session_name`                     |
| Detach from session       | `Ctrl-a d` or `tmux detach`                    |
| Attach to a session       | `tmux attach -t session_name`                  |
| List sessions             | `tmux ls`                                      |
| Switch sessions           | `tmux switch -t session_name`                  |
| Kill a session            | `tmux kill-session -t session_name`            |
| Rename a Session          | `tmux rename-session -t current_name new_name` |
| List clients              | `tmux lsc`                                     |
| Kill a client             | `tmux detach-client -t client_name`            |
| **Working with Windows**  |                                                |
| Create a new window       | `Ctrl-a c` or `tmux new-window`                |
| Kill the current window   | `Ctrl-a &` or `tmux kill-window`               |
| Rename the current window | `Ctrl-a ,` or `tmux rename-window`             |
| List all windows          | `Ctrl-a w`                                     |
| Switch between windows    | `Ctrl-a <number>` (e.g., `Ctrl-b 1`)           |
| Cycle through windows     | `Ctrl-a n` (next) / `Ctrl-a p` (prev)          |
| **Working with Panes**    |                                                |
| Split horizontally        | `Ctrl-a                                        | `   |
| Split vertically          | `Ctrl-a -`                                     |
| Close a pane              | `Ctrl-a x`                                     |
| Navigate panes            | `Ctrl-a <arrow>`                               |

### Notes

- **Windows** are top-level containers within a session and can have multiple panes.
- **Panes** are splits inside a window, and you can navigate between them using `Ctrl-b` with arrow keys.
- Use `Ctrl-b w` to display an interactive list of windows for quick navigation.
- Naming your windows with `Ctrl-b ,` helps keep your workspace organized.
- for all these commands above that start with `tmux`, you can juse use `<C-a>:` to get to the tmux command line and then type your next command like `kill-session` or `new-window`

## How to use as part of your workflow

- start tmux with `ta`, or `ta --start` to start a session in tmux in the directory you're already in
  - but generally, call `ta` from anywhere to start up tmux
- use `<prefix>j` to jump to a new session, or `<prefix>p` to start a session in any of the directories in your "repos" folder (consider updating to "workspace")
  - use `<prefix>k` to kill a session
- you shouldn't need to detach from tmux often, but if you do: `<prefix>d`

## To kill sessions without resurrections or continuum

- disable this in your .tmux.conf

```
set -g @continuum-restore 'off' # disable tmux-continuum functionality
```

- then kill tmux

```
tmux kill-server
```

- then re-enable this

```
set -g @continuum-restore 'on' # enable tmux-continuum functionality
```

### Config

- the .tmux.conf has some keybinding updates
- the plugins there help you switch between tmux panes and nvim panes

### Ghostty with Tmux

- the Ghostty configs allow you to remap some keys to make tmux commands easier
  - check out [this article](https://www.joshmedeski.com/posts/macos-keyboard-shortcuts-for-tmux/)
  - `xxd -psd` to print out keystrokes' hex values
