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

### Plugins

The Neovim configuration is managed by the built-in `vim.pack` plugin manager (no `lazy.nvim` or other plugin manager required). Here is a list of the plugins being used:

| Plugin | GitHub Repository |
|---|---|
| kanagawa.nvim | https://github.com/rebelot/kanagawa.nvim |
| nvim-lspconfig | https://github.com/neovim/nvim-lspconfig |
| plenary.nvim | https://github.com/nvim-lua/plenary.nvim |
| telescope.nvim | https://github.com/nvim-telescope/telescope.nvim |
| telescope-fzf-native.nvim | https://github.com/nvim-telescope/telescope-fzf-native.nvim |
| ripgrep | https://github.com/BurntSushi/ripgrep |
| gitsigns.nvim | https://github.com/lewis6991/gitsigns.nvim |
| diffview.nvim | https://github.com/sindrets/diffview.nvim |
| nvim-autopairs | https://github.com/windwp/nvim-autopairs |
| mason.nvim | https://github.com/mason-org/mason.nvim |
| nvim-treesitter | https://github.com/nvim-treesitter/nvim-treesitter |

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
