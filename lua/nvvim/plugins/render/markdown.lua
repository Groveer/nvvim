local fts = { "markdown", "vimwiki", "codecompanion" }
return {
  "MeanderingProgrammer/render-markdown.nvim",
  keys = {
    {
      "<leader>mg",
      function()
        require("render-markdown").toggle()
      end,
      mode = { "n" },
      desc = "Markdown render toggle",
    },
  },
  opts = {
    file_types = fts,
    latex = { enabled = false },
    completions = {
      lsp = { enabled = true },
      blink = { enabled = true },
    },
  },
  ft = fts,
  config = function(_, opts)
    vim.treesitter.language.register("markdown", "vimwiki")
    require("render-markdown").setup(opts)
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  }, -- if you prefer nvim-web-devicons
}
