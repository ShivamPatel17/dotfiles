-- Conceal secrets in environment and script files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.*config", "*.*rc", "*.env*", "*.sh", "*.*zsh" },
  group = vim.api.nvim_create_augroup("conceal_secrets", { clear = true }),
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"
    vim.api.nvim_set_hl(0, "Conceal", { link = "String" })
    local keywords = "API|AUTH|ENDPOINT|ENTERPRISE|KEY|SECRET|TOKEN|URL"
    vim.fn.matchadd("Conceal", [[\v\w*%(]] .. keywords .. [[)\w*\="\zs[^"]+\ze"]], 10, -1, { conceal = "🙈" })
    vim.fn.matchadd("Conceal", [[\v\w*%(]] .. keywords .. [[)\w*\='\zs[^']+\ze']], 10, -1, { conceal = "🙈" })
    vim.fn.matchadd("Conceal", [[\v\w*%(]] .. keywords .. [[)\w*\=\zs[^"'\s]+]], 10, -1, { conceal = "🙈" })
  end,
})
