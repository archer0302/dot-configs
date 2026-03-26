return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "gopls", "wgsl_analyzer", "clangd" },
			automatic_enable = {
				exclude = { "ts_ls", "vtsls", "vue_ls" },
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{
				"neovim/nvim-lspconfig",
				config = function()
					vim.lsp.config("gopls", {
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						settings = {
							gopls = {
								analyses = {
									unusedparams = true,
								},
								staticcheck = true,
							},
						},
					})
					vim.lsp.config("wgsl_analyzer", {
						filetypes = { "wgsl" },
					})
					vim.lsp.config("clangd", {
						filetypes = { "c", "cpp", "objc", "objcpp" },
						cmd = { "clangd", "--background-index", "--clang-tidy" },
					})
				end,
			},
		},
	},
}
