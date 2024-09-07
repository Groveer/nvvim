return {
  "numToStr/Comment.nvim",
  keys = { { "gcc", "gbc", mode = "n" }, { "gc", "gb", mode = "v" } },
  opts = function()
    return {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
  config = function(_, opts)
    require("Comment").setup(opts)
    require("Comment.ft").set("qmljs", "//%s")
  end,
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}
