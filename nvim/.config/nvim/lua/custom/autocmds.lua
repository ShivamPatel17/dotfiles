-- Global variables to track the highlight and the last highlighted word
local match_id = nil
local last_highlighted_word = nil

-- Function to clear previous highlight
local function clear_highlight()
  if match_id then
    pcall(vim.fn.matchdelete, match_id)
    match_id = nil
  end
end

-- Function to highlight the current word
local function highlight_word()
  -- Clear previous highlight
  clear_highlight()

  -- Get the current word under the cursor
  local current_word = vim.fn.expand "<cword>"

  -- Skip if the word hasn't changed or is not alphanumeric
  if current_word ~= "" and current_word ~= last_highlighted_word and current_word:match "^%w+$" then
    -- Highlight the current word
    match_id = vim.fn.matchadd("Search", "\\<" .. vim.fn.escape(current_word, "\\") .. "\\>")
    last_highlighted_word = current_word
  end
end

-- Autocommand group
local augroup = vim.api.nvim_create_augroup("CursorWordHighlight", { clear = true })

-- Autocommands to manage highlighting
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = augroup,
  callback = function()
    highlight_word()
  end,
})

-- Clear highlight on FocusLost and WinLeave
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
  group = augroup,
  callback = function()
    clear_highlight()
  end,
})

-- Reapply highlight on FocusGained and WinEnter
vim.api.nvim_create_autocmd({ "FocusGained", "WinEnter" }, {
  group = augroup,
  callback = function()
    highlight_word()
  end,
})

-- Define a user command to toggle Copilot
vim.api.nvim_create_user_command("ToggleCopilot", function()
  -- Check the current state of Copilot
  -- copilot#Enabled() is a Vimscript function exposed by copilot.vim
  local is_enabled = vim.fn["copilot#Enabled"]()

  if is_enabled == 1 then
    vim.cmd "Copilot disable"
    print "Copilot: Disabled"
  else
    vim.cmd "Copilot enable"
    print "Copilot: Enabled"
  end
end, {
  -- This command takes no arguments
  nargs = 0,
  -- Provide a description for tools like which-key
  desc = "Toggle GitHub Copilot",
})

-- Map <leader>co to the ToggleCopilot command in Normal mode
vim.keymap.set("n", "<leader>co", ":ToggleCopilot<CR>", {
  silent = true,
  desc = "Toggle GitHub Copilot",
})

-- Apply NormalNC highlighting to all windows when Neovim loses focus
vim.api.nvim_create_autocmd("FocusLost", {
  command = "set winhighlight=Normal:NormalNC",
})

-- Revert to normal highlighting when Neovim regains focus
vim.api.nvim_create_autocmd("FocusGained", {
  command = "set winhighlight=",
})
