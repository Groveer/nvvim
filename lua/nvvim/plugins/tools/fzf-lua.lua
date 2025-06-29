return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    {
      "<leader>fo",
      function()
        require("fzf-lua").oldfiles()
      end,
      mode = "n",
      desc = "Fzf Find old file",
    },
    {
      "<leader>fs",
      function()
        require("fzf-lua").grep_cword()
      end,
      mode = "n",
      desc = "Fzf Find current word",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").resume()
      end,
      mode = "n",
      desc = "Fzf Resume",
    },
    {
      "<leader>fw",
      function()
        require("fzf-lua").live_grep()
      end,
      mode = "n",
      desc = "Fzf Live grep",
    },
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      mode = "n",
      desc = "Fzf Find files",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").helptags()
      end,
      mode = "n",
      desc = "Fzf Help page",
    },
    {
      "<leader>fm",
      function()
        require("fzf-lua").marks()
      end,
      mode = "n",
      desc = "Fzf Find marks",
    },
    {
      "<leader>gc",
      function()
        require("fzf-lua").git_commits()
      end,
      "n",
      desc = "Fzf Git commits",
    },
    {
      "<leader>gt",
      function()
        require("fzf-lua").git_status()
      end,
      mode = "n",
      desc = "Fzf Git status",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- 全局设置适用于所有 fzf-lua 命令
    global = {
      file_ignore_patterns = {
        "node_modules/.*", -- 忽略 node_modules 目录
        "%.git/.*", -- 忽略 .git 目录
        "build/.*", -- 忽略 build 目录
        "dist/.*", -- 忽略 dist 目录
        "%.idea/.*", -- 忽略 .idea 目录
        "%.vscode/.*", -- 忽略 .vscode 目录
      },
      rg_glob = true, -- 启用 ripgrep 的 glob 模式
    },

    grep = {
      -- 专门针对 live_grep 的设置
      live_grep = {
        rg_opts = "--hidden --follow --smart-case", -- ripgrep 基础选项
        rg_extra_args = function()
          -- 动态构建排除目录参数
          local excludes = {
            "--glob=!**/node_modules/**",
            "--glob=!**/.git/**",
            "--glob=!**/build/**",
            "--glob=!**/dist/**",
            "--glob=!**/.idea/**",
            "--glob=!**/vendor/**",
            "--glob=!**/__pycache__/**",
          }
          return excludes
        end,
      },

      -- 普通 grep 设置
      grep = {
        rg_extra_args = {
          "--glob=!**/node_modules/**",
          "--glob=!**/.git/**",
        },
      },
    },

    files = {
      -- 文件搜索的忽略设置
      file_ignore_patterns = {
        "^node_modules/",
        "^%.git/",
        "^build/",
        "^dist/",
        "%.o$",
        "%.a$",
        "%.so$",
        "%.dll$",
        "%.exe$",
      },
    },
    keymap = {
      builtin = {
        ["<C-f>"] = "preview-page-down",
        ["<C-b>"] = "preview-page-up",
        ["<S-down>"] = "half-page-down",
        ["<S-up>"] = "half-page-up",
      },
      fzf = {
        ["ctrl-f"] = "preview-page-down",
        ["ctrl-b"] = "preview-page-up",
        ["shift-down"] = "half-page-down",
        ["shift-up"] = "half-page-up",
      },
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
  end,
}
