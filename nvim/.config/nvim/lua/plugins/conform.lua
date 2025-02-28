return {
  -- Other plugins
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require "conform"

      conform.setup {
        log_level = vim.log.levels.DEBUG, -- uncomment to debug Conform
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "gofmt" },
          markdown = { "prettier" },
          json = { "prettier" },
          zsh = { "beautysh" },
          bash = { "beautysh" },
          sh = { "beautysh" },
          hcl = { "hclfmt" },
          sql = { "sqlfmt" },
        },
        format_on_save = {
          enabled = true,
          pattern = { "*" },
          lsp_fallback = true,
        },
        -- need to do this for formatters not natively recognized by conform
        formatters = {
          hclfmt = {
            command = vim.fn.stdpath "data" .. "/mason/bin/hclfmt", -- Ensure it points to Mason’s installed formatter
            stdin = true,
          },
        },
        default_format_opts = {
          timeout_ms = 5000, -- Increase timeout to 5 seconds
        },
      }
    end,
  },
}
