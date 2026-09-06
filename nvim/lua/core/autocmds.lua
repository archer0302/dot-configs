-- Global autocommands, and every plugin build hook.
--
-- WHY BUILD HOOKS LIVE HERE rather than beside the plugin they belong to:
-- vim.pack.add() installs every plugin recorded in nvim-pack-lock.json, not
-- only the ones passed to that particular call. So the session's FIRST add()
-- -- whichever plugin module happens to run first -- installs everything and
-- fires every PackChanged event right there. A handler registered in a later
-- module is already too late: its plugin was installed during an earlier
-- module's add(), and the event has been and gone.
--
-- Measured, not assumed: with a logging handler here and markers in each
-- plugin module, both telescope-fzf-native (declared in plugins/finder.lua)
-- and diffview (declared in plugins/git.lua) reported kind=install during
-- plugins.colorscheme's add(), before either module had been required.
--
-- Hence: this module is required before every plugin module, and build hooks
-- go here even though they would otherwise belong next to their plugin.

--- Register a build step that runs when `name` is installed or updated.
--- @param name string plugin directory name, as vim.pack derives it from the URL
--- @param fn fun(path: string) invoked with the plugin's install path
local function on_pack_build(name, fn)
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      if ev.data.spec.name == name
        and (ev.data.kind == 'install' or ev.data.kind == 'update') then
        fn(ev.data.path)
      end
    end,
  })
end

-- nvim-treesitter keeps its parsers in step with the plugin revision.
on_pack_build('nvim-treesitter', function()
  vim.cmd('packadd nvim-treesitter')
  vim.cmd('TSUpdate')
end)

-- telescope-fzf-native ships C source that must be compiled before the
-- extension can load. Without this, telescope silently falls back to its
-- slower pure-Lua sorter.
on_pack_build('telescope-fzf-native.nvim', function(path)
  local r = vim.system({ 'make' }, { cwd = path }):wait()
  if r.code ~= 0 then
    vim.notify('telescope-fzf-native build failed: ' .. (r.stderr or ''), vim.log.levels.WARN)
  end
end)
