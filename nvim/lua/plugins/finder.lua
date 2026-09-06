-- Fuzzy finding. plenary is telescope's dependency; fzf-native is its sorter.
--
-- ripgrep is deliberately absent: telescope shells out to the `rg` binary,
-- which is not a Neovim plugin. Install it with your package manager
-- (`brew install ripgrep`).
--
-- fzf-native's compile step lives in core/autocmds.lua, not here: a
-- PackChanged handler is only delivered events if it was registered before the
-- session's first vim.pack.add(), which rules out plugin modules.

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
})

-- Catch-up build: PackChanged only fires on install/update, so a copy that was
-- already on disk before the build hook existed would never get compiled.
local fzf_dir = vim.fs.joinpath(vim.fn.stdpath('data'),
  'site', 'pack', 'core', 'opt', 'telescope-fzf-native.nvim')
if vim.uv.fs_stat(fzf_dir) and not vim.uv.fs_stat(vim.fs.joinpath(fzf_dir, 'build', 'libfzf.so')) then
  vim.system({ 'make' }, { cwd = fzf_dir }):wait()
end

-- Only loads if the C library built successfully; telescope falls back to its
-- Lua sorter otherwise, so a failed build degrades rather than breaks.
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>',
  { noremap = true, silent = true, desc = 'Find files' })
