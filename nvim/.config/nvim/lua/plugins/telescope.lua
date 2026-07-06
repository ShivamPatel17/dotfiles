return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure plenary.nvim is installed
  cmd = { "Telescope" },
  keys = {
    {
      "<leader>fw", -- need to load Telescope before this works
      function()
        require("custom.telescope.multigrep").live_multigrep()
      end,
      desc = "telescope multi Grep",
    },
  },
  config = function()
    -- Initialize the global variable to false if not already set
    vim.g.telescope_grep_hidden = vim.g.telescope_grep_hidden or true

    require("telescope").setup {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--glob",
          "!.git/*", -- Exclude .git directory
        },
        file_ignore_patterns = { "%.git/", "node_modules", ".zsh_history" },
        prompt_prefix = "",
        path_display = function(_, path)
          local cols = vim.o.columns
          local win_width = math.floor(cols * 0.95) -- matches layout_config.width
          if #path > win_width * 0.6 then
            local Path = require("plenary.path")
            return Path:new(path):shorten(1, { -1 })
          end
          return path
        end,
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            prompt_position = "top",
            preview_height = 0.4,
            mirror = true, -- prompt and results on top, preview below
          },
          width = 0.95,
          height = 0.95,
          preview_cutoff = 20, -- Hide preview only in very short windows
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
        live_grep = {
          additional_args = function()
            return vim.g.telescope_grep_hidden and { "--hidden" } or {}
          end,
        },
      },
    }
  end,
}
