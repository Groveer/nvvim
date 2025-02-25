return {
  "sontungexpt/stcursorword",
  event = { "BufReadPost", "BufNewFile" },
  config = function(_, opts)
    require("stcursorword").setup(opts)
  end,
}
