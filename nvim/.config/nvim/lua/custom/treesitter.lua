-- tree zsh files as bash
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.zsh", "*.zshrc" },
  command = "set filetype=bash",
})
