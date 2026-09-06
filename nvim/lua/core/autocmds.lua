-- Global autocommands that belong to no single plugin.
--
-- Anything plugin-specific lives in that plugin's module instead, so removing
-- the plugin removes its autocommands with it.

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
