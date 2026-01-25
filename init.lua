---@diagnostic disable: undefined-field, deprecated
vim.uv = vim.uv or vim.loop

vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })

require("nvvim.configs.options")
require("nvvim.configs.autocmds")
require("nvvim.configs.keymap")
require("nvvim.configs.lsp")

require("zpack").setup({
  { import = "nvvim.plugins" },
  defaults = {
    confirm = false,
  },
  lazy = true,
})
