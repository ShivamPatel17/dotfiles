require "custom.lazy_bootstrap"

require "custom.globals"

require "custom.autocmds"

require "custom.treesitter"

require "custom.telescope.user_commands"
require "custom.run_languages"

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
