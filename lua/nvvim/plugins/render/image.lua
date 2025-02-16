return {
  "3rd/image.nvim",
  ft = { "image" },
  enabled = not require("nvvim.configs").is_windows,
  opts = {
    processor = "magick_cli", -- make sure you have imagemagick installed
  },
  config = function(_, opts)
    require("image").setup(opts)
  end,
}
