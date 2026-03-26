return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeFocus" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "left",
      },
    })
  end,
}
