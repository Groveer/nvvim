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
    adapters = {
      http = {
        uniontech = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://ai.uniontech.com",
              api_key = "UT_KEY",
              chat_url = "/api/v1/chat/completions",
            },
            schema = {
              model = {
                default = "kimi-k2",
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
```

The body line cannot exceed 80 characters.

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
      chat = {
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
    vim.g.codecompanion_auto_tool_mode = true
    require("codecompanion").setup(opts)
  end,
}
