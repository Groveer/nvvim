return {
  "Saecki/crates.nvim",
  event = "BufRead Cargo.toml",
  opts = {
    src = {
      cmp = {
        enabled = true,
      },
    },
    lsp = {
      enabled = true,
      on_attach = require("configs").lsp_on_attach,
      actions = true,
      completion = true,
      hover = true,
    },
  },

  config = function(_, opts)
    local has_cmp, cmp = pcall(require, "cmp")
    if has_cmp then
      local config = cmp.get_config()
      table.insert(config.sources, 3, {
        name = "crates",
        max_item_count = 5,
      })
      cmp.setup(config)
    end
    return require("crates").setup(opts)
  end,
}
