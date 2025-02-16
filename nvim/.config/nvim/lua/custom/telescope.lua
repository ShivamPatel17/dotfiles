vim.api.nvim_create_user_command("Tsfg", function(opts)
  require("telescope.builtin").find_files { find_command = { "fd", "--type", "f", "--glob", opts.args } }
end, { nargs = 1 })

vim.api.nvim_create_user_command("Tsgg", function(opts)
  require("telescope.builtin").live_grep {
    additional_args = function()
      return { "--glob", opts.args }
    end,
  }
end, { nargs = 1 })

-- Create a user command to toggle hidden file search for live_grep
vim.api.nvim_create_user_command("ToggleGrepHidden", function()
  vim.g.telescope_grep_hidden = not vim.g.telescope_grep_hidden
  print("Telescope Grep Hidden: " .. (vim.g.telescope_grep_hidden and "Enabled" or "Disabled"))
end, { desc = "Toggle hidden files in Telescope Grep" })
