return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "jay-babu/mason-nvim-dap.nvim"
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = "/Users/archer.chang/.local/share/nvim/mason/packages/codelldb/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
        args = { "--port", "${port}" },
      }
    }

    dap.set_log_level('DEBUG')
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local source_file = vim.fn.input('Enter the name of the source file to debug: ', '', 'file')
          local executable = vim.fn.expand('%:p:h') .. '/' .. vim.fn.fnamemodify(source_file, ':r')
          return executable
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

      },
      {
        name = "Launch with GDB",
        type = "gdb",
        request = "launch",
        program = function()
          local source_file = vim.fn.input('Enter the name of the source file to debug: ', '', 'file')
          local executable = vim.fn.expand('%:p:h') .. '/' .. vim.fn.fnamemodify(source_file, ':r')
          return executable
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      }
    }

    dap.configurations.c = dap.configurations.cpp

    require("dapui").setup()
    require("dap-go").setup()

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

    vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlight" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Run/Continue" })
    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down" })
    vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dP", dap.pause, { desc = "Pause" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
    vim.keymap.set("n", "<leader>ds", dap.session, { desc = "Session" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
    vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", {})

    vim.fn.sign_define("DapBreakpoint",
      { text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
  end,
}
