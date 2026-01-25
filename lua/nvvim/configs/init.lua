---@diagnostic disable: undefined-field
local M = {}

function M:load_variables()
  local os_name = vim.uv.os_uname().sysname
  self.is_mac = os_name == "Darwin"
  self.is_linux = os_name == "Linux"
  self.is_windows = os_name == "Windows_NT"
  self.is_wsl = vim.fn.has("wsl") == 1
  self.vim_path = vim.fn.stdpath("config")
  local home = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
  self.home = home
end

M:load_variables()

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
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = "󰌵 ",
    Info = " ",
  },
}

return M
