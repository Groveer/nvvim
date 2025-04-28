local build_cmd = not require("nvvim.configs").is_windows and "make"
  or "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"

local avante_fix_build = "运行命令编译项目，若存在编译错误或警告，给出修复代码，修复后不要重复运行命令。"
local avante_git_commit = "检查项目本次修改的内容，参考历史的提交格式，暂存项目并编写提交信息，提交信息尽量简单清晰。"

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
  opts = {
    file_selector = {
      provider = "fzf",
    },
    behaviour = {
      enable_cursor_planning_mode = true,
      enabled_claude_text_editor_tool_mode = true,
    },
    provider = "copilot",
    -- provider = "openai",
    cursor_applying_provider = "groq",
    copilot = {
      -- model = "claude-3.5-sonnet",
      model = "claude-3.7-sonnet",
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
