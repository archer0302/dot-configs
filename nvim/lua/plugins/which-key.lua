-- which-key: shows the available continuations after a prefix key.
--
-- which-key ships its own plugin/ file, so it self-initialises and the setup()
-- call below is only needed to pass options. Labels for individual mappings
-- come from the `desc` on each vim.keymap.set, so they live with the mapping;
-- only the prefix groups are named here, since a prefix belongs to no single
-- mapping.

vim.pack.add({
  { src = 'https://github.com/folke/which-key.nvim' },
})

require('which-key').setup({})

require('which-key').add({
  { '<leader>c', group = 'code' },
  { '<leader>f', group = 'find' },
  { '<leader>g', group = 'git' },
})
