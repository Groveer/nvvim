local M = {}

function M:load_variables()
  local os_name = vim.loop.os_uname().sysname
  self.is_mac = os_name == "Darwin"
  self.is_linux = os_name == "Linux"
  self.is_windows = os_name == "Windows_NT"
  self.is_wsl = vim.fn.has("wsl") == 1
  self.vim_path = vim.fn.stdpath("config")
  local home = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
  self.home = home
end

M:load_variables()

M.lazy_config = {
  spec = {
    { import = "nvvim.plugins" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = { colorscheme = { "nvchad" } },

  rocks = {
    enabled = false,
  },
  ui = {
    border = "rounded",
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}

M.lsp_on_attach = function(client, bufnr)
  local map = vim.keymap.set
  local fzf = require("fzf-lua")
  local lsp = vim.lsp
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end
  map("n", "gD", fzf.lsp_declarations, opts("Lsp Go to declaration"))
  map("n", "gd", fzf.lsp_definitions, opts("Lsp Go to definition"))
  map("n", "K", function()
    if client.name == "rust-analyzer" then
      vim.cmd.RustLsp({ "hover", "actions" })
    else
      lsp.buf.hover()
    end
  end, opts("Lsp hover information"))
  map("n", "gi", fzf.lsp_implementations, opts("Lsp Go to implementation"))
  map("n", "gl", function()
    lsp.codelens.run()
  end, opts("Lsp CodeLens action"))
  map("n", "<C-k>", lsp.buf.signature_help, opts("Lsp Show signature help"))
  map("n", "<leader>wa", lsp.buf.add_workspace_folder, opts("Lsp Add workspace folder"))
  map("n", "<leader>wr", lsp.buf.remove_workspace_folder, opts("Lsp Remove workspace folder"))
  map("n", "<leader>wl", function()
    print(vim.inspect(lsp.buf.list_workspace_folders()))
  end, opts("Lsp List workspace folders"))

  if client.name == "clangd" then
    map("n", "gs", "<cmd>ClangdSwitchSourceHeader<CR>", opts("Lsp Switch C/C++ header source"))
  end
  if client.name == "rust-analyzer" then
    map("n", "ge", function()
      vim.cmd.RustLsp({ "explainError", "current" })
    end, opts("Lsp RustLsp explain error"))
  end

  map("n", "gy", fzf.lsp_typedefs, opts("Lsp Go to type definition"))
  map("n", "go", "<cmd>AerialToggle!<CR>", opts("Lsp Show outline"))
  map("n", "[", "<cmd>AerialPrev<CR>", opts("Lsp Previous symbol"))
  map("n", "]", "<cmd>AerialNext<CR>", opts("Lsp Next symbol"))

  map("n", "gr", function()
    local has_nvchad, renamer = pcall(require, "nvchad.lsp.renamer")
    if has_nvchad then
      renamer()
    else
      lsp.buf.rename()
    end
  end, opts("Lsp Renamer"))

  map({ "n", "v" }, "ga", function()
    if client.name == "rust-analyzer" then
      vim.cmd.RustLsp("codeAction")
    else
      fzf.lsp_code_actions()
    end
  end, opts("Lsp Code action"))
  map("n", "gh", fzf.lsp_references, opts("Lsp Show references"))

  local has_navic, navic = pcall(require, "nvim-navic")
  if has_navic and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

M.icons = {
  misc = {
    dots = "󰇘",
  },
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  mason = {
    package_pending = " ",
    package_installed = " ",
    package_uninstalled = " ",
  },
  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Ollama = "󰚩 ",
    Deepseek = "󰚩 ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}

return M
