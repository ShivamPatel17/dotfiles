-- Create a user command to toggle hidden file search for live_grep
vim.api.nvim_create_user_command("ToggleGrepHidden", function()
  vim.g.telescope_grep_hidden = not vim.g.telescope_grep_hidden
  print("Telescope Grep Hidden: " .. (vim.g.telescope_grep_hidden and "Enabled" or "Disabled"))
end, { desc = "Toggle hidden files in Telescope Grep" })

vim.keymap.set("n", "<leader>tsh", "<cmd>ToggleGrepHidden<CR>", { desc = "Toggle Grep Hidden Files" })
