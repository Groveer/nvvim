return {
  "yetone/avante.nvim",
  keys = function(_, keys)
    ---@type avante.Config
    local opts =
      require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

    local mappings = {
      {
        opts.mappings.ask,
        function()
          require("avante.api").ask()
        end,
        desc = "avante: ask",
        mode = { "n", "v" },
      },
      {
        opts.mappings.refresh,
        function()
          require("avante.api").refresh()
        end,
        desc = "avante: refresh",
        mode = "v",
      },
      {
        opts.mappings.edit,
        function()
          require("avante.api").edit()
        end,
        desc = "avante: edit",
        mode = { "n", "v" },
      },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  cmd = "AvanteAsk",
  lazy = false,
  version = false,
  build = "make BUILD_FROM_SOURCE=true",
  opts = {
    mappings = {
      ask = "<leader>aa", -- ask
      edit = "<leader>ae", -- edit
      refresh = "<leader>ar", -- refresh
    },
    provider = "copilot",
    behaviour = {
      auto_suggestions = false, -- Experimental stage
    },
    vendors = {
      ollama = {
        ["local"] = true,
        endpoint = "http://chat.groveer.com:11434/v1",
        model = "codellama",
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint .. "/chat/completions",
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
            },
            body = {
              model = opts.model,
              messages = require("avante.providers").openai.parse_message(code_opts),
              max_tokens = 2048,
              stream = true,
            },
          }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      keys = {
        {
          "<leader>ip",
          function()
            return vim.bo.filetype == "AvanteInput" and require("avante.clipboard").paste_image()
              or require("img-clip").paste_image()
          end,
          desc = "clip: paste image",
        },
      },
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("avante_lib").load()
    require("avante").setup(opts)

    -- which key config
    local has_which_key, which_key = pcall(require, "which-key")
    if has_which_key then
      -- prefil edit window with common scenarios to avoid repeating query and submit immediately
      local prefill_edit_window = function(request)
        require("avante.api").edit()
        local code_bufnr = vim.api.nvim_get_current_buf()
        local code_winid = vim.api.nvim_get_current_win()
        if code_bufnr == nil or code_winid == nil then
          return
        end
        vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
        -- Optionally set the cursor position to the end of the input
        vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
        -- Simulate Ctrl+S keypress to submit
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
      end

      -- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
      local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
      local avante_keywords = "Extract the main keywords from the following text"
      local avante_code_readability_analysis = [[
      You must identify any readability issues in the code snippet.
      Some readability issues to consider:
      - Unclear naming
      - Unclear purpose
      - Redundant or obvious comments
      - Lack of comments
      - Long or complex one liners
      - Too much nesting
      - Long variable names
      - Inconsistent naming and code style.
      - Code repetition
      You may identify additional problems. The user submits a small section of code from a larger file.
      Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
      If there's no issues with code respond with only: <OK>
    ]]
      local avante_optimize_code = "Optimize the following code"
      local avante_summarize = "Summarize the following text"
      local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
      local avante_explain_code = "Explain the following code"
      local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
      local avante_add_docstring = "Add docstring to the following codes"
      local avante_fix_bugs = "Fix the bugs inside the following codes if any"
      local avante_add_tests = "Implement tests for the following code"

      which_key.add({
        { "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
        {
          mode = { "n", "v" },
          {
            "<leader>ag",
            function()
              require("avante.api").ask({ question = avante_grammar_correction })
            end,
            desc = "Grammar Correction(ask)",
          },
          {
            "<leader>ak",
            function()
              require("avante.api").ask({ question = avante_keywords })
            end,
            desc = "Keywords(ask)",
          },
          {
            "<leader>al",
            function()
              require("avante.api").ask({ question = avante_code_readability_analysis })
            end,
            desc = "Code Readability Analysis(ask)",
          },
          {
            "<leader>ao",
            function()
              require("avante.api").ask({ question = avante_optimize_code })
            end,
            desc = "Optimize Code(ask)",
          },
          {
            "<leader>am",
            function()
              require("avante.api").ask({ question = avante_summarize })
            end,
            desc = "Summarize text(ask)",
          },
          {
            "<leader>an",
            function()
              require("avante.api").ask({ question = avante_translate })
            end,
            desc = "Translate text(ask)",
          },
          {
            "<leader>ax",
            function()
              require("avante.api").ask({ question = avante_explain_code })
            end,
            desc = "Explain Code(ask)",
          },
          {
            "<leader>ac",
            function()
              require("avante.api").ask({ question = avante_complete_code })
            end,
            desc = "Complete Code(ask)",
          },
          {
            "<leader>ad",
            function()
              require("avante.api").ask({ question = avante_add_docstring })
            end,
            desc = "Docstring(ask)",
          },
          {
            "<leader>ab",
            function()
              require("avante.api").ask({ question = avante_fix_bugs })
            end,
            desc = "Fix Bugs(ask)",
          },
          {
            "<leader>au",
            function()
              require("avante.api").ask({ question = avante_add_tests })
            end,
            desc = "Add Tests(ask)",
          },
        },
      })

      which_key.add({
        { "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
        {
          mode = { "v" },
          {
            "<leader>aG",
            function()
              prefill_edit_window(avante_grammar_correction)
            end,
            desc = "Grammar Correction",
          },
          {
            "<leader>aK",
            function()
              prefill_edit_window(avante_keywords)
            end,
            desc = "Keywords",
          },
          {
            "<leader>aO",
            function()
              prefill_edit_window(avante_optimize_code)
            end,
            desc = "Optimize Code(edit)",
          },
          {
            "<leader>aC",
            function()
              prefill_edit_window(avante_complete_code)
            end,
            desc = "Complete Code(edit)",
          },
          {
            "<leader>aD",
            function()
              prefill_edit_window(avante_add_docstring)
            end,
            desc = "Docstring(edit)",
          },
          {
            "<leader>aB",
            function()
              prefill_edit_window(avante_fix_bugs)
            end,
            desc = "Fix Bugs(edit)",
          },
          {
            "<leader>aU",
            function()
              prefill_edit_window(avante_add_tests)
            end,
            desc = "Add Tests(edit)",
          },
        },
      })
    end
  end,
}
