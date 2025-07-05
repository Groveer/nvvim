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
    opts = {
      language = "Chinese",
      send_code = true,
    },
    display = {
      action_palette = {
        provider = "fzf_lua",
      },
    },
    adapters = {
      ds = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://ds.groveer.com", -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = "DS_API_KEY", -- optional: if your endpoint is authenticated
            chat_url = "/v1/chat/completions", -- optional: default value, override if different
            models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
          },
          schema = {
            model = {
              default = "deepseek-chat", -- define llm model to be used
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = {
          name = "ds",
          -- model = "claude-3.7-sonnet",
          -- model = "claude-sonnet-4",
          -- model = "gemini-2.5-pro",
        },
        slash_commands = {
          ["file"] = {
            opts = { provider = "fzf_lua" },
          },
          ["buffer"] = {
            opts = { provider = "fzf_lua" },
          },
        },
      },
      inline = {
        adapter = "ds",
      },
      cmd = {
        adapter = "ds",
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
