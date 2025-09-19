return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    preview_config = {
      border = "rounded",
    },
    current_line_blame = true,
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end
      map("n", "]g", gs.next_hunk, "Gitsigns Next Hunk")
      map("n", "[g", gs.prev_hunk, "Gitsigns Prev Hunk")
      map("n", "<leader>gs", gs.stage_hunk, "Gitsigns Stage Hunk")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Gitsigns Undo Stage Hunk")
      map("n", "<leader>gr", gs.reset_hunk, "Gitsigns Reset Hunk")
      map("n", "<leader>gR", gs.reset_buffer, "Gitsigns Reset Buffer")
      map("n", "<leader>gp", gs.preview_hunk, "Gitsigns Preview Hunk")
      map("n", "<leader>gB", gs.blame, "Gitsigns Blame")
      map("n", "<leader>gb", gs.blame_line, "Gitsigns Blame Line")
      map("n", "<leader>td", gs.toggle_deleted, "Gitsigns Toggle deleted")
      map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Gitsigns Reset Hunk")
      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Gitsigns Stage Hunk")
    end,
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
}
