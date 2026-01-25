return {
  "esmuellert/vscode-diff.nvim",
  cmd = "CodeDiff",
  build = "cmake -B build -G Ninja && cmake --build build",
  keys = {
    { "dv", "<CMD>CodeDiff<CR>", mode = "n", desc = "CodeDiff Open diff view" },
    { "dc", "<CMD>CodeDiff<CR>", mode = "n", desc = "CodeDiff Close diff view" },
  },
  dependencies = { "MunifTanjim/nui.nvim" },
}
