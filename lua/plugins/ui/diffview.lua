return {
  "sindrets/diffview.nvim",
  keys = {
    { "dv", "<CMD>DiffviewOpen<CR>", "n", desc = "Diffview Open diff view" },
    { "dc", "<CMD>DiffviewClose<CR>", "n", desc = "Diffview Close diff view" },
  },
  cmd = { "DiffviewOpen", "DiffviewClose" },
}
