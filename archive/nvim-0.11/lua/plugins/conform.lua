return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	--  keys = {
	--  	{
	-- Customize or remove this keymap to your liking
	--  		"<leader>f",
	--  		function()
	--  			require("conform").format({ async = true })
	--  		end,
	--  		mode = "",
	--  		desc = "Format buffer",
	-- 		},
	-- 	},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
			typescript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
			go = { "goimports", "gofmt", stop_after_first = true },
			rust = { "rustfmt" },
			toml = { "taplo" },
			cs = { "csharpier" },
			c = { "clang-format" },
			cpp = { "clang-format" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = function()
			return vim.fn.input("Format before save?(y/n) ") == "y" and { timeout_ms = 500 } or nil
		end,
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
