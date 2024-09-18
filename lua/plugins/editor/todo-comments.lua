return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  config = function(_, opts)
    local has_base46, _ = pcall(require, "base46")
    if has_base46 then
      dofile(vim.g.base46_cache .. "todo")
    end

    require("todo-comments").setup(opts)
  end,
}
