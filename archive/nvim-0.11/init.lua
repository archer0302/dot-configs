-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("config.lazy")

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

-- Disable spell checking in terminal buffers (buftype=terminal, filetype is empty)
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.wo.spell = false
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		if #vim.api.nvim_list_uis() == 0 then
			return
		end

		vim.cmd("NvimTreeOpen")

		if data.file ~= "" and vim.fn.isdirectory(data.file) == 0 then
			vim.cmd("wincmd p")
		end
	end,
})

vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in NvimTree" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Open NvimTree" })

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
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })
