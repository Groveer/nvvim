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

function M:load_python()
  -- Setup Python provider with dedicated venv
  local venv_dir = vim.fn.stdpath("config") .. "/.venv"
  local venv_python = venv_dir .. "/bin/python"

  if not vim.uv.fs_stat(venv_dir) then
    vim.notify("Creating Python venv for Neovim...", vim.log.levels.INFO)
    vim.fn.system({ "python", "-m", "venv", venv_dir })
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to create venv: " .. venv_dir, vim.log.levels.ERROR)
    else
      vim.notify("Installing pynvim...", vim.log.levels.INFO)
      vim.fn.system({ venv_python, "-m", "pip", "install", "pynvim" })
      if vim.v.shell_error ~= 0 then
        vim.notify("Failed to install pynvim", vim.log.levels.ERROR)
      end
    end
  end

  vim.g.python3_host_prog = venv_python
end

M:load_variables()
M:load_python()

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
