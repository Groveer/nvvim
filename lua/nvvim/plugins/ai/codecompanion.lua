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
        minimax = function()
          return require("codecompanion.adapters").extend("anthropic", {
            url = "https://api.minimaxi.com/anthropic/v1/messages",
            env = {
              api_key = "MINIMAX_API_KEY",
            },
            schema = {
              model = {
                default = "MiniMax-M2",
              },
              think = {
                default = true,
              },
              num_ctx = {
                default = 1638400,
              },
            },
          })
        end,
      },
    },
    opts = {
      language = "Chinese",
      send_code = true,
      completion_provider = "blink",
      requires_approval = false,
    },
    prompt_library = {
      ["Generate a Commit Message"] = {
        strategy = "chat",
        description = "Generate a commit message",
        opts = {
          index = 10,
          is_default = true,
          is_slash_cmd = true,
          short_name = "commit",
          user_prompt = true,
          auto_submit = true,
        },
        prompts = {
          {
            role = "user",
            content = function()
              return string.format(
                [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```

Commit content should be written in the following format, And use markdown syntax to display:

```text
<type>[optional scope]: <english description>

[English body]

[Chinese body]

Log: [short description of the change use chinese language]
PMS: <BUG-number>(for bugfix) or <TASK-number>(for add feature) (Must include 'BUG-' or 'TASK-', If the user does not provide a number, remove this line.)
Influence: Explain in Chinese the potential impact of this submission.
```

The body line cannot exceed 80 characters.

If the modification scope is small, you can omit both bodies line.
If you do not omit the body, then do not omit any bodies.

Submit information content based on the user's intention below:
]],
                vim.fn.system("git --no-pager diff --no-ext-diff --staged")
              )
            end,
            opts = {
              contains_code = true,
            },
          },
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
    strategies = {
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
  },

  config = function(_, opts)
    vim.g.codecompanion_auto_tool_mode = true
    require("codecompanion").setup(opts)
  end,
}
