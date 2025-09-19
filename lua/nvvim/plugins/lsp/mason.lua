return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts_extend = { "ensure_installed" },
  opts = {
    PATH = "skip",
    -- https://mason-registry.dev/registry/list
    ensure_installed = {
      -- lua stuff
      "emmylua_ls",
      "stylua",

      -- web dev stuff
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "prettier",
      -- "vue-language-server",

      -- c/cpp stuff
      "clangd",
      "clang-format",

      -- bash stuff
      "bash-language-server",
      "shfmt",

      -- json stuff
      "json-lsp",

      -- python stuff
      "python-lsp-server",

      -- latex stuff
      -- "latexindent", -- formatter

      -- cmake stuff
      "neocmakelsp",

      -- meson stuff
      "mesonlsp",

      "taplo",
    },

    ui = {
      border = "rounded",
      icons = require("nvvim.configs").icons.mason,
    },

    max_concurrent_installers = 10,
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
