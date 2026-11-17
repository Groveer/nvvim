return {
  "HakonHarnes/img-clip.nvim",
  keys = {
    {
      "<leader>p",
      function()
        require("img-clip").paste_image()
      end,
      mode = { "n" },
      desc = "Paste image from system clipboard",
    },
  },
  opts = {
    default = {
      dir_path = vim.uv.os_tmpdir() .. "/img-clip",
    },
    filetypes = {
      codecompanion = {
        prompt_for_file_name = false,
        template = "[Image]($FILE_PATH)",
        use_absolute_path = true,
      },
    },
  },
}
