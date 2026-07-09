-- use bash treesitter parser for zsh files
vim.treesitter.language.register("bash", "zsh")

-- treat .thor files as ruby
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.thor" },
  command = "set filetype=ruby",
})
