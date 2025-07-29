-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("omnisharp")
      vim.lsp.enable("clangd")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("rust_analyzer")

      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = "",
        languages = { 'vue' },
        configNamespace = 'typescript',
      }
      local vtsls_config = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      }
      -- If you are on most recent `nvim-lspconfig`
      local vue_ls_config = {
        filetypes = { "vue" },
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
      }

      -- nvim 0.11 or above
      vim.lsp.config('vtsls', vtsls_config)
      vim.lsp.config('vue_ls', vue_ls_config)
      vim.lsp.enable({ 'vtsls', 'vue_ls' })
    end,
  },
}
