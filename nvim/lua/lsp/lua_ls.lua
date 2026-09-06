-- Tell lua_ls to recognize the 'vim' global
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
