return {
  "elanmed/fzf-lua-frecency.nvim",
  opts = {
    fzf_opts = { ["--no-sort"] = false },
  },
  config = function(_, opts)
    require("fzf-lua-frecency").setup(opts)
  end,
}
