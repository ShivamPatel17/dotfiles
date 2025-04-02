return {
  -- need to compile the binary and add the executable to the runtime path. Mine is in /usr/local/bin/sniprun
  "michaelb/sniprun",
  branch = "master",

  build = "sh install.sh 1",
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  config = function()
    require("sniprun").setup {
      binary_path = "sniprun",
      -- your options
      repl_enable = {
        -- "Python3_original", -- https://michaelb.github.io/sniprun/sources/interpreters/Python3_original.html
        "Python3_fifo",
      }, -- Enable REPL mode for Python
      selected_interpreters = { "Python3_fifo" },
      live_display = { "VirtualText" }, --# display mode used in live_mode

      --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
      --# to filter only sucessful runs (or errored-out runs respectively)
      display = {
        -- "Classic", --# display results in the command-line  area
        -- "virtualTextOk", --# display ok results as virtual text (multiline is shortened)

        --"VirtualText", --# display results as virtual text
        "VirtualLine", --# display results as virtual lines
        -- "TempFloatingWindow",      --# display results in a floating window
        -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
        -- "Terminal", --# display results in a vertical split
        -- "TerminalWithCode",        --# display results and code history in a vertical split
        -- "NvimNotify",              --# display with the nvim-notify plugin
        -- "Api"                      --# return output to a programming interface
      },
      live_mode_toggle = "enable", --# live mode toggle, see Usage - Running for more info - need to run :SnipLive to even enable it

      show_no_output = {
        "Classic",
        "TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
      },
    }
  end,
}
