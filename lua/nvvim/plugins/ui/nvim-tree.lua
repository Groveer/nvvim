return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    {
      "<C-n>",
      "<CMD>NvimTreeToggle<CR>",
      mode = "n",
      desc = "NvimTree Toggle",
    },
    {
      "<leader>e",
      "<CMD>NvimTreeFocus<CR>",
      mode = "n",
      desc = "NvimTree Focus",
    },
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = {
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
      git_clean = false,
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.del("n", "g?", { buffer = bufnr })
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end,
    renderer = {
      root_folder_label = false,
      highlight_git = "all",
      highlight_diagnostics = "all",
      highlight_opened_files = "all",
      highlight_modified = "all",
      highlight_hidden = "all",
      highlight_bookmarks = "all",
      highlight_clipboard = "all",
      indent_markers = { enable = true },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "󰋖",
            deleted = "󰆴",
            ignored = "◌",
          },
        },
      },
    },
  },
  config = function(_, opts)
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup(opts)
    -- Auto Close
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= "" then
            table.insert(floating_wins, w)
          end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
          -- Should quit, so we close all invalid windows.
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
