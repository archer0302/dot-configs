-- LSP wiring.
--
-- Per-server settings live in lua/lsp/<name>.lua and are applied through
-- vim.lsp.config() below.
--
-- WHY NOT the native `nvim/lsp/<name>.lua` runtime directory: Neovim finds
-- every `lsp/<name>.lua` on the runtimepath and merges them with the LAST one
-- winning. nvim-lspconfig ships its own, and its directory sorts after the
-- config directory -- so a native user file silently loses any key lspconfig
-- also sets (clangd's `cmd`, for one). An explicit vim.lsp.config() call is
-- applied on top of all of them, while still inheriting lspconfig's defaults
-- for everything it doesn't mention (root_markers, filetypes, ...).
--
-- Adding a server: add its name to `servers`; add lua/lsp/<name>.lua only if
-- it needs settings beyond lspconfig's defaults.

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
})

-- LSP list to be enabled
local servers = { 'lua_ls', 'vtsls', 'clangd', 'rust_analyzer' }

for _, name in ipairs(servers) do
  local ok, settings = pcall(require, 'lsp.' .. name)
  if ok then vim.lsp.config(name, settings) end
end

vim.lsp.enable(servers)

-- LSP-driven auto-completion: trigger clangd (and all servers) on every keypress.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not (client and client:supports_method('textDocument/completion')) then return end
    -- Add identifier characters to triggerCharacters so completion fires on every keypress
    -- (default only triggers on server chars like '.', '->', '::'). Must run before enable().
    local provider = client.server_capabilities.completionProvider or {}
    local triggers = provider.triggerCharacters or {}
    for c = string.byte('a'), string.byte('z') do triggers[#triggers + 1] = string.char(c) end
    for c = string.byte('A'), string.byte('Z') do triggers[#triggers + 1] = string.char(c) end
    triggers[#triggers + 1] = '_'
    provider.triggerCharacters = triggers
    client.server_capabilities.completionProvider = provider
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
  end,
})

vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end,
  { noremap = true, silent = true, desc = 'LSP format buffer' })
