# Copilot instructions for this repository

## Build, test, and lint commands

This repository is a Neovim + WezTerm dotfiles repo and does not define a package-manager test/lint pipeline (`package.json`, `Makefile`, etc. are absent).

- Prerequisites from `README.md` that affect local validation:
  - Neovim 0.9.0+
  - Git (used by `lazy.nvim` bootstrap)
  - A C compiler (for `nvim-treesitter` parsers)
- Validate Neovim config boots cleanly:
  - `XDG_CONFIG_HOME="$PWD" nvim --headless "+qa"`
- Sync/update Neovim plugins managed by lazy.nvim:
  - `XDG_CONFIG_HOME="$PWD" nvim --headless "+Lazy! sync" "+qa"`
- Run Neovim health checks:
  - `XDG_CONFIG_HOME="$PWD" nvim --headless "+checkhealth" "+qa"`
- Single-test equivalent:
  - No automated per-test runner exists in this repo; validate the changed area with targeted health checks, e.g. `XDG_CONFIG_HOME="$PWD" nvim --headless "+checkhealth vim.lsp" "+qa"`.
  - For CodeCompanion changes: `XDG_CONFIG_HOME="$PWD" nvim --headless "+checkhealth codecompanion" "+qa"`.

## High-level architecture

- `nvim/init.lua` is the main entrypoint: disables netrw, loads lazy config, sets global options/keymaps/theme, and opens `nvim-tree` on startup.
- `nvim/lua/config/lazy.lua` bootstraps `lazy.nvim` and loads plugin specs from `nvim/lua/plugins/*.lua`.
- `nvim/lazy-lock.json` pins plugin versions used by lazy.nvim and should stay in sync with plugin changes.
- `nvim/lua/plugins/` contains one plugin spec per file; `lsp.lua` handles Go LSP (`gopls`), `typescript-tools.lua` handles JS/TS LSP, and `conform.lua`/`lint.lua`/`dap.lua` own format/lint/debug behavior.
- `nvim/after/ftplugin/*.lua` provides per-filetype option overrides (2-space indentation for TypeScript, Vue, and Lua).
- `nvim-vscode/init.lua` is a minimal Neovim config used for VSCode Neovim integration and should stay lightweight.
- `wezterm/wezterm.lua` is standalone WezTerm config with pane/tab keymaps, Windows default shell override, and background image settings.
- `docs/` contains operator workflows for CodeCompanion and TS/Go debugging; keep docs aligned when those flows change.

## Key conventions

- Keep leader definitions in `nvim/lua/config/lazy.lua` before `lazy.nvim` setup so plugin keymaps resolve correctly.
- Preserve the lazy.nvim plugin organization: add or modify plugin behavior in `nvim/lua/plugins/*.lua` files, not by inlining plugin setup in `nvim/init.lua`.
- Keep netrw disabled near the top of `nvim/init.lua`; `nvim-tree` assumes this.
- `nvim-tree` is opened on `VimEnter`; preserve the existing startup behavior that returns focus to the file buffer when launching with a file argument.
- Global indentation defaults are 4 spaces in `nvim/init.lua`, while language-specific overrides in `nvim/after/ftplugin/` switch TypeScript, Vue, and Lua to 2 spaces.
- JS/TS editor features are configured via `pmizio/typescript-tools.nvim` (not `nvim-lspconfig` in `lsp.lua`); keep Mason tool installs aligned with that stack.
- Formatting is configured via `conform.nvim` with per-filetype mappings (stylua, isort+black, eslint_d/prettierd/prettier, goimports/gofmt, csharpier) and an interactive save-time prompt (`Format before save?(y/n)`); avoid changing this behavior unintentionally.
- Linting runs automatically via `nvim-lint` on `BufEnter`, `BufWritePost`, and `InsertLeave`; JS/TS use `eslint_d`, Go uses `golangcilint`.
- CodeCompanion chat is configured to use the ACP `gemini_cli` adapter with `oauth-personal` auth in `nvim/lua/plugins/codecompanion.lua`.
