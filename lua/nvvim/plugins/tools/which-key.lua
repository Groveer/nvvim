return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts_extend = { "spec" },
  opts = {
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>a", group = "ai" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>s", group = "search" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  config = function(_, opts)
    local has_base46, _ = pcall(require, "base46")
    if has_base46 then
      dofile(vim.g.base46_cache .. "whichkey")
    end

    local wk = require("which-key")
    wk.setup(opts)
    if not vim.tbl_isempty(opts.defaults) then
      vim.notify("which-key: opts.defaults is deprecated. Please use opts.spec instead.", vim.log.levels.WARN)
      wk.register(opts.defaults)
    end
  end,
}