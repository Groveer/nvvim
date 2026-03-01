return {
  "Saecki/crates.nvim",
  event = "BufRead Cargo.toml",
  opts = {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
    popup = {
      autofocus = true,
      border = "rounded",
    },
  },

  config = function(_, opts)
    return require("crates").setup(opts)
  end,
}
