return {
  "olimorris/codecompanion.nvim",
  keys = {
    {
      "<leader>ca",
      "<CMD>CodeCompanionActions<CR>",
      mode = { "n", "v" },
      desc = "CodeCompanion: actions",
    },
  },
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              -- default = "claude-3.7-sonnet",
              default = "claude-sonnet-4",
              -- default = "gemini-2.5-pro",
            },
          },
        })
      end,
    },
    display = {
      action_palette = {
        provider = "fzf_lua",
      },
    },
    strategies = {
      chat = {
        slash_commands = {
          ["file"] = {
            opts = { provider = "fzf_lua" },
          },
          ["buffer"] = {
            opts = { provider = "fzf_lua" },
          },
        },
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
  dependencies = {
    "ravitemer/mcphub.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function(_, opts)
    require("codecompanion").setup(opts)
  end,
}
