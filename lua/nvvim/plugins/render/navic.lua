return {
  "SmiteshP/nvim-navic",
  event = "LspAttach",
  config = function(_, opts)
    local cache_dir = vim.g.base46_cache .. "navic"
    if vim.g.base46_cache and vim.uv.fs_stat(cache_dir) then
      dofile(cache_dir)
    end

    require("nvim-navic").setup(opts)
  end,
}
