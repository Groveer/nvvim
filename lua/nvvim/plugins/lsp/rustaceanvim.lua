return {
  "mrcjkb/rustaceanvim",
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
    }
  end,
  ft = "rust",
}
