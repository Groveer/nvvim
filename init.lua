vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "
vim.uv = vim.uv or vim.loop

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.api.nvim_echo({ { "Initializing, please wait..." } }, true, {})
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

if vim.uv.fs_stat(vim.g.base46_cache) then
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
end

require("configs.options")
require("configs.autocmds")

require("lazy").setup(require("configs").lazy_config)

vim.schedule(function()
  require("configs.mappings")
end)
