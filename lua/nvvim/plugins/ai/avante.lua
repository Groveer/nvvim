local build_cmd = not require("nvvim.configs").is_windows and "make"
  or "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"

local avante_fix_build =
  "运行命令编译项目，若存在编译错误或警告，给出修复代码，修复后不要重复运行命令。"
local avante_git_commit =
  "检查项目本次修改的内容，参考历史的提交格式，暂存项目并编写提交信息，提交信息尽量简单清晰。"

return {
  "yetone/avante.nvim",
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "avante: ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "avante: refresh",
      mode = "v",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "avante: edit",
      mode = { "n", "v" },
    },
    {
      "<leader>ab",
      function()
        require("avante.api").ask({ question = avante_fix_build })
      end,
      mode = { "n", "v" },
      desc = "Fix Build Errors(ask)",
    },
    {
      "<leader>ag",
      function()
        require("avante.api").ask({ question = avante_git_commit })
      end,
      mode = { "n", "v" },
      desc = "Create git commit message(ask)",
    },
  },
  cmd = "AvanteAsk",
  version = false,
  build = build_cmd,
  -- commit = "f9aa75459d403d9e963ef2647c9791e0dfc9e5f9",
  opts = {
    behaviour = {
      enable_cursor_planning_mode = true,
      jump_result_buffer_on_finish = true,
    },
    provider = "copilot",
    cursor_applying_provider = "groq",
    copilot = {
      -- model = "claude-3.5-sonnet",
      -- model = "claude-3.7-sonnet",
      model = "claude-sonnet-4",
      -- model = "gemini-2.5-pro",
      -- model = "DeepSeek-R1",
    },
    vendors = {
      groq = { -- define groq provider
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
        max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
      },
      openrouter = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1",
        api_key_name = "OPENROUTER_API_KEY",
        model = "google/gemini-2.0-flash-001",
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
  },
  config = function(_, opts)
    vim.cmd("AvanteBuild")
    require("avante_lib").load()
    require("avante").setup(opts)
  end,
}
