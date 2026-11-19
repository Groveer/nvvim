-- Python support: a dedicated venv used by Neovim's provider and by any Python
-- tooling the config shells out to (e.g. codecompanion's markitdown).
--
-- The venv lives in `stdpath("data")` rather than `stdpath("config")`: it is
-- machine state, not config. It survives a config re-clone and can never be
-- committed to the dotfiles repo by accident.
--
-- Note: `vim.g.python3_host_prog` ONLY configures the embedded :python3
-- provider. It does not touch $PATH, so `:!python`, `:terminal` and
-- job-spawned scripts keep using the system interpreter unless we export the
-- environment ourselves.

local M = {}

local is_windows = vim.g.cfg_is_windows
local sep = is_windows and ";" or ":"

---@return string
function M.venv_dir()
  return vim.fn.stdpath("data") .. "/.venv"
end

---@return string
function M.venv_bin()
  return M.venv_dir() .. (is_windows and "\\Scripts" or "/bin")
end

---@return string
function M.venv_exe()
  return M.venv_bin() .. (is_windows and "\\python.exe" or "/python")
end

--- Create the venv if the interpreter is missing.
---
--- The check is on the interpreter, not the directory: an existing `.venv`
--- without `bin/python` (or with a broken symlink) would otherwise never be
--- repaired.
---@return boolean ok
function M.ensure_venv()
  local exe = M.venv_exe()
  if vim.uv.fs_stat(exe) then
    return true
  end

  vim.notify("Creating Python venv for Neovim...", vim.log.levels.INFO)
  local base = vim.fn.executable("python3") == 1 and "python3" or "python"
  vim.fn.system({ base, "-m", "venv", M.venv_dir() })
  if vim.v.shell_error ~= 0 or not vim.uv.fs_stat(exe) then
    vim.notify("Failed to create venv: " .. M.venv_dir(), vim.log.levels.ERROR)
    return false
  end
  return true
end

--- Install a package into the venv unless it is already there.
---
--- Probing site-packages is much cheaper than shelling out to pip on every
--- startup, and it works for packages whose scripts are missing from bin/.
---@param module string importable module name, e.g. "pynvim" or "markitdown"
---@param spec string pip requirement spec, e.g. "pynvim" or "markitdown[all]"
---@return boolean ok
function M.ensure_package(module, spec)
  if not M.ensure_venv() then
    return false
  end

  local site_packages = is_windows and "/Lib/site-packages/" or "/lib/*/site-packages/"
  local probe = M.venv_dir() .. site_packages .. module:gsub("%.", "/") .. "*"
  if #vim.fn.glob(probe, false, true) > 0 then
    return true
  end

  vim.notify(("Installing %s into %s"):format(spec, M.venv_dir()), vim.log.levels.INFO)
  local out = vim.fn.system({ M.venv_exe(), "-m", "pip", "install", spec })
  if vim.v.shell_error ~= 0 then
    vim.notify(("Failed to install %s:\n%s"):format(spec, out), vim.log.levels.ERROR)
    return false
  end
  return true
end

--- Point Neovim and its child processes at the venv.
function M.setup()
  if not M.ensure_venv() then
    return
  end

  local venv_bin = M.venv_bin()
  vim.g.python3_host_prog = M.venv_exe()
  vim.env.VIRTUAL_ENV = M.venv_dir()

  local path = vim.env.PATH or ""
  local prepend = true
  for entry in path:gmatch("[^" .. sep .. "]+") do
    if entry == venv_bin then
      prepend = false
      break
    end
  end
  if prepend then
    vim.env.PATH = venv_bin .. sep .. path
  end

  -- `python3_host_prog` only feeds the embedded provider, which fails silently
  -- when pynvim is missing. A venv directory existing says nothing about
  -- pynvim, so probe the package itself.
  M.ensure_package("pynvim", "pynvim")
end

return M
