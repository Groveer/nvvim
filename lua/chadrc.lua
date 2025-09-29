-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@class ChadrcConfig
local M = {}

local lsp_ext_icons = {
  copilot = "",
  ["render-markdown"] = "",
}

local function statusline_navic_config()
  if next(vim.lsp.get_clients()) == nil then
    return ""
  end
  local ok, navic = pcall(require, "nvim-navic")
  if not ok then
    return ""
  end
  return " %#StText# " .. navic.get_location()
end

local function statusline_lsp_config()
  local lsp_index = 1
  local lsp_names = {}
  local timer = nil
  local last_buf = 0

  local function update_lsp_names()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local non_copilot, copilot = {}, {}
    for _, client in ipairs(clients) do
      if client.name == "copilot" then
        table.insert(copilot, client)
      else
        table.insert(non_copilot, client)
      end
    end
    local result = {}
    -- Make sure copilot is always at the end
    for _, c in ipairs(non_copilot) do
      table.insert(result, c)
    end
    for _, c in ipairs(copilot) do
      table.insert(result, c)
    end
    lsp_names = result
    if lsp_index > #lsp_names then
      lsp_index = 1
    end
  end

  local function start_timer()
    if timer then
      return
    end
    timer = vim.uv.new_timer()
    if not timer then
      vim.notify("Failed to create timer", vim.log.levels.ERROR)
      return
    end
    timer:start(
      0,
      5000,
      vim.schedule_wrap(function()
        update_lsp_names()
        if #lsp_names > 0 then
          lsp_index = lsp_index % #lsp_names + 1
        end
      end)
    )
  end

  return function()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
    local lsp_hl = "%#St_Lsp#"
    -- Reset lsp_index and update lsp_names when switching buffers
    if last_buf ~= bufnr then
      lsp_index = 1
      last_buf = bufnr
      update_lsp_names()
    end
    start_timer()
    if #lsp_names == 0 then
      return ""
    end
    local client = lsp_names[lsp_index] or lsp_names[1]
    local icon = lsp_ext_icons[client.name]
    if icon then
      return lsp_hl .. icon .. " " .. client.name .. " "
    end
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok then
      return lsp_hl .. "   " .. client.name .. " "
    end
    icon, lsp_hl = icons.get_icon_by_filetype(vim.bo.filetype, { default = false })
    if not icon then
      lsp_hl = "%#St_Lsp#"
      return lsp_hl .. "   " .. client.name .. " "
    end
    return "%#" .. lsp_hl .. "#" .. icon .. " " .. client.name .. " "
  end
end

M.ui = {
  cmp = {
    icons_left = true, -- only for non-atom styles!
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true, -- will work for css lsp too
      icon = "󱓻",
    },
  },
  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "git", "navic", "%=", "diagnostics", "cursor", "lsp", "cwd" },
    modules = {
      navic = statusline_navic_config,
      lsp = statusline_lsp_config(),
      cursor = "%#St_pos_text# %l:%c  ",
    },
  },
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "  Recent Files", keys = "Spc f o", cmd = "FzfLua oldfiles" },
    { txt = "  Find File", keys = "Spc f f", cmd = "FzfLua files" },
    { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "FzfLua live_grep" },
    { txt = "󱥚  Themes", keys = "Spc t h", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}

M.base46 = {
  theme = "chadracula-evondev",
  theme_toggle = { "chadracula-evondev", "chadracula-evondev" },
  transparency = true,
  integrations = {
    "notify",
    "todo",
    "navic",
    "diffview",
    "semantic_tokens",
    "blink-pair",
  },
  hl_override = {
    NvDashButtons = { fg = "yellow" },
    LspInlayHint = { bg = "NONE" },
  },
}

M.lsp = {
  signature = false,
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
