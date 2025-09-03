# My Dotfiles for Neovim and WezTerm

These are my personal configuration files for Neovim and WezTerm.

## Prerequisites

Before using these configurations, please make sure you have the following software installed:

- **Neovim**: Version 0.9.0 or higher.
- **WezTerm**: A modern terminal emulator.
- **Git**: For cloning this repository and for `lazy.nvim`.
- **A C Compiler**: Required by `nvim-treesitter` for compiling parsers.
- **(Optional) A Nerd Font**: For the icons and symbols in Neovim to render correctly.

## Installation

You can use these configurations by either creating a symbolic link to them or by copying them to the appropriate configuration paths.

### macOS and Linux

**Symlink Method:**

```bash
# Neovim
ln -s /path/to/dot-configs/nvim ~/.config/nvim

# WezTerm
ln -s /path/to/dot-configs/wezterm ~/.config/wezterm
```

**Copy Method:**

```bash
# Neovim
cp -r /path/to/dot-configs/nvim ~/.config/

# WezTerm
cp -r /path/to/dot-configs/wezterm ~/.config/
```

### Windows

**Symlink Method (using Command Prompt as Administrator):**

```cmd
:: Neovim
mklink /D %LOCALAPPDATA%\nvim \path\to\dot-configs\nvim

:: WezTerm
mklink /D %USERPROFILE%\.config\wezterm \path\to\dot-configs\wezterm
```

**Copy Method:**

```cmd
:: Neovim
xcopy /E /I \path\to\dot-configs\nvim %LOCALAPPDATA%\nvim

:: WezTerm
xcopy /E /I \path\to\dot-configs\wezterm %USERPROFILE%\.config\wezterm
```

## Neovim Plugins

The Neovim configuration is managed by `lazy.nvim`. Here is a list of the plugins being used:

| Plugin | GitHub Repository |
|---|---|
| blink.cmp | https://github.com/saghen/blink.cmp |
| friendly-snippets | https://github.com/rafamadriz/friendly-snippets |
| catppuccin/nvim | https://github.com/catppuccin/nvim |
| nightfox.nvim | https://github.com/EdenEast/nightfox.nvim |
| kanagawa.nvim | https://github.com/rebelot/kanagawa.nvim |
| conform.nvim | https://github.com/stevearc/conform.nvim |
| lazydev.nvim | https://github.com/folke/lazydev.nvim |
| nvim-lspconfig | https://github.com/neovim/nvim-lspconfig |
| mason.nvim | https://github.com/mason-org/mason.nvim |
| nvim-autopairs | https://github.com/windwp/nvim-autopairs |
| nvim-dap | https://github.com/mfussenegger/nvim-dap |
| nvim-dap-ui | https://github.com/rcarriga/nvim-dap-ui |
| nvim-nio | https://github.com/nvim-neotest/nvim-nio |
| nvim-dap-go | https://github.com/leoluz/nvim-dap-go |
| nvim-tree.lua | https://github.com/nvim-tree/nvim-tree.lua |
| nvim-web-devicons | https://github.com/nvim-tree/nvim-web-devicons |
| nvim-ts-autotag | https://github.com/windwp/nvim-ts-autotag |
| telescope.nvim | https://github.com/nvim-telescope/telescope.nvim |
| plenary.nvim | https://github.com/nvim-lua/plenary.nvim |
| nvim-treesitter | https://github.com/nvim-treesitter/nvim-treesitter |

## WezTerm Configuration

The WezTerm configuration sets up some keybindings for pane and tab navigation, and a custom background image. You can find the keybindings in the `wezterm/wezterm.lua` file.

### Keybindings

| Key | Modifier | Action |
|---|---|---|
| `{` | SHIFT+ALT | Move tab to the left |
| `}` | SHIFT+ALT | Move tab to the right |
| `H` | CTRL+SHIFT | Activate left pane |
| `L` | CTRL+SHIFT | Activate right pane |
| `J` | CTRL+SHIFT | Activate bottom pane |
| `K` | CTRL+SHIFT | Activate top pane |
| ``` | CTRL | Activate next pane |
| `\` | CTRL | Toggle pane zoom state |