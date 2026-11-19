-- Global variables shared across the config, stored as `vim.g.cfg_*`.
--
-- This module is pure data with no side effects: plugins read `vim.g.cfg_*`
-- instead of requiring config modules, so they stay decoupled from `configs`.

local os_name = vim.uv.os_uname().sysname

vim.g.cfg_is_mac = os_name == "Darwin"
vim.g.cfg_is_linux = os_name == "Linux"
vim.g.cfg_is_windows = os_name == "Windows_NT"
vim.g.cfg_is_wsl = vim.fn.has("wsl") == 1
vim.g.cfg_vim_path = vim.fn.stdpath("config")
vim.g.cfg_home = vim.g.cfg_is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
