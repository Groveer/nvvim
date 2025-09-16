return {
  "mrcjkb/rustaceanvim",
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      server = {
        on_attach = require("nvvim.configs.lsp").on_attach,
      },
    }
  end,
  ft = "rust",
}
