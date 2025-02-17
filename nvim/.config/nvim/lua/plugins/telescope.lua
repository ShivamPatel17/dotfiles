return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure plenary.nvim is installed
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
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top", -- Places the prompt (grep input) at the top
            preview_width = 0.5, -- Adjust preview area width
          },
          vertical = {
            mirror = false, -- Disable mirroring for vertical layout
          },
          width = 0.95, -- Width of Telescope window
          height = 0.8, -- Height of Telescope window
          preview_cutoff = 120, -- When to disable preview based on window width
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
