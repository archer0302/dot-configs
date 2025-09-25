require("config.lazy")
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.spelloptions = "camel"
vim.opt.spelllang = "en_us"
vim.opt.spell = true

require("kanagawa").setup({
	transparent = true,
	overrides = function(colors)
		local theme = colors.theme
		return {
			LineNr = { bg = "none" },
			StatusLine = { bg = "none" },
			StatusLineNC = { bg = "none" },
			TelescopeNormal = { bg = theme.ui.bg_m3 },
		}
	end,
})

vim.cmd.colorscheme("kanagawa")
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

-- Neovim
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit neovim" })

-- wezterm integration
-- Set the WezTerm tab title to the initial working directory when Neovim starts.
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- You can use `fnamemodify` to get just the basename if you prefer
		local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		vim.fn.system({ "wezterm", "cli", "set-tab-title", "nvim: " .. dirname })
	end,
})

-- Optional: Reset the title when Neovim exits
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.fn.system({ "wezterm", "cli", "set-tab-title", "" })
	end,
})

-- nvim-tree
local nvim_tree_api = require("nvim-tree.api")

local function nvim_tree_find_file()
	nvim_tree_api.tree.open({ find_file = true })
end

vim.keymap.set("n", "<leader>fe", nvim_tree_find_file, { desc = "Find current file in NvimTree" })
vim.keymap.set("n", "<leader>e", nvim_tree_api.tree.toggle, { desc = "Open NvimTree" })

-- window navigation
vim.keymap.set({ "n", "i", "v", "t" }, "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set({ "n", "i", "v", "t" }, "<C-j>", "<C-w><C-j>", { desc = "Move to bottom window" })
vim.keymap.set({ "n", "i", "v", "t" }, "<C-k>", "<C-w><C-k>", { desc = "Move to top window" })
vim.keymap.set({ "n", "i", "v", "t" }, "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-w><C-j>", { desc = "Move to bottom window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-w><C-k>", { desc = "Move to top window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-w><C-l>", { desc = "Move to right window" })

-- lsp functionalities
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename variable" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
