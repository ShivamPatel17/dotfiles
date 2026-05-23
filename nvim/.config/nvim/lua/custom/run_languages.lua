-- running lua (run language lua)
vim.keymap.set("n", "<leader>rll", ":source %<CR>", { desc = "Run Lua with source %" })

-- running python (run language python)
vim.keymap.set("n", "<leader>rlp", ":split | term python3 %<CR>", { desc = "Run Python file" })
