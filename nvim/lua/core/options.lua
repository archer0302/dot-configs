-- Editor options. No plugin may be referenced from this file.

vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations

vim.o.number = true
vim.o.relativenumber = true

vim.o.autocomplete = true
-- Completion menu behaviour (popup = doc preview; noselect = don't auto-pick first item)
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }
