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
    },
    adapters = {
      http = {
        groveer = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            formatted_name = "Groveer",
            env = {
              url = "https://axonhub.groveer.com",
              api_key = "GROVEER_API_KEY",
            },
            schema = {
              model = {
                default = "minimaxai/minimax-m2.5",
              },
              think = {
                default = true,
              },
              num_ctx = {
                default = 200 * 1024,
              },
            },
          })
        end,
      },
    },
    interactions = {
      inline = {
        adapter = "copilot",
      },
      chat = {
        adapter = "groveer",
        keymaps = {
          clear = {
            modes = { n = "gX" },
          },
        },
        roles = { -- make rendered roles nicer
          llm = function(adapter)
            return (" %s"):format(adapter.formatted_name)
          end,
          user = " User",
        },
        tools = {
          opts = {
            auto_submit_errors = true, -- Send any errors to the LLM automatically?
            auto_submit_success = true, -- Send any successful output to the LLM automatically?
          },
        },
      },
      cmd = {
        adapter = "copilot",
      },
    },
    extensions = {
      history = {
        enabled = true, -- defaults to true
        dir_to_save = vim.fn.stdpath("data") .. "/history/codecompanion-history",
      },
      spinner = {},
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim", -- history extension
    "franco-ruggeri/codecompanion-spinner.nvim",
  },

  config = function(_, opts)
    local history_dir = vim.fn.stdpath("data") .. "/history"
    if vim.fn.isdirectory(history_dir) == 0 then
      vim.fn.mkdir(history_dir, "p")
    end

    require("codecompanion").setup(opts)
  end,
}
