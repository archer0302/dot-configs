-- Keymaps that do not belong to any plugin.
--
-- Plugin mappings live in that plugin's module under lua/plugins/, so deleting
-- a plugin file deletes its keys too.

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor' })
