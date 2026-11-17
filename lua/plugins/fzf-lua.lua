return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  event = { "BufReadPost", "BufNewFile" },
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
      "<leader>fs",
      function()
        require("fzf-lua").grep_visual()
      end,
      mode = "v",
      desc = "Fzf Find visual selection",
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
      "<leader>fc",
      function()
        require("fzf-lua").changes()
      end,
      mode = "n",
      desc = "Fzf Find changes",
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
    winopts = {
      height = 0.95,
      width = 0.95,
    },

    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/history/fzf-lua-history",
    },
    grep = {
      hidden = true,
    },

    files = {
      find_opts = [[-type f \! -path '*/.git/*' \! -path '*/.idea/*' \! -path '*/node_modules/*' \! -path '*/build/*' \! -path '*/dist/*' \! -path '*/__pycache__/*']],
      rg_opts = [[--color=never --hidden --files -g "!.git" -g "!.idea" -g "!node_modules" -g "!build" -g "!dist" -g "!__pycache__"]],
      fd_opts = [[--color=never --hidden --type f --type l --exclude .git --exclude .idea --exclude node_modules --exclude build --exclude dist --exclude __pycache__]],
    },
    keymap = {
      builtin = {
        ["<C-f>"] = "preview-page-down",
        ["<C-b>"] = "preview-page-up",
      },
    },
  },
  config = function(_, opts)
    local history_dir = vim.fn.stdpath("data") .. "/history"
    if vim.fn.isdirectory(history_dir) == 0 then
      vim.fn.mkdir(history_dir, "p")
    end
    require("fzf-lua").setup(opts)
    vim.cmd("FzfLua register_ui_select")
  end,
}
