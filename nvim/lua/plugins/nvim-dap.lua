return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		local cpp_compiler = "g++"

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/Users/archer.chang/.local/share/nvim/mason/packages/codelldb/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
				args = { "--port", "${port}" },
			},
		}
		-- Define the launch configuration for C/C++
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp

		--  	dap.configurations.cpp = {
		--  		{
		--  			name = "Launch file",
		--  			type = "codelldb",
		--  			request = "launch",
		--  			program = function()
		--  				local bin_path = vim.fn.expand("%:p:h") .. "/bin"
		--  				vim.fn.mkdir(bin_path, "p")
		--  				local current_file = vim.fn.expand("%:p")
		--  				local executable = bin_path .. "/" .. vim.fn.expand("%:t:r")
		--  				if vim.fn.system({ cpp_compiler, "-g", "-std=c++23", current_file, "-o", executable }) then
		--  					return executable
		--  				else
		--  					return nil
		--  				end
		--  			end,
		--  			cwd = "${workspaceFolder}",
		--  			stopOnEntry = false,
		--  			args = {},
		--  		},
		--  	}

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
		vim.keymap.set("n", "<leader>dw", function()
			require("dap.ui.widgets").hover()
		end, { desc = "Widgets" })
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", {})

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
	end,
}
