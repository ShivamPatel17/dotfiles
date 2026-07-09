# SketchyBar Config

This repository is my personal configuration for [SketchyBar](https://github.com/FelixKratz/SketchyBar), a macOS plugin to customize the top menu bar. My configuration is largely derived from and built upon [this repository](https://github.com/FelixKratz/dotfiles).

## Notable Enhancements

In addition to possessing all the features of the aforementioned configuration, this also offers the following improvements:

- **Battery Health** information, displayed when the Battery Widget is clicked.
- Redesigned **Calendar Widget** that takes up less space and opens Calendar when clicked.
- **Clipboard Widget** that displays up to five of your last copied items. Clicking an item re-copies it.
- Support for a **JSON Configuration File** to customize various aspects of the bar.
- Improved **Media Widget**, with superior play/pause functionality.
- **Restart Widget** to refresh SketchyBar; useful for development.
- **RAM Widget** that displays the current RAM utilization, along with a graph.
- **Stock Widget** that displays current stock trends, with 1D, 5D, and 1M data.
- **VPN Icon** that displays on the **Wifi Widget**, when a connected to a VPN.
- **Weather Widget** that displays current temperature and conditions, with a pop-up menu displaying semi-hourly forecast for the next two days.

## Installation

1. Install [Homebrew](https://brew.sh/).

2. Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/): `brew install --cask font-jetbrains-mono-nerd-font`

3. Install [Luarocks](https://luarocks.org/): `brew install luarocks`

4. Install [Lunajson](https://github.com/grafi-tt/lunajson): `sudo luarocks install lunajson`

5. Install [yfinance](https://pypi.org/project/yfinance/).

6. Run the following script, sourced from [this repository](https://github.com/FelixKratz/dotfiles):

- I (Shivam) actually only needed to get the [SketchyBar lua pluging](https://github.com/FelixKratz/SbarLua)
- Run: `sudo curl -L https://raw.githubusercontent.com/FelixKratz/dotfiles/master/install_sketchybar.sh | sh`

7. Run the following command to clone this repository and have it overwrite the SketchyBar configuration: `git clone https://github.com/TheGoldenPatrik1/sketchybar-config $HOME/.config/sketchybar`

8. Restart SketchyBar: `brew services restart sketchybar`

9. Go to "Settings" -> "Control Center" -> "Automatically hide and show the menu bar" and change its value to "Always."

## Starting and Stopping SketchyBar

**Normal day-to-day (via AeroSpace):**

SketchyBar starts automatically whenever [AeroSpace](https://github.com/nikitabobko/AeroSpace) starts, via `after-startup-command` in `~/.aerospace.toml`:

```toml
after-startup-command = [
  'exec-and-forget borders',
  'exec-and-forget sketchybar',
]
```

To restart AeroSpace (which re-fires this hook): `aerospace restart-aerospace`.

Note: this only fires on AeroSpace's own startup, not when SketchyBar dies on its own. If you kill SketchyBar manually, you need to manually restart it too (or restart AeroSpace).

**Manual start/stop:**

```bash
# Start
sketchybar &

# Stop
killall sketchybar

# Reload config only (no full restart)
sketchybar --reload
```

**Wake-from-sleep:**

Nothing to do — the LaunchAgent described below handles kill + restart automatically. To manually trigger that same kill+restart logic (e.g. for testing): `bash ~/.config/sketchybar/plugins/restart_on_wake.sh`.

**Check status:**

```bash
pgrep -x sketchybar && echo running || echo not running
```

## Wake-from-Sleep Auto-Restart

SketchyBar can hang the system when waking from sleep, likely due to network-dependent widgets (weather, wifi) firing before the network is ready. A LaunchAgent is included that automatically kills and restarts SketchyBar on wake.

**How it works:**

- `~/Library/LaunchAgents/com.shivam.sketchybar-restart-on-wake.plist` listens for macOS power state change notifications (`com.apple.powermanagement.systempowerstate`) via the `com.apple.notifyd.matching` XPC event.
- When triggered, it runs `plugins/restart_on_wake.sh`, which waits 3 seconds for the system to stabilize, kills sketchybar, then restarts it via `exec`.
- The script uses `exec /opt/homebrew/bin/sketchybar` rather than backgrounding it with `&`. launchd tears down a job's entire process group as soon as its script exits, so a backgrounded `sketchybar &` followed by the script returning would get killed along with the script. `exec` replaces the script's own process with sketchybar, so it becomes the job itself and survives.

**Files:**

| File | Purpose |
| ---- | ------- |
| `plugins/restart_on_wake.sh` | Kill + restart script with a 3s delay |
| `Library/LaunchAgents/com.shivam.sketchybar-restart-on-wake.plist` | LaunchAgent plist (symlinked via stow) |

**Managing the agent:**

```bash
# Load (already done on stow + first setup)
launchctl load ~/Library/LaunchAgents/com.shivam.sketchybar-restart-on-wake.plist

# Unload
launchctl unload ~/Library/LaunchAgents/com.shivam.sketchybar-restart-on-wake.plist

# Check status
launchctl list | grep sketchybar

# View logs
cat /tmp/sketchybar-restart-on-wake.log
```

**Troubleshooting:**

- If sketchybar still hangs, try increasing the `sleep 3` in `restart_on_wake.sh` to 5 or more seconds.
- If the agent isn't firing, verify the symlink exists: `ls -la ~/Library/LaunchAgents/com.shivam.sketchybar-restart-on-wake.plist`
- After editing the plist, unload and reload it for changes to take effect.
- After editing `restart_on_wake.sh`, no reload is needed — the LaunchAgent re-reads the script from disk each time it fires.
- If sketchybar doesn't come back after wake, check that `restart_on_wake.sh` ends with `exec sketchybar` and not `sketchybar &`; the latter gets killed when the script exits (see "How it works" above).
- This LaunchAgent only fires on sleep/wake — it does not start sketchybar on login/boot. If sketchybar isn't running at all (e.g. `pgrep -x sketchybar` returns nothing), start it manually or via `brew services start sketchybar`.

## Configuration

The default configuration values are defined in full [here](settings.lua). You may overwrite any or all of them by creating a `config.json` file in the root directory of the project.

**A note about the weather**: The Weather Widget draws from [wttr.in](https://github.com/chubin/wttr.in), which automatically determines your location based on IP address. However, their IP-to-location mapping mechanism is unreliable, especially when using a VPN. To recieve accurate location-based weather data, it may be advisable to configure one of the weather-related options below.

| Name                    | Type      | Default                                                                                                                  | Description                                                                                                                                                                                                                                                                                             |
| ----------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `calendar.click_script` | `string`  | `open -a Calendar`                                                                                                       | Script to run when the Calendar Widget gets clicked.                                                                                                                                                                                                                                                    |
| `clipboard.max_items`   | `integer` | `5`                                                                                                                      | Number of items to save in the Clipboard Widget.                                                                                                                                                                                                                                                        |
| `font`                  | `object`  | [helpers/default_font.lua](helpers/default_font.lua)                                                                     | Font configuration.                                                                                                                                                                                                                                                                                     |
| `group_paddings`        | `integer` | `5`                                                                                                                      | Padding used to separate groups in the bar.                                                                                                                                                                                                                                                             |
| `hide_widgets`          | `array`   | `[]`                                                                                                                     | List of widget names that you want hidden from the bar.                                                                                                                                                                                                                                                 |
| `icons`                 | `string`  | `sf-symbols`                                                                                                             | Icon library to use; other option is `NerdFont`.                                                                                                                                                                                                                                                        |
| `paddings`              | `integer` | `3`                                                                                                                      | Padding used throughout the bar.                                                                                                                                                                                                                                                                        |
| `python_command`        | `string`  | `python`                                                                                                                 | Command to use to run Python. The shell environment that SketchyBar uses to execute commands is a bit minimal, so you may need to specify an absolute path to your Python version of choice.                                                                                                            |
| `stocks.default_symbol` | `object`  | See below                                                                                                                | The default stock symbol to track and show on the Stock Widget. Default: `{ "symbol": "^GSPC", "name": "S&P 500" }`                                                                                                                                                                                     |
| `stocks.symbols`        | `array`   | See below                                                                                                                | Stock symbols to track and show on the Stock Widget's popup menu. For each item, you must provide a `symbol` but you do not have to provide a `name`. Default: `[ {"symbol": "^DJI", "name": "Dow"}, {"symbol": "^IXIC", "name": "Nasdaq"}, {"symbol": "^RUT", "name": "Russell 2K"} ]`                |
| `weather.location`      | `string`  | N/A                                                                                                                      | Default location used to pass to [wttr.in](https://github.com/chubin/wttr.in). You can use any data that wttr.in accepts, but, in the United States, best results are usually achieved with `City+State` where `State` is the full name of the state and not an abbrevation (e.g., `Chicago+Illinois`). |
| `weather.use_shortcut`  | `boolean` | `false`                                                                                                                  | Whether to try to run [this simple shortcut](https://www.icloud.com/shortcuts/6d1018c04fe2490cb241425d8f133e0c) find your location to pass to wttr.in. You must install the shortcut first.                                                                                                             |
