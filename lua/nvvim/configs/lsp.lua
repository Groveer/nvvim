local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

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

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable({ "clangd", "lua_ls", "pylsp", "html", "bashls", "jsonls", "neocmake", "taplo", "ts_ls" })

-- Disable default lsp keymap
vim.keymap.set("n", "gr", "gr", { noremap = true, nowait = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach-config", {}),
  callback = function(args)
    local lsp = vim.lsp
    local map = vim.keymap.set
    local has_fzf, fzf = pcall(require, "fzf-lua")
    local function opts(desc)
      return { buffer = args.buf, desc = desc }
    end
    local client = assert(lsp.get_client_by_id(args.data.client_id))
    if client:supports_method(lsp.protocol.Methods.textDocument_implementation) then
      map("n", "gi", has_fzf and fzf.lsp_implementations or lsp.buf.implementation, opts("Lsp Go to implementation"))
    end

    if client:supports_method(lsp.protocol.Methods.textDocument_inlayHint) then
      lsp.inlay_hint.enable(false, { bufnr = args.buf })
    end

    if client:supports_method(lsp.protocol.Methods.textDocument_rename) then
      map("n", "gr", function()
        local has_nvchad, renamer = pcall(require, "nvchad.lsp.renamer")
        if has_nvchad then
          renamer()
        else
          lsp.buf.rename()
        end
      end, opts("Lsp Renamer"))
    end

    if client:supports_method(lsp.protocol.Methods.textDocument_codeAction) then
      map({ "n", "v" }, "ga", function()
        if client.name == "rust-analyzer" then
          vim.cmd.RustLsp("codeAction")
        else
          fzf.lsp_code_actions()
        end
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
        if client.name == "rust-analyzer" then
          vim.cmd.RustLsp({ "hover", "actions" })
        else
          lsp.buf.hover()
        end
      end, opts("Lsp Hover information"))
    end

    if client:supports_method(lsp.protocol.Methods.textDocument_codeLens) then
      map("n", "gl", function()
        lsp.codelens.run()
      end, opts("Lsp CodeLens action"))
      lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        buffer = args.buf,
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
    if client:supports_method(lsp.protocol.Methods.textDocument_formatting) then
      map({ "n", "v" }, "<leader>f", function()
        lsp.buf.format({ async = true })
      end, opts("Lsp Format document"))
    end

    -- -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    -- if client:supports_method(lsp.protocol.Methods.textDocument_completion) then
    --   -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    --   -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    --   -- client.server_capabilities.completionProvider.triggerCharacters = chars
    --
    --   lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    -- end

    if client:supports_method("textDocument/switchSourceHeader") then
      local function switch_source_header()
        local bufnr = vim.api.nvim_get_current_buf()
        local params = {
          uri = vim.uri_from_bufnr(bufnr),
        }
        client:request("textDocument/switchSourceHeader", params, function(err, result, ctx)
          if err then
            vim.notify(string.format("Error on LSP request '%s': %s", ctx.method, err.message), vim.log.levels.ERROR)
            return
          end

          if not result or type(result) ~= "string" or result == "" then
            vim.notify("Corresponding file could not be determined by the language server.", vim.log.levels.WARN)
            return
          end

          vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
        end, bufnr)
      end
      map("n", "gs", switch_source_header, { noremap = true, silent = true, desc = "switch Source/Header" })
    end

    if client.name == "rust-analyzer" then
      map("n", "ge", function()
        vim.cmd.RustLsp({ "explainError", "current" })
      end, opts("Lsp RustLsp explain error"))
    end

    map("n", "go", "<cmd>AerialToggle!<CR>", opts("Lsp Show outline"))
    map("n", "[", "<cmd>AerialPrev<CR>", opts("Lsp Previous symbol"))
    map("n", "]", "<cmd>AerialNext<CR>", opts("Lsp Next symbol"))

    local has_navic, navic = pcall(require, "nvim-navic")
    if has_navic and client.server_capabilities.documentSymbolProvider then
      navic.attach(client, args.buf)
    end
  end,
})
