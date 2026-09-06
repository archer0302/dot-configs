-- clangd: override only cmd (root markers / filetypes come from nvim-lspconfig's defaults)
return {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
  },
}
