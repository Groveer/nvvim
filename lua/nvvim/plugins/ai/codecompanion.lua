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
      require_approval_before = false,
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
            system_prompt = {
              enabled = true, -- Enable the tools system prompt?
              replace_main_system_prompt = false, -- Replace the main system prompt with the tools system prompt?

              ---The tool system prompt
              ---@param args { tools: string[]} The tools available
              ---@return string
              prompt = function(_args)
                return "Do not return results immediately. Wait until the tool call is complete before returning the results."
              end,
            },
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
    "HakonHarnes/img-clip.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function(_, opts)
    vim.g.codecompanion_auto_tool_mode = true
    require("codecompanion").setup(opts)
  end,
}
