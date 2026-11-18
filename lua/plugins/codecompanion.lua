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
      -- log_level = "DEBUG",
    },
    display = {
      chat = {
        start_in_insert_mode = true,
        window = {
          layout = "float", -- Can be "float", "vertical", "horizontal", "tab" or "buffer"
          relative = "editor",
          border = "rounded",
          width = vim.o.columns - 4,
          height = vim.o.lines - 2,
        },
      },
    },
    prompt_library = {
      markdown = {
        dirs = {
          vim.fn.stdpath("config") .. "/prompts", -- Can be relative
        },
      },
    },
    skills = {
      dirs = {
        vim.fn.stdpath("config") .. "/skills",
      },
      ["qt"] = {
        description = "How I want code to be written in Qt",
        skills = {
          "qt-canvas2d",
          "qt-cmake-project",
          "qt-cpp-bug-fixer",
          "qt-cpp-docs",
          "qt-cpp-review",
          "qt-qml",
          "qt-qml-docs",
          "qt-qml-review",
          "qt-qml-profiler",
          "qt-qml-review",
          "qt-qml-test",
          "qt-qml-test-run",
          "qt-ui-design",
        },
      },
    },
    adapters = {
      http = {
        groveer = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            formatted_name = "Groveer",
            env = {
              url = "https://api.groveer.com",
              api_key = "AI_API_KEY",
            },
            schema = {
              model = {
                default = "group/pro",
              },
              think = {
                default = true,
              },
              num_ctx = {
                default = 1000 * 1000,
              },
            },
          })
        end,
        extend = {
          tavily = {
            env = {
              api_key = "TAVILY_API_KEY",
            },
          },
          jina = {
            env = {
              api_key = "JINA_API_KEY",
            },
          },
        },
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
        slash_commands = {
          ["fetch"] = {
            opts = {
              adapter = "jina", -- Can be "jina" or "markitdown"
            },
          },
        },
        tools = {
          ["web_search"] = {
            opts = {
              adapter = "tavily",
            },
          },
          ["fetch_webpage"] = {
            opts = {
              adapter = "jina", -- Can be "jina" or "markitdown"
            },
          },
          opts = {
            approval_mode = "yolo", -- Can be "ask", "auto" or "yolo"
            auto_submit_errors = true, -- Send any errors to the LLM automatically?
            auto_submit_success = true, -- Send any successful output to the LLM automatically?
          },
        },
      },
      cmd = {
        adapter = "copilot",
      },
      background = {
        gates = {
          judge = {
            adapter = { name = "groveer", model = "group/flash" },
          },
        },
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

    -- Let our own `prompts/commit.md` be the only "Commit message" entry, so
    -- `:CodeCompanion /commit` and the Action Palette stop hitting the builtin
    -- `prompt_library/builtins/commit.md` first. Remove this once upstream
    -- offers a per-prompt toggle for builtin prompts.
    local prompt_library = require("codecompanion.prompt_library")
    local load_builtins = prompt_library.load_builtins
    prompt_library.load_builtins = function(context)
      return vim.tbl_filter(function(prompt)
        return not (prompt.opts and prompt.opts.alias == "commit")
      end, load_builtins(context))
    end
  end,
}
