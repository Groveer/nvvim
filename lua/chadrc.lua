-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@class ChadrcConfig
local M = {}

M.ui = {
  telescope = { style = "bordered" }, -- borderless / bordered
  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "git", "navic", "%=", "diagnostics", "lsp", "cursor", "cwd" },
    modules = {
      navic = function()
        local ok, navic = pcall(require, "nvim-navic")
        if not ok then
          return ""
        end
        return " %#StText# " .. navic.get_location()
      end,
      lsp = function()
        if rawget(vim, "lsp") then
          for _, client in ipairs(vim.lsp.get_clients()) do
            if client.attached_buffers[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)] then
              local ok, icons = pcall(require, "nvim-web-devicons")
              if not ok then
                return "%#St_Lsp#" .. "   " .. client.name .. " "
              end
              local icon, hl = icons.get_icon_by_filetype(vim.bo.filetype, { default = false })
              if not icon then
                return "%#St_Lsp#" .. "   " .. client.name .. " "
              end
              return "%#" .. hl .. "#" .. icon .. " " .. client.name .. " "
            end
          end
        end

        return ""
      end,
      cursor = "%#St_pos_text# %l:%c  ",
    },
  },
  nvdash = {
    load_on_startup = true,
    buttons = {
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
      function()
        local stats = require("lazy").stats()
        local plugins = "  Loaded " .. stats.count .. " plugins in "
        local time = math.floor(stats.startuptime) .. " ms   "
        return plugins .. time
      end,
    },
  },
}

M.base46 = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "tokyonight" },
  transparency = true,
  integrations = {
    "notify",
    "todo",
    "navic",
    "rainbowdelimiters",
  },
  hl_override = {
    NvDashButtons = { fg = "yellow" },
    LspInlayHint = { bg = "NONE" },
  },
}

M.lsp = {
  signature = false,
  hover = false,
  semantic_tokens = false,
}

M.term = {
  -- hl = "Normal:term,WinSeparator:WinSeparator",
  float = {
    relative = "editor",
    row = 0,
    col = 0,
    width = 1,
    height = 1,
    border = "rounded",
  },
}

return M
