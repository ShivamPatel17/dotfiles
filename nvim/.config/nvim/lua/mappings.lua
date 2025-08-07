require "nvchad.mappings"

-- some notes on mappings
-- M: meta key (depends on keyboard apparently)
-- D: command key
-- A: alt
-- S: shift
--
-- <M-K> is the same as <M-S-k>
-- add yours here

local map = vim.keymap.set
map("i", "jk", "<ESC>")

-- vim command history
map("n", "<leader>cf", ":lua require'telescope.builtin'.command_history{}<CR>", { desc = "fzf vim command history" })

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
map("n", "<M-K>", ":resize +2<CR>", { desc = "Increase Buffer Height" }) -- Increase buffer height
map("n", "<M-H>", ":vertical resize -2<CR>", { desc = "Decrease Buffer Width" }) -- Decrease buffer width
map("n", "<M-L>", ":vertical resize +2<CR>", { desc = "Increase Buffer Width" }) -- Increase buffer width
map("n", "<M-J>", ":resize -2<CR>", { desc = "Decrease Buffer Height" }) -- Decrease buffer height

-- Close all other buffers
map("n", "<leader>ba", ":%bd|e#<CR>", { desc = "Close All Other Buffers" }) -- Close all buffers except most recent

-- Terminal shortcuts
map("t", "<C-e>", [[<C-\><C-n>]], { desc = "Switch Terminal to Normal Mode" }) -- Use Esc to enter Normal Mode in terminal

-- Clear highlights
map("n", "<leader>cm", ":call clearmatches()<CR>", { desc = "Clear matches" })

-- Wezterm
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

-- Diagnostics
map("n", "<leader>dsa", ":Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })

map("v", "<leader>r", "<Plug>SnipRun", { silent = true })
map("n", "<leader>r", "<Plug>SnipRun", { silent = true })
map("n", "<leader>rc", "<Plug>SnipClose", { silent = true })

-- LSP
map("n", "gb", "<C-o>", { desc = "LSP Go back" })
map("n", "glr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "LSP Go to references" })
map("n", "gli", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "LSP Go to implementations" })
