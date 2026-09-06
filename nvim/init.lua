-- Neovim configuration entry point.
--
-- ORDERING CONTRACTS -- two things here must happen before anything else, and
-- both fail silently rather than erroring if you get them wrong:
--
--   1. `mapleader` is baked into a keymap's left-hand side at the moment
--      `vim.keymap.set` runs. Set it before ANY module that defines a mapping,
--      or those mappings silently bind to `\` instead of <Space>.
--   2. `core.autocmds` registers the PackChanged -> TSUpdate hook, which must
--      exist before the first `vim.pack.add()` call so that it also fires on a
--      fresh install-from-lockfile. Plugin modules each call `vim.pack.add`
--      themselves, so `core.autocmds` has to be required ahead of all of them.
--
-- Everything after that is ordered for dependencies: `plugins.mason` installs
-- and registers servers, so it runs before `plugins.lsp` enables them.

vim.g.mapleader = ' '

require('core.autocmds')
require('core.options')
require('core.keymaps')

require('plugins.colorscheme')
require('plugins.editor')
require('plugins.finder')
require('plugins.git')
require('plugins.treesitter')
require('plugins.mason')
require('plugins.lsp')
