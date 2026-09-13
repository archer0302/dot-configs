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
--
-- Only servers with no good system story go here. clangd comes from the Xcode
-- command line tools and rust_analyzer from rustup, so mason must NOT install
-- them: its copies would shadow the toolchain-managed ones on $PATH and drift
-- out of sync with the compiler they are meant to match.
--
-- NOTE: mason-lspconfig v2 auto-enables every installed server it recognises,
-- not just the ones listed here -- so anything left in the mason directory
-- from an older config is still being enabled for its filetypes. `:Mason` ->
-- `X` prunes those.
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'vtsls' },
})

-- Linter/Formatter（非 LSP）：交給 mason-tool-installer
require('mason-tool-installer').setup({
  ensure_installed = { 'ruff', 'stylua' },
})
