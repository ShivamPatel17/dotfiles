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
    local machine_specific_config = require "local.config"

    -- The log file is in the |stdpath| `cache` folder.
    -- To print the location:  >
    --
    --     :lua print(vim.fn.stdpath('cache'))
    --
    dap.set_log_level "DEBUG"

    -- reqeusts to the debugger are sent with this func https://github.com/mfussenegger/nvim-dap/blob/master/lua/dap/session.lua#L1846-L1846
    -- so I guess these configurations like substitutePath are interpretted in dlv perhaps
    -- https://github.com/go-delve/delve/blob/master/Documentation/cli/substitutepath.md#dap-server
    dapgo.setup {
      -- https://github.com/mfussenegger/nvim-dap/blob/8df427aeba0a06c6577dc3ab82de3076964e3b8d/doc/dap.txt#L239-L240
      dap_configurations = {
        {
          type = "go",
          name = "Attach Web - localhost:2345",
          mode = "remote",
          request = "attach",
          remotePath = machine_specific_config.debug_path_replacement,
          port = 2345,
          connect = {
            host = "127.0.0.1",
            port = "2345",
          },
          -- https://go.googlesource.com/vscode-go/+/c3516da303907ca11ee51e64f961cf2a4ac5339a/docs/dlv-dap.md
          substitutePath = {
            { from = machine_specific_config.debug_local_path, to = machine_specific_config.debug_path_replacement },
          },
        },
        {
          type = "go",
          name = "Attach Docker Test - localhost:2346",
          mode = "remote",
          request = "attach",
          remotePath = "/app",
          port = 2346,
          connect = {
            host = "127.0.0.1",
            port = "2346",
          },
          -- https://go.googlesource.com/vscode-go/+/c3516da303907ca11ee51e64f961cf2a4ac5339a/docs/dlv-dap.md
          substitutePath = {
            { from = machine_specific_config.debug_local_path, to = machine_specific_config.debug_path_replacement },
          },
        },
        {
          type = "go",
          name = "Attach Docker 2347",
          mode = "remote",
          request = "attach",
          remotePath = "/app",
          port = 2347,
          connect = {
            host = "127.0.0.1",
            port = "2347",
          },
          -- https://go.googlesource.com/vscode-go/+/c3516da303907ca11ee51e64f961cf2a4ac5339a/docs/dlv-dap.md
          substitutePath = {
            { from = machine_specific_config.debug_local_path, to = machine_specific_config.debug_path_replacement },
          },
        },
        {
          type = "go",
          name = "Attach Local",
          mode = "remote",
          request = "attach",
          remotePath = machine_specific_config.debug_path_replacement,
          connect = {
            host = "127.0.0.1",
            port = "2345",
          },
        },
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
    vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate Debug Session" })
    vim.keymap.set("n", "<leader>dbt", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
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
