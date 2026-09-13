-- Neovim configuration entry point.
--
-- ORDERING CONTRACTS -- two things here must happen before anything else, and
-- both fail silently rather than erroring if you get them wrong:
--
--   1. `mapleader` is baked into a keymap's left-hand side at the moment
--      `vim.keymap.set` runs. Set it before ANY module that defines a mapping,
--      or those mappings silently bind to `\` instead of <Space>.
--   2. `core.autocmds` registers every plugin build hook. vim.pack.add()
--      installs everything in nvim-pack-lock.json, not just what that call
--      names, so the session's FIRST add() fires every PackChanged event.
--      A hook registered by a later module never sees its own plugin's event,
--      which is why `core.autocmds` is required ahead of all of them.
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
require('plugins.which-key')
