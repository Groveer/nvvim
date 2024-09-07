return {
  "nvim-pack/nvim-spectre",
  keys = {
    {
      "<leader>s",
      function()
        require("spectre").toggle()
      end,
      mode = "n",
      desc = "Toggle Spectre",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      mode = "n",
      desc = "Search current word",
    },
    {
      "<leader>sw",
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      mode = "v",
      desc = "Search current word",
    },
    {
      "<leader>sp",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      mode = "n",
      desc = "Search on current file",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
