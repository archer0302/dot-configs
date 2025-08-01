-- ~/.config/nvim/lua/plugins/lsp.lua

local language_servsers = {
  "roslyn",
  "clangd",
  "lua_ls",
  "basedpyright",
  "rust_analyzer",
  "vtsls",
  "vue_ls"
}

return {
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = "",
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

      local roslyn_ls_config = {
        cmd = {
          "dotnet",
          "/opt/roslyn-ls/Microsoft.CodeAnalysis.LanguageServer.dll",
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--stdio",
        },
      }



      vim.lsp.config("roslyn", roslyn_ls_config)
      vim.lsp.config("vtsls", vtsls_config)
      vim.lsp.config("vue_ls", vue_ls_config)
      vim.lsp.enable(language_servsers)
    end,
  },
}
