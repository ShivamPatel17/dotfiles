return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure plenary.nvim is installed
  keys = {
    {
      "<leader>fw", -- need to load Telescope before this works
      function()
        require("custom.telescope.multigrep").live_multigrep()
      end,
      desc = "telescope multi Grep",
    },
  },
  init = function()
    -- This runs during startup before lazy loading
    -- Set up the keybinding immediately
    vim.keymap.set("n", "<leader>fw", function()
      -- Then call your custom function
      require("custom.telescope.multigrep").live_multigrep()
    end, { desc = "Multi grep (works from startup)" })
  end,
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
        path_display = { shorten = { len = 1, exclude = { -1 } } },
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
          hidden = true, -- Set hidden=true by default for find_files picker
          no_ignore = false, -- Do not ignore files from .gitignore
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
