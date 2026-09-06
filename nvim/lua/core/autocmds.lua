-- Global autocommands, and every plugin build hook.
--
-- WHY BUILD HOOKS LIVE HERE rather than beside the plugin they belong to:
-- a PackChanged handler only receives events if it was registered before the
-- session's FIRST vim.pack.add() call. Plugin modules each call vim.pack.add
-- themselves, so a handler registered inside one of them is already too late
-- -- an earlier module's add() has run, and the event never reaches it. This
-- module is required before every plugin module for exactly that reason.
--
-- Verified the hard way: an fzf-native build hook placed in plugins/finder.lua
-- silently never fired, because plugins.colorscheme and plugins.editor add
-- their plugins first.

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

-- telescope-fzf-native ships C source that must be compiled before the
-- extension can load. Without this, telescope silently falls back to its
-- slower pure-Lua sorter.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'telescope-fzf-native.nvim'
      and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      local r = vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      if r.code ~= 0 then
        vim.notify('telescope-fzf-native build failed: ' .. (r.stderr or ''), vim.log.levels.WARN)
      end
    end
  end,
})
