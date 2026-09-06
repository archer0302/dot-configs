# My Dotfiles

These are my personal configuration files: a Neovim setup (`nvim/`) and a Claude Code status line (`claude/`).

## Neovim

### Prerequisites

Before using this configuration, please make sure you have the following software installed:

- **Neovim**: Version 0.12.0 or higher (required for the built-in `vim.pack` plugin manager).
- **Git**: For cloning this repository and for `vim.pack`.
- **A C Compiler**: Required by `nvim-treesitter` for compiling parsers.
- **(Optional) A Nerd Font**: For the icons and symbols in Neovim to render correctly.

### Installation

You can use this configuration by either creating a symbolic link to it or by copying it to the appropriate configuration path.

#### macOS and Linux

**Symlink Method:**

```bash
ln -s /path/to/dot-configs/nvim ~/.config/nvim
```

**Copy Method:**

```bash
cp -r /path/to/dot-configs/nvim ~/.config/
```

#### Windows

**Symlink Method (using Command Prompt as Administrator):**

```cmd
mklink /D %LOCALAPPDATA%\nvim \path\to\dot-configs\nvim
```

**Copy Method:**

```cmd
xcopy /E /I \path\to\dot-configs\nvim %LOCALAPPDATA%\nvim
```

### Layout

```
nvim/
  init.lua              mapleader, then requires in dependency order
  lua/core/
    autocmds.lua        global autocommands (PackChanged -> TSUpdate)
    options.lua         editor options; references no plugin
    keymaps.lua         mappings that belong to no plugin
  lua/plugins/          one file per domain: each declares its own
                        vim.pack.add, runs its setup, and owns its keymaps
  lua/lsp/              per-server LSP settings, applied by lua/plugins/lsp.lua
```

Two ordering contracts are enforced by the order of the requires in
`init.lua`, and both fail *silently* if broken:

1. `vim.g.mapleader` is baked into a mapping's left-hand side when
   `vim.keymap.set` runs, so it is set before any module that defines one.
   Get this wrong and mappings bind to `\` instead of `<Space>`.
2. `core.autocmds` registers the `PackChanged` -> `TSUpdate` hook, which must
   exist before the first `vim.pack.add()` call for it to fire on a fresh
   install-from-lockfile. Plugin modules each call `vim.pack.add` themselves,
   so `core.autocmds` is required ahead of all of them.

### Adding a plugin

Create `lua/plugins/<domain>.lua` (or extend an existing domain file):

```lua
vim.pack.add({ 'https://github.com/owner/repo' })
require('repo').setup({})
vim.keymap.set('n', '<leader>x', ..., { desc = '...' })
```

then add `require('plugins.<domain>')` to `init.lua`. The require list is
explicit rather than globbed because `vim.pack` has no dependency
declarations -- load order is a real constraint here, so it is written down
rather than left to alphabetical accident.

Deleting a plugin is deleting its file and its require line; its keymaps and
autocommands go with it.

### Adding an LSP server

Add its name to `servers` in `lua/plugins/lsp.lua`. If it needs settings
beyond nvim-lspconfig's defaults, add `lua/lsp/<name>.lua` returning a table.

Settings are applied with `vim.lsp.config()` rather than through Neovim's
native `nvim/lsp/<name>.lua` runtime directory. Neovim merges *every*
`lsp/<name>.lua` found on the runtimepath with the last one winning, and
nvim-lspconfig's copy sorts after the config directory -- so a native user
file silently loses any key lspconfig also sets.

### Plugins

| Plugin | GitHub Repository |
|---|---|
| kanagawa.nvim | https://github.com/rebelot/kanagawa.nvim |
| nvim-lspconfig | https://github.com/neovim/nvim-lspconfig |
| plenary.nvim | https://github.com/nvim-lua/plenary.nvim |
| telescope.nvim | https://github.com/nvim-telescope/telescope.nvim |
| telescope-fzf-native.nvim | https://github.com/nvim-telescope/telescope-fzf-native.nvim |
| gitsigns.nvim | https://github.com/lewis6991/gitsigns.nvim |
| diffview.nvim | https://github.com/sindrets/diffview.nvim |
| nvim-autopairs | https://github.com/windwp/nvim-autopairs |
| mason.nvim | https://github.com/mason-org/mason.nvim |
| mason-lspconfig.nvim | https://github.com/mason-org/mason-lspconfig.nvim |
| mason-tool-installer.nvim | https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim |
| oil.nvim | https://github.com/stevearc/oil.nvim |
| mini.icons | https://github.com/nvim-mini/mini.icons |
| nvim-treesitter | https://github.com/nvim-treesitter/nvim-treesitter |

`ripgrep` is not listed: telescope shells out to the `rg` binary, which is not
a Neovim plugin. Install it with your package manager.

### Language servers

`clangd` and `rust_analyzer` are deliberately left out of mason's
`ensure_installed` and are expected on `$PATH` from the Xcode command line
tools and rustup respectively -- mason's copies would shadow the
toolchain-managed ones and drift out of sync with the compiler they match.

## Claude Code Status Line

`claude/statusline-command.sh` renders the Claude Code status line: git branch, working
directory, model and effort level, context-window usage, and 5-hour / 7-day rate-limit
usage. The percentages are tinted green below 50%, amber below 80%, and red above.

### Prerequisites

- **jq**: The script parses Claude Code's JSON status payload with it.

### Installation

Symlink the script into `~/.claude/`:

```bash
ln -s /path/to/dot-configs/claude/statusline-command.sh ~/.claude/statusline-command.sh
```

Then point Claude Code at it by adding a `statusLine` block to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline-command.sh"
  }
}
```

Merge that key into the existing top-level object if the file already has settings in it.
`settings.json` itself is not tracked in this repo, since Claude Code rewrites it whenever
you change the model or effort level.

## Archived Configurations

The `archive/` directory holds configurations that are no longer maintained, kept for reference only:

- `archive/wezterm/` — a previous WezTerm terminal configuration.
- `archive/nvim-0.11/` — a previous Neovim configuration built on `lazy.nvim`, used before the switch to `vim.pack`.
