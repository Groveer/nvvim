local keymap = {
    -- stylua: ignore start
    { "<C-a>",        "<ESC>^i",                  mode = "i",           { desc = "move beginning of line" } },
    { "<C-e>",        "<End>",                    mode = "i",           { desc = "move end of line" } },
    { "<C-h>",        "<Left>",                   mode = "i",           { desc = "move left" } },
    { "<C-l>",        "<Right>",                  mode = "i",           { desc = "move right" } },
    { "<C-j>",        "<Down>",                   mode = "i",           { desc = "move down" } },
    { "<C-k>",        "<Up>",                     mode = "i",           { desc = "move up" } },

    { "<C-h>",        "<C-w>h",                   mode = "n",           { desc = "switch window left" } },
    { "<C-l>",        "<C-w>l",                   mode = "n",           { desc = "switch window right" } },
    { "<C-j>",        "<C-w>j",                   mode = "n",           { desc = "switch window down" } },
    { "<C-k>",        "<C-w>k",                   mode = "n",           { desc = "switch window up" } },

    { "<Esc>",        "<CMD>noh<CR>",             mode = "n",           { desc = "General Clear highlights" } },
    { "<C-s>",        "<CMD>w<CR>",               mode = "n",           { desc = "General Save file" } },
    { "<C-c>",        "<CMD>%y+<CR>",             mode = "n",           { desc = "General Copy whole file" } },

    { "<leader>n",    "<CMD>set nu!<CR>",         mode = "n",           { desc = "Toggle line number" } },
    { "<leader>rn",   "<CMD>set rnu!<CR>",        mode = "n",           { desc = "Toggle relative number" } },

    { ";",            ":",                        mode = { "n", "v" },  { desc = "Nvim CMD enter command mode" } },

    { "J",            ":m '>+1<CR>gv=gv",         mode = "v",           { desc = "Nvim Move line down" } },
    { "K",            ":m '<-2<CR>gv=gv",         mode = "v",           { desc = "Nvim Move line up" } },

    { "<C-s>",        "<Esc><CMD>w!<CR>",         mode = "i",           { desc = "File Save file" } },
    { "<A-S-q>",      "<CMD>q!<CR>",              mode = "n",           { desc = "Nvim Force quit" } },
    { "<A-S-q>",      "<Esc><CMD>q!<CR>",         mode = "i",           { desc = "Nvim Force quit" } },

    { "<leader>q",    vim.diagnostic.setloclist,  mode = "n",           { desc = "lsp diagnostic loclist" } },

    { "]s",           "]s",                       mode = "n",           { desc = "spell next", noremap = true, silent = true } },
    { "[s",           "[s",                       mode = "n",           { desc = "spell prev", noremap = true, silent = true } },
  -- stylua: ignore end
}

for _, mapping in ipairs(keymap) do
  vim.keymap.set(mapping.mode, mapping[1], mapping[2], mapping[3])
end
