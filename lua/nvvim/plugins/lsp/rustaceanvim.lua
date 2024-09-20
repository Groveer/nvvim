return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      server = {
        on_attach = require("nvvim.configs").lsp_on_attach,
      },
    }
  end,
  ft = "rust",
}
