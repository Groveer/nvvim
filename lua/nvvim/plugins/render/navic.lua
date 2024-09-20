return {
  "SmiteshP/nvim-navic",
  event = "LspAttach",
  config = function(_, opts)
    local has_base46, _ = pcall(require, "base46")
    if has_base46 then
      dofile(vim.g.base46_cache .. "navic")
    end

    require("nvim-navic").setup(opts)
  end,
}
