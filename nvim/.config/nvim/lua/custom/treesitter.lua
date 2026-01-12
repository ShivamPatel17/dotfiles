-- treet zsh files as bash
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.zsh", "*.zshrc" },
  command = "set filetype=bash",
})

-- treat .thor files as ruby
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.thor" },
  command = "set filetype=ruby",
})
