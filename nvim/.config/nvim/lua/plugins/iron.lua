return {
  "Vigemus/iron.nvim",
  ft = { "python" },
  config = function()
    local iron = require "iron.core"

    iron.setup {
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { "python3" },
          },
        },
        repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
      },
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_paragraph = "<leader>sa",
        cr = "<leader>s<cr>",
        interrupt = "<leader>s<space>",
        exit = "<leader>sq",
        clear = "<leader>scl",
      },
      highlight = { italic = true },
      ignore_blank_lines = true,
    }
  end,
}
