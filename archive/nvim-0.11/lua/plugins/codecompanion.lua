return {
	"olimorris/codecompanion.nvim",
	version = "^18.0.0",
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		interactions = {
			chat = {
				adapter = "gemini_cli",
			},
		},
		adapters = {
			acp = {
				gemini_cli = function()
					return require("codecompanion.adapters").extend("gemini_cli", {
						defaults = {
							auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
						},
					})
				end,
			},
		},
	},
}
