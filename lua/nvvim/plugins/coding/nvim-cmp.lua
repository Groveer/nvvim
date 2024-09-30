vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/snips"

local function cmp_opts()
  local cmp = require("cmp")

  local cmp_ui = {}
  local has_nvconfig, nvconfig = pcall(require, "nvconfig")
  if not has_nvconfig then
    cmp_ui = {
      icons = true,
      lspkind_text = true,
      style = "default",
    }
  else
    cmp_ui = nvconfig.ui.cmp
  end
  local cmp_style = cmp_ui.style

  local field_arrangement = {
    atom = { "kind", "abbr", "menu" },
    atom_colored = { "kind", "abbr", "menu" },
  }

  local formatting_style = {
    -- default fields order i.e completion word + item.kind + item.kind icons
    fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

    format = function(_, item)
      local icons = require("nvvim.configs").icons.kinds
      local icon = (cmp_ui.icons and icons[item.kind]) or ""

      if cmp_style == "atom" or cmp_style == "atom_colored" then
        icon = " " .. icon .. " "
        item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
        item.kind = icon
      else
        icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
        item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
      end

      return item
    end,
  }

  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end

  local options = {
    completion = {
      completeopt = "menu,menuone",
    },

    window = {
      completion = {
        side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
        scrollbar = false,
      },
      documentation = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc",
      },
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    formatting = formatting_style,

    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),

      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
    },
  }

  if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
    options.window.completion.border = border("CmpBorder")
  end
  return options
end

return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    {
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      -- autopairing of (){}[] etc
      "windwp/nvim-autopairs",
    },
    -- cmp sources plugins
    {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  },
  opts = cmp_opts,
  config = function(_, opts)
    local cache_dir = vim.g.base46_cache .. "cmp"
    if vim.g.base46_cache and vim.uv.fs_stat(cache_dir) then
      dofile(cache_dir)
    end

    local cmp = require("cmp")
    cmp.setup(opts)
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}
