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
    "fzf-native",
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
  end,
}
