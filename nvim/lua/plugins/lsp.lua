-- ~/.config/nvim/lua/plugins/lsp.lua

local language_servsers = {
  "omnisharp",
  "clangd",
  "lua_ls",
  "basedpyright",
  "rust_analyzer",
  "vtsls",
  "vue_ls"
}

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin/",
        languages = { "vue" },
        configNamespace = "typescript",
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
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      }

      -- If you are on most recent `nvim-lspconfig`
      local vue_ls_config = {
        settings = {
          ["vue.suggest.componentNameCasing"] = "preferKebabCase",
          vue = {
            suggest = {
              componentNameCasing = "preferKebabCase"
            },
            server = {
              hybridMode = true
            }
          }
        },
        filetypes = { "vue" },
      }

      -- nvim 0.11 or above
      vim.lsp.config("vtsls", vtsls_config)
      vim.lsp.config("vue_ls", vue_ls_config)
      vim.lsp.enable(language_servsers)
    end,
  },
}
