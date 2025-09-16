return {
  cmd = {
    "clangd",
    "-j=12",
    "--enable-config",
    "--background-index",
    "--pch-storage=memory",
    "--completion-style=detailed",
    "--limit-references=3000",
    "--limit-results=350",
    "--offset-encoding=utf-16",
    "--clang-tidy",
    "--all-scopes-completion",
    "--header-insertion=never",
    "--log=error",
  },
  filetypes = { "c", "cpp" },
  root_markers = { ".clangd", "compile_commands.json" },
  single_file_support = false,
  on_attach = function(client, bufnr)
    local lsp = vim.lsp
    local map = vim.keymap.set
    require("nvvim.configs.lsp").on_attach(client, bufnr)
    local function switch_source_header()
      local method_name = "textDocument/switchSourceHeader"
      local params = lsp.util.make_text_document_params(bufnr)
      client:request(method_name, params, function(err, result)
        if err then
          vim.notify(err.message, vim.log.levels.ERROR)
        end
        if not result then
          vim.notify("Corresponding file could not be determined", vim.log.levels.WARN)
          return
        end
        vim.cmd.edit(vim.uri_to_fname(result))
      end, bufnr)
    end
    map("n", "gs", switch_source_header, { noremap = true, silent = true, desc = "Lsp Switch C/C++ Source/Header" })
  end,
}
