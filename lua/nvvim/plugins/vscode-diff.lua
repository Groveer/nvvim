return {
  "esmuellert/vscode-diff.nvim",
  cmd = "CodeDiff",
  build = function()
    vim.fn.system(
      {
        "cmake",
        "-B",
        "build",
        "-G",
        "Ninja",
      }
    )
    vim.fn.system({ "cmake", "--build", "build" })
  end,
  keys = {
    { "dv", "<CMD>CodeDiff<CR>", mode = "n", desc = "CodeDiff Open diff view" },
    { "dc", "<CMD>CodeDiff<CR>", mode = "n", desc = "CodeDiff Close diff view" },
  },
  dependencies = { "MunifTanjim/nui.nvim" },
}
