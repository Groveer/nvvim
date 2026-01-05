return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "css",
      "go",
      "html",
      "ini",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "meson",
      "python",
      "qmljs",
      "rust",
      "typescript",
      "vim",
      "yaml",
      "diff",
    },
  },

  config = function(_, opts)
    -- use treesitter for syntax highlighting
    -- vim.cmd.syntax("off")
    -- vim.api.nvim_create_autocmd("BufReadPost", {
    --     pattern = opts.ensure_installed,
    --     callback = function()
    --         -- can start a specific treesitter on a specific buffer also
    --         -- vim.treesitter.start(0, "c")
    --         vim.treesitter.start()
    --     end,
    --     once = true,
    -- })
    require('nvim-treesitter').install(opts.ensure_installed)
  end,
}
