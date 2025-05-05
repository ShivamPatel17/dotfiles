return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local dapgo = require "dap-go"

    dap.set_log_level "TRACE"

    dapgo.setup {
      dap_configurations = {
        {
          type = "go",
          name = "Shivam Attach remote",
          mode = "remote",
          request = "attach",
          remotePath = "/app",
          connect = {
            host = "127.0.0.1",
            port = "2345",
          },
          -- https://go.googlesource.com/vscode-go/+/c3516da303907ca11ee51e64f961cf2a4ac5339a/docs/dlv-dap.md
          substitutePath = {
            { from = "/Users/shivampatel/Repos/ledger/", to = "/app" },
          },
        },
      },
      delve = {
        port = "2345",
        -- additional args to pass to dlv
        args = {},
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        -- avaliable ui interactive function to prompt for arguments get_arguments
        build_flags = {},
        -- the current working directory to run dlv from, if other than
        -- the current working directory.
        cwd = nil,
      },
    }
    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<leader>da", dapui.toggle, { desc = "Toggle DapUI" })
    vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>dsu", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dlp", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
    end, { desc = "Log Point" })
    vim.keymap.set("n", "<leader>drl", dap.run_last, { desc = "Run Last" })

    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      require("dap.ui.widgets").hover()
    end, { desc = "hover" })
    vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
      require("dap.ui.widgets").preview()
    end, { desc = "preview" })
    vim.keymap.set("n", "<Leader>dwf", function()
      local widgets = require "dap.ui.widgets"
      widgets.centered_float(widgets.frames)
    end, { desc = "Widget Frames" })
    vim.keymap.set("n", "<Leader>dwf", function()
      local widgets = require "dap.ui.widgets"
      widgets.centered_float(widgets.scopes)
    end, { desc = "Widget Scopes" })
  end,
}
