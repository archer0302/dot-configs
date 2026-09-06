-- Treesitter: install C/C++/Rust parsers and enable highlighting for those filetypes.

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

require('nvim-treesitter').install({ 'c', 'cpp', 'rust', 'python', 'toml' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'rust', 'python' },
  callback = function() vim.treesitter.start() end,
})
