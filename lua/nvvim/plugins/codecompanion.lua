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
      mode = "n",
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
      completion_provider = "blink",
    },
    prompt_library = {
      markdown = {
        dirs = {
          vim.fn.stdpath("config") .. "/prompts", -- Can be relative
        },
      },
    },
    display = {
      chat = {
        start_in_insert_mode = true,
      },
      action_palette = {
        provider = "fzf_lua",
      },
    },
    adapters = {
      http = {
        uniontech = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://ai.uniontech.com/api",
              api_key = "UT_KEY",
            },
            schema = {
              model = {
                default = "kimi-k2",
              },
              think = {
                default = false,
              },
              num_ctx = {
                default = 1638400,
              },
            },
          })
        end,
      },
    },
    interactions = {
      inline = {
        adapter = {
          name = "uniontech",
          model = "kimi-k2",
        },
      },
      chat = {
        keymaps = {
          clear = {
            modes = { n = "gX" },
          },
        },
        opts = {
          completion_provider = "blink", -- blink|cmp|coc|default
        },
        adapter = {
          name = "uniontech",
          model = "kimi-k2",
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
          ["symbols"] = {
            opts = { provider = "fzf_lua" },
          },
        },
        tools = {
          opts = {
            auto_submit_errors = true, -- Send any errors to the LLM automatically?
            auto_submit_success = true, -- Send any successful output to the LLM automatically?
          },
        },
      },
    },
    extensions = {
      history = {
        enabled = true, -- defaults to true
        dir_to_save = vim.fn.stdpath("data") .. "/history/codecompanion-history",
        opts = {
          picker = "fzf_lua", --- ("telescope", "snacks", "fzf-lua", or "default")
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim", -- history extension
  },

  config = function(_, opts)
    vim.g.codecompanion_auto_tool_mode = true
    local history_dir = vim.fn.stdpath("data") .. "/history"
    if vim.fn.isdirectory(history_dir) == 0 then
      vim.fn.mkdir(history_dir, "p")
    end

    require("codecompanion").setup(opts)
  end,
}
