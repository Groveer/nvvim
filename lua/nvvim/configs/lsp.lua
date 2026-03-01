---@diagnostic disable: undefined-field, need-check-nil
local is_windows = vim.uv.os_uname().sysname == "Windows_NT"
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

local M = {}

-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
M.require_servers = {
  "clangd",
  "copilot",
  "emmylua_ls",
  "pylsp",
  "html",
  "bashls",
  "jsonls",
  "neocmake",
  "taplo",
  "ts_ls",
  "qmlls",
  -- "rust_analyzer", -- rust lsp handled by rustaceanvim plugin
  "mesonlsp",
}

local has_nvui, nvui = pcall(require, "nvchad.lsp")
if has_nvui then
  nvui.diagnostic_config()
end

M.capabilities_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Setup nvim-cmp, if installed
  local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities()
  end

  -- Setup blink.nvim, if installed
  local blink_status_ok, blink_lsp = pcall(require, "blink.cmp")
  if blink_status_ok then
    capabilities = blink_lsp.get_lsp_capabilities(capabilities)
  end

  capabilities.workspace.executeCommand = {
    dynamicRegistration = true,
  }
  return capabilities
end

M.on_attach = function(client, bufnr)
  local lsp = vim.lsp
  local map = vim.keymap.set
  local has_fzf, fzf = pcall(require, "fzf-lua")
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end
  if client:supports_method(lsp.protocol.Methods.textDocument_implementation) then
    map("n", "gi", has_fzf and fzf.lsp_implementations or lsp.buf.implementation, opts("Lsp Go to implementation"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_inlayHint) then
    lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_rename) then
    map("n", "gr", function()
      lsp.buf.rename()
    end, opts("Lsp Renamer"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_codeAction) then
    map({ "n", "v" }, "ga", function()
      fzf.lsp_code_actions()
    end, opts("Lsp Code action"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_declaration) then
    map("n", "gD", has_fzf and fzf.lsp_declarations or lsp.buf.declaration, opts("Lsp Go to declaration"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_definition) then
    map("n", "gd", has_fzf and fzf.lsp_definitions or lsp.buf.definition, opts("Lsp Go to definition"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_typeDefinition) then
    map("n", "gy", has_fzf and fzf.lsp_typedefs or lsp.buf.type_definition, opts("Lsp Go to type definition"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_references) then
    map("n", "gh", has_fzf and fzf.lsp_references or lsp.buf.references, opts("Lsp Show references"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_signatureHelp) then
    map("n", "<C-k>", lsp.buf.signature_help, opts("Lsp Show signature help"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_hover) then
    map("n", "K", function()
      lsp.buf.hover()
    end, opts("Lsp Hover information"))
  end

  if client:supports_method(lsp.protocol.Methods.textDocument_codeLens) then
    map("n", "gl", function()
      lsp.codelens.run()
    end, opts("Lsp CodeLens action"))
    lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        lsp.codelens.refresh()
      end,
    })
  end

  if client:supports_method(lsp.protocol.Methods.workspace_symbol) then
    map(
      "n",
      "<leader>ss",
      has_fzf and fzf.lsp_workspace_symbols or lsp.buf.workspace_symbol,
      opts("Lsp Workspace symbols")
    )
  end
  if client:supports_method(lsp.protocol.Methods.textDocument_documentSymbol) then
    map(
      "n",
      "<leader>sd",
      has_fzf and fzf.lsp_document_symbols or lsp.buf.document_symbol,
      opts("Lsp Document symbols")
    )
  end

  -- -- Use confim.nvim for format
  -- if client:supports_method(lsp.protocol.Methods.textDocument_formatting) then
  --   map({ "n", "v" }, "<leader>f", function()
  --     lsp.buf.format({ async = true })
  --   end, opts("Lsp Format document"))
  -- end

  -- -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
  -- if client:supports_method(lsp.protocol.Methods.textDocument_completion) then
  --   -- Optional: trigger autocompletion on EVERY keypress. May be slow!
  --   -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
  --   -- client.server_capabilities.completionProvider.triggerCharacters = chars
  --
  --   lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  -- end

  map("n", "go", "<cmd>AerialToggle!<CR>", opts("Lsp Show outline"))
  map("n", "[", "<cmd>AerialPrev<CR>", opts("Lsp Previous symbol"))
  map("n", "]", "<cmd>AerialNext<CR>", opts("Lsp Next symbol"))

  local has_navic, navic = pcall(require, "nvim-navic")
  if has_navic and client.server_capabilities and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  local function restart_lsp_clients()
    local clients = lsp.get_clients({ bufnr = bufnr })
    for _, _client in ipairs(clients) do
      client.stop()
    end

    vim.defer_fn(function()
      vim.cmd("write")
      vim.cmd("edit") -- Force buffer reload
    end, 100)
  end

  vim.api.nvim_create_user_command(
    "LspRestart",
    restart_lsp_clients,
    { desc = "Restart LSP clients for current buffer" }
  )
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    M.on_attach(client, bufnr)
  end,
})

---@type vim.lsp.Config
local lsp_config = {
  capabilities = M.capabilities_config(),
  root_markers = { ".git" },
}
vim.lsp.config("*", lsp_config)

vim.lsp.enable(M.require_servers)

-- Disable default lsp keymap
vim.keymap.set("n", "gr", "gr", { noremap = true, nowait = true })

return M
