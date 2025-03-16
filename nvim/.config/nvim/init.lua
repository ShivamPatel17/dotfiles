require "custom.lazy_bootstrap"

require "custom.globals"

require "custom.autocmds"

require "custom.treesitter"

-- telescope
-- note: telescope.multigrep.lua is loaded in the plugins.telescope's key options. This way the keymap is available and telescope still gets lazy loaded. Otherwise, requiring the multigrep in this init.lua will try to require telescope before it's lazy loaded, and I want to continue lazy loading telescope for fast nvim start up times
require "custom.telescope.user_commands"
require "custom.run_languages"

-- file specific
require "custom.file_specific.lua"
require "custom.file_specific.markdown"
require "custom.file_specific.sql"

-- load plugins
require("lazy").setup "plugins"

-- optional: only include these if they’re not already handled by NvChad
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
