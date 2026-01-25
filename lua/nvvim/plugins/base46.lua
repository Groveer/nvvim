vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

return {
  "NvChad/base46",
  build = function()
    require("base46").load_all_highlights()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
      dofile(vim.g.base46_cache .. v)
    end
  end,
}
