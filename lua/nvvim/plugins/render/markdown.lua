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
    html = { enabled = false },
    yaml = { enabled = false },
    completions = {
      lsp = { enabled = true },
      blink = { enabled = true },
    },
    restart_highlighter = true,
    checkbox = {
      enabled = false, -- render checkbox by checkmate plugin
    },
  },
  ft = fts,
  config = function(_, opts)
    vim.treesitter.language.register("markdown", "vimwiki")
    require("render-markdown").setup(opts)
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  }, -- if you prefer nvim-web-devicons
}
