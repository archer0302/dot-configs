-- Run :TSUpdate whenever nvim-treesitter is installed/updated.
-- Registered before vim.pack.add() so it also fires on first install-from-lockfile.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter'
      and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      vim.cmd('packadd nvim-treesitter')
      vim.cmd('TSUpdate')
    end
  end,
})

-- Plugins
vim.pack.add({
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/BurntSushi/ripgrep',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/sindrets/diffview.nvim',
	'https://github.com/windwp/nvim-autopairs',
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

-- Auto-close brackets/quotes (Treesitter-aware)
require('nvim-autopairs').setup({})

-- Treesitter: install C/C++ parsers and enable highlighting for those filetypes.
require('nvim-treesitter').install({ 'c', 'cpp' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function() vim.treesitter.start() end,
})

-- Git: gitsigns (inline hunks) + diffview (branch/PR review)
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    -- Hunk navigation
    map('n', ']c', function() gs.nav_hunk('next') end, 'Next git hunk')
    map('n', '[c', function() gs.nav_hunk('prev') end, 'Prev git hunk')
    -- Hunk actions
    map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
    map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame line')
  end,
})

-- ColorScheme
vim.cmd("colorscheme kanagawa")

-- LSP list to be enabled
local lsp_list = { 'lua_ls', 'vtsls', 'clangd' }

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

-- clangd: override only cmd (root markers / filetypes come from nvim-lspconfig's defaults)
vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
  },
})

vim.lsp.enable(lsp_list)

-- LSP-driven auto-completion: trigger clangd (and all servers) on every keypress.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not (client and client:supports_method('textDocument/completion')) then return end
    -- Add identifier characters to triggerCharacters so completion fires on every keypress
    -- (default only triggers on server chars like '.', '->', '::'). Must run before enable().
    local provider = client.server_capabilities.completionProvider or {}
    local triggers = provider.triggerCharacters or {}
    for c = string.byte('a'), string.byte('z') do triggers[#triggers + 1] = string.char(c) end
    for c = string.byte('A'), string.byte('Z') do triggers[#triggers + 1] = string.char(c) end
    triggers[#triggers + 1] = '_'
    provider.triggerCharacters = triggers
    client.server_capabilities.completionProvider = provider
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
  end,
})

vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations
vim.o.autocomplete = true
-- Completion menu behaviour (popup = doc preview; noselect = don't auto-pick first item)
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }
vim.g.mapleader = " "

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>e', ':Lexplore<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end,
	{ noremap = true, silent = true, desc = 'LSP format buffer' })

-- Diffview: review the working tree, a branch/PR range, or file history
vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { silent = true, desc = 'Diffview: working tree' })
vim.keymap.set('n', '<leader>gm', ':DiffviewOpen main...HEAD<CR>', { silent = true, desc = 'Diffview: branch vs main' })
vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<CR>', { silent = true, desc = 'Diffview: file history' })
vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { silent = true, desc = 'Diffview: close' })

vim.g.netrw_banner = 0         -- Hide the top banner
vim.g.netrw_liststyle = 3      -- Tree view style
vim.g.netrw_winsize = 25       -- Set window size to 25%
