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
        "Python3_original", -- https://michaelb.github.io/sniprun/sources/interpreters/Python3_original.html
      }, -- Enable REPL mode for Python
      live_display = { "VirtualText" }, --# display mode used in live_mode
      live_mode_toggle = "enable", --# live mode toggle, see Usage - Running for more info - need to run :SnipLive to even enable it
    }
  end,
}
