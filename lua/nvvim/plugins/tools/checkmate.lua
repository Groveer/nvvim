return {
  "bngarren/checkmate.nvim",
  ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
  cmd = "Checkmate",
  keys = {
    {
      "<leader>tt",
      "<cmd>Checkmate toggle<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Toggle todo item",
    },
    {
      "<leader>tc",
      "<cmd>Checkmate check<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Set todo item as checked (done)",
    },
    {
      "<leader>tu",
      "<cmd>Checkmate uncheck<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Set todo item as unchecked (not done)",
    },
    {
      "<leader>t=",
      "<cmd>Checkmate cycle_next<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Cycle todo item(s) to the next state",
    },
    {
      "<leader>t-",
      "<cmd>Checkmate cycle_previous<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Cycle todo item(s) to the previous state",
    },
    {
      "<leader>tn",
      "<cmd>Checkmate create<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Create todo item",
    },
    {
      "<leader>tr",
      "<cmd>Checkmate remove<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Remove todo marker (convert to text)",
    },
    {
      "<leader>tR",
      "<cmd>Checkmate remove_all_metadata<CR>",
      mode = { "n", "v" },
      desc = "Checkmate Remove all metadata from a todo item",
    },
    {
      "<leader>ta",
      "<cmd>Checkmate archive<CR>",
      mode = "n",
      desc = "Checkmate Archive checked/completed todo items (move to bottom section)",
    },
    {
      "<leader>tv",
      "<cmd>Checkmate metadata select_value<CR>",
      mode = "n",
      desc = "Checkmate Update the value of a metadata tag under the cursor",
    },
    {
      "<leader>t]",
      "<cmd>Checkmate metadata jump_next<CR>",
      mode = "n",
      desc = "Checkmate Move cursor to next metadata tag",
    },
    {
      "<leader>t[",
      "<cmd>Checkmate metadata jump_previous<CR>",
      mode = "n",
      desc = "Checkmate Move cursor to previous metadata tag",
    },
  },
  opts = {
    -- your configuration here
    -- or leave empty to use defaults
  },
}
