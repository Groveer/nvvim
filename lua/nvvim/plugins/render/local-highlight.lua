return {
  "tzachar/local-highlight.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function(_, opts)
    require("local-highlight").setup(opts)
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = { "*" },
      callback = function(data)
        require("local-highlight").attach(data.buf)
      end,
    })
  end,
}
