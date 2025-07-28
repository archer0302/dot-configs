return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = { "lua", "c", "python", "vim", "vimdoc", "query", "rust", "c_sharp", "javascript", "vue" },
			auto_install = true,
			highlight = {
				enable = true
			}
		});
	end,
}
