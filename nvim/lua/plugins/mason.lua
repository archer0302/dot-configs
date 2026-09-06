-- Mason: installs LSP servers and standalone tools.
--
-- The three plugins here are one unit and are configured in sequence:
-- mason itself must be set up before mason-lspconfig, which reads its registry.
-- Runs before plugins.lsp, which enables the servers.

vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim.git',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim.git',
})

-- Setup is required for Mason
require('mason').setup()

-- LSP：自動安裝 + 自動 enable
require('mason-lspconfig').setup({
  ensure_installed = { 'pyright', 'lua_ls' },
})

-- Linter/Formatter（非 LSP）：交給 mason-tool-installer
require('mason-tool-installer').setup({
  ensure_installed = { 'ruff', 'stylua' },
})
