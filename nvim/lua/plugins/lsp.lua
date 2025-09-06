-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
--     config = function()
--       local vue_plugin = {
--         name = "@vue/typescript-plugin",
--         location = "",
--         languages = { "vue" },
--         configNamespace = "typescript",
--       }
-- 
--       local vtsls_config = {
--         settings = {
--           vtsls = {
--             tsserver = {
--               globalPlugins = {
--                 vue_plugin,
--               },
--             },
--           },
--         },
--         filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
--       }
-- 
--       -- If you are on most recent `nvim-lspconfig`
--       local vue_ls_config = {
--         settings = {
--           vue = {
--             suggest = {
--               componentNameCasing = "preferKebabCase"
--             },
--             server = {
--               hybridMode = true
--             }
--           }
--         },
--         filetypes = { "vue" },
--       }
-- 
--       local clangd_config = {
--         cmd = {
--           "clangd",
--           "--query-driver=/usr/bin/clang",
--         },
--         filetypes = { "c", "cpp" },
--       }
-- 
--       -- vim.lsp.config("vtsls", vtsls_config)
--       -- vim.lsp.config("vue_ls", vue_ls_config)
--       vim.lsp.config("clangd", clangd_config)
--     end,
  },
}
