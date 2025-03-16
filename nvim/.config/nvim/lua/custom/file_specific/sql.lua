local function format_sql()
  local filename = vim.api.nvim_buf_get_name(0)
  if filename ~= "" then
    vim.cmd("!sqlfmt " .. vim.fn.shellescape(filename))
    vim.cmd "e!" -- Reload the buffer
  else
    vim.notify("Buffer is not associated with a file.", vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>fmts", format_sql, { desc = "Format SQL" })
