return {
  "mrcjkb/rustaceanvim",
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      server = {
        on_attach = function(client, bufnr)
          require("nvvim.configs.lsp").on_attach(client, bufnr)
          local lsp = vim.lsp
          local map = vim.keymap.set
          local function opts(desc)
            return { buffer = bufnr, desc = desc }
          end
          if client:supports_method(lsp.protocol.Methods.textDocument_codeAction) then
            map({ "n", "v" }, "ga", function()
              vim.cmd.RustLsp("codeAction")
            end, opts("Lsp Code action"))
          end
          if client:supports_method(lsp.protocol.Methods.textDocument_hover) then
            map("n", "K", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, opts("Lsp Hover information"))
          end
          map("n", "ge", function()
            vim.cmd.RustLsp({ "explainError", "current" })
          end, opts("Lsp RustLsp explain error"))
        end,
      },
    }
  end,
  ft = "rust",
}
