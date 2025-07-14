return {
  "olimorris/codecompanion.nvim",
  keys = {
    {
      "<leader>aa",
      "<CMD>CodeCompanionActions<CR>",
      mode = { "n", "v" },
      desc = "CodeCompanion: actions",
    },
    {
      "<leader>ag",
      "<CMD>CodeCompanionChat Toggle<CR>",
      mode = { "n", "v" },
      desc = "CodeCompanion: toggle",
    },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionCmd",
    "CodeCompanionChat",
  },
  opts = {
    opts = {
      language = "Chinese",
      send_code = true,
      completion_provider = "blink"
    },
    display = {
      action_palette = {
        provider = "fzf_lua",
      },
    },
    strategies = {
      chat = {
        adapter = {
          name = "copilot",
          model = "gpt-4.1",
          -- model = "claude-3.7-sonnet",
          -- model = "claude-sonnet-4",
          -- model = "gemini-2.5-pro",
        },
        slash_commands = {
          ["buffer"] = {
            opts = { provider = "fzf_lua" },
          },
          ["fetch"] = {
            opts = { provider = "fzf_lua" },
          },
          ["file"] = {
            opts = { provider = "fzf_lua" },
          },
          ["help"] = {
            opts = { provider = "fzf_lua" },
          },
          ["image"] = {
            opts = { provider = "fzf_lua" },
          },
          ["symbols"] = {
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
