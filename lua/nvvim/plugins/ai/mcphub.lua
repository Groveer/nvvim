return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  opts = {
    auto_approve = true, -- Auto approve all MCP tool calls
    ui = {
      window = {
        border = "rounded",
      },
    },
  },
  config = function(_, opts)
    require("mcphub").setup(opts)
  end,
}
