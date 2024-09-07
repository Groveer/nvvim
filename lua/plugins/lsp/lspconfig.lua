-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  html = {},
  clangd = {
    cmd = {
      "clangd",
      "-j=24",
      "--offset-encoding=utf-16",
      "--clang-tidy",
      "--all-scopes-completion",
      "--header-insertion=never",
    },
    filetypes = { "c", "cpp" },
    single_file_support = false,
  },
  pylsp = {},
  bashls = {},
  jsonls = {},
  neocmake = {},
  lua_ls = {},
  taplo = {},
  ts_ls = {},
}

local on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require("configs").icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = require("configs").icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = require("configs").icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require("configs").icons.diagnostics.Info,
          },
        },
      },
    }
    return ret
  end,
  config = function(_, opts)
    local has_base46, _ = pcall(require, "base46")
    if has_base46 then
      dofile(vim.g.base46_cache .. "lsp")
    end

    require("lspconfig.ui.windows").default_options.border = "rounded"
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {}
    )
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }
    local lspconfig = require("lspconfig")
    for name, s_opts in pairs(servers) do
      s_opts.on_init = on_init
      s_opts.on_attach = require("configs").lsp_on_attach
      s_opts.capabilities = capabilities

      lspconfig[name].setup(s_opts)
    end
  end,
}
