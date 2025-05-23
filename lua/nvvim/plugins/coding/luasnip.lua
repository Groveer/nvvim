local build_cmd = not require("nvvim.configs").is_windows and "make install_jsregexp" or ""
vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/snips"

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    version = "v2.*",
    build = build_cmd,
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      -- vscode format
      require("luasnip.loaders.from_vscode").lazy_load({ exclude = vim.g.vscode_snippets_exclude or {} })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

      -- snipmate format
      require("luasnip.loaders.from_snipmate").load()
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

      -- lua format
      require("luasnip.loaders.from_lua").load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  -- blink.cmp integration
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      snippets = {
        preset = "luasnip",
      },
    },
  },
}
