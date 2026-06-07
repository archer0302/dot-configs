-- Plugins
vim.pack.add({
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/BurntSushi/ripgrep'
})

-- ColorScheme
vim.cmd("colorscheme kanagawa")

-- LSP list to be enabled
local lsp_list = { 'lua_ls', 'vtsls' }

-- Tell lua_ls to recognize the 'vim' global
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.lsp.enable(lsp_list)

vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations
vim.o.autocomplete = true
vim.g.mapleader = " "

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>e', ':Lexplore<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })

vim.g.netrw_banner = 0         -- Hide the top banner
vim.g.netrw_liststyle = 3      -- Tree view style
vim.g.netrw_winsize = 25       -- Set window size to 25%
