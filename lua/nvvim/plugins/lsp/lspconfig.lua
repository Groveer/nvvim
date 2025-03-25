-- set env PATH for mason
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local servers = {
  html = {},
  clangd = {
    cmd = {
      "clangd",
      "-j=12",
      "--enable-config",
      "--background-index",
      "--pch-storage=memory",
      "--completion-style=detailed",
      "--header-insertion-decorators",
      "--header-insertion=iwyu",
      "--limit-references=3000",
      "--limit-results=350",
      "--offset-encoding=utf-16",
      "--clang-tidy",
      "--all-scopes-completion",
      "--header-insertion=never",
    },
    filetypes = { "c", "cpp" },
    single_file_support = false,
  },
  pylsp = {
    plugins = {
      pycodestyle = {
        ignore = { "W391" },
        maxLineLength = 100,
      },
    },
  },
  bashls = {},
  jsonls = {},
  neocmake = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
            vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
  taplo = {},
  ts_ls = {},
  lemminx = {},
}

local on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  config = function()
    require("lspconfig.ui.windows").default_options.border = "rounded"
    local has_nvui, nvui = pcall(require, "nvchad.lsp")
    if has_nvui then
      nvui.diagnostic_config()
    end

    local has_cmp, blink_cmp = pcall(require, "blink.cmp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and blink_cmp.get_lsp_capabilities({}, false) or {}
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
      s_opts.on_attach = require("nvvim.configs").lsp_on_attach
      s_opts.capabilities = capabilities

      lspconfig[name].setup(s_opts)
    end
  end,
}
