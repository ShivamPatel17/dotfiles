require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- vim command history
map("n", "<leader>cf", ":lua require'telescope.builtin'.command_history{}<CR>", { desc = "fzf vim command" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Save file (Ctrl + S) in all modes
map({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Tab management
map("n", "<leader>tn", ":tabnew<CR>", { desc = "New Tab" }) -- Open a new tab
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab" }) -- Close the current tab
map("n", "<leader>to", ":tabonly<CR>", { desc = "Close Other Tabs" }) -- Close all other tabs
map("n", "<leader>tl", ":tabnext<CR>", { desc = "Next Tab" }) -- Go to the next tab
map("n", "<leader>th", ":tabprevious<CR>", { desc = "Previous Tab" }) -- Go to the previous tab
map("n", "<leader>tm", ":tabmove<Space>", { desc = "Move Tab" }) -- Move tab (follow with position)

-- Split navigation
map("n", "<leader>spv", ":vsplit<CR>", { desc = "Vertical Split" }) -- Create a vertical split
map("n", "<leader>sph", ":split<CR>", { desc = "Horizontal Split" }) -- Create a horizontal split
map("n", "<leader>sc", "<C-w>c", { desc = "Close Split" }) -- Close the current split
map("n", "<leader>so", "<C-w>o", { desc = "Close OtherSplits" }) -- Close all splits except the current one

-- Adjust buffer size
map("n", "<M-S-k>", ":resize +2<CR>", { desc = "Increase Buffer Height" }) -- Increase buffer height (have to hit ALT+CMD+SHIFT+K).. not sure why this works, but it does.. the Telescope Key map is <M-K>
map("n", "<M-S-h>", ":vertical resize -2<CR>", { desc = "Decrease Buffer Width" }) -- Decrease buffer width
map("n", "<M-S-l>", ":vertical resize +2<CR>", { desc = "Increase Buffer Width" }) -- Increase buffer width
map("n", "<M-S-n>", ":resize -2<CR>", { desc = "Decrease Buffer Height" }) -- Decrease buffer height (somehow <M-S-j> isn't working.. :/ )

-- Close all other buffers
map("n", "<leader>ba", ":%bd|e#<CR>", { desc = "Close All Other Buffers" }) -- Close all buffers except most recent

-- Terminal shortcuts
map("t", "<C-e>", [[<C-\><C-n>]], { desc = "Switch Terminal to Normal Mode" }) -- Use Esc to enter Normal Mode in terminal

-- Clear highlights
map("n", "<leader>cm", ":call clearmatches()<CR>", { desc = "Clear matches" })

-- Nvim-Tmux
map("n", "<C-h>", ":NvimTmuxNavigateLeft<CR>", { desc = "Navigate to the Left Pane" })
map("n", "<C-l>", ":NvimTmuxNavigateRight<CR>", { desc = "Navigate to the Right Pane" })
map("n", "<C-j>", ":NvimTmuxNavigateDown<CR>", { desc = "Navigate to the Bottom Pane" })
map("n", "<C-k>", ":NvimTmuxNavigateUp<CR>", { desc = "Navigate to the Top Pane" })
-- vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
-- vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
--
-- Diagnostics
map("n", "<leader>dsa", ":Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })

-- Telescope
vim.keymap.set("n", "<leader>tsh", "<cmd>ToggleGrepHidden<CR>", { desc = "Toggle Grep Hidden Files" })

-- running lua
vim.keymap.set("n", "<leader><leader>n", ":source %<CR>", { desc = "Run Lua with source %" })
