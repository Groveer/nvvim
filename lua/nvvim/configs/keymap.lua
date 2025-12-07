local keymap = {
    -- stylua: ignore start
    { "<C-a>",        "<ESC>^i",                  "i",           { desc = "move beginning of line" } },
    { "<C-e>",        "<End>",                    "i",           { desc = "move end of line" } },
    { "<C-h>",        "<Left>",                   "i",           { desc = "move left" } },
    { "<C-l>",        "<Right>",                  "i",           { desc = "move right" } },
    { "<C-j>",        "<Down>",                   "i",           { desc = "move down" } },
    { "<C-k>",        "<Up>",                     "i",           { desc = "move up" } },

    { "<C-h>",        "<C-w>h",                   "n",           { desc = "switch window left" } },
    { "<C-l>",        "<C-w>l",                   "n",           { desc = "switch window right" } },
    { "<C-j>",        "<C-w>j",                   "n",           { desc = "switch window down" } },
    { "<C-k>",        "<C-w>k",                   "n",           { desc = "switch window up" } },

    { "<Esc>",        "<CMD>noh<CR>",             "n",           { desc = "General Clear highlights" } },
    { "<C-s>",        "<CMD>w<CR>",               "n",           { desc = "General Save file" } },
    { "<C-c>",        "<CMD>%y+<CR>",             "n",           { desc = "General Copy whole file" } },

    { "<leader>n",    "<CMD>set nu!<CR>",         "n",           { desc = "Toggle line number" } },
    { "<leader>rn",   "<CMD>set rnu!<CR>",        "n",           { desc = "Toggle relative number" } },

    { ";",            ":",                        { "n", "v" },  { desc = "Nvim CMD enter command mode" } },

    { "J",            ":m '>+1<CR>gv=gv",         "v",           { desc = "Nvim Move line down" } },
    { "K",            ":m '<-2<CR>gv=gv",         "v",           { desc = "Nvim Move line up" } },

    { "<C-s>",        "<Esc><CMD>w!<CR>",         "i",           { desc = "File Save file" } },
    { "<A-S-q>",      "<CMD>q!<CR>",              "n",           { desc = "Nvim Force quit" } },
    { "<A-S-q>",      "<Esc><CMD>q!<CR>",         "i",           { desc = "Nvim Force quit" } },

    { "<leader>q",    vim.diagnostic.setloclist,  "n",           { desc = "lsp diagnostic loclist" } },

    { "]s",           "]s",                       "n",           { desc = "spell next", noremap = true, silent = true } },
    { "[s",           "[s",                       "n",           { desc = "spell prev", noremap = true, silent = true } },
  -- stylua: ignore end
}

for _, mapping in ipairs(keymap) do
  vim.keymap.set(mapping[3], mapping[1], mapping[2], mapping[4])
end
