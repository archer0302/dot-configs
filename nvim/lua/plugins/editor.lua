-- General editing UX: file browsing, icons, bracket pairing.

vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/windwp/nvim-autopairs',
})

require('oil').setup()
require('mini.icons').setup()

-- Auto-close brackets/quotes (Treesitter-aware)
require('nvim-autopairs').setup({})

vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>',
  { noremap = true, silent = true, desc = 'File explorer (Oil)' })
