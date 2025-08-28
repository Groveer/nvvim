return {
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = { "NvChad/ui" },
    config = function(_, opts)
      opts.override = require("nvchad.icons.devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },
}
