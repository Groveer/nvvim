return {
  "bngarren/checkmate.nvim",
  ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
  cmd = "Checkmate",
  opts = {
    keys = {
      ["<leader>tt"] = {
        rhs = "<cmd>Checkmate toggle<CR>",
        desc = "Toggle todo item",
        modes = { "n", "v" },
      },
      ["<leader>tc"] = {
        rhs = "<cmd>Checkmate check<CR>",
        desc = "Set todo item as checked (done)",
        modes = { "n", "v" },
      },
      ["<leader>tu"] = {
        rhs = "<cmd>Checkmate uncheck<CR>",
        desc = "Set todo item as unchecked (not done)",
        modes = { "n", "v" },
      },
      ["<leader>t="] = {
        rhs = "<cmd>Checkmate cycle_next<CR>",
        desc = "Cycle todo item(s) to the next state",
        modes = { "n", "v" },
      },
      ["<leader>t-"] = {
        rhs = "<cmd>Checkmate cycle_previous<CR>",
        desc = "Cycle todo item(s) to the previous state",
        modes = { "n", "v" },
      },
      ["<leader>tn"] = {
        rhs = "<cmd>Checkmate create<CR>",
        desc = "Create todo item",
        modes = { "n", "v" },
      },
      ["<leader>tr"] = {
        rhs = "<cmd>Checkmate remove<CR>",
        desc = "Remove todo marker (convert to text)",
        modes = { "n", "v" },
      },
      ["<leader>tR"] = {
        rhs = "<cmd>Checkmate remove_all_metadata<CR>",
        desc = "Remove all metadata from a todo item",
        modes = { "n", "v" },
      },
      ["<leader>ta"] = {
        rhs = "<cmd>Checkmate archive<CR>",
        desc = "Archive checked/completed todo items (move to bottom section)",
        modes = { "n" },
      },
      ["<leader>tv"] = {
        rhs = "<cmd>Checkmate metadata select_value<CR>",
        desc = "Update the value of a metadata tag under the cursor",
        modes = { "n" },
      },
      ["<leader>t]"] = {
        rhs = "<cmd>Checkmate metadata jump_next<CR>",
        desc = "Move cursor to next metadata tag",
        modes = { "n" },
      },
      ["<leader>t["] = {
        rhs = "<cmd>Checkmate metadata jump_previous<CR>",
        desc = "Move cursor to previous metadata tag",
        modes = { "n" },
      },
    }, -- disable default keymaps
    todo_states = {
      -- we don't need to set the `markdown` field for `unchecked` and `checked` as these can't be overriden
      ---@diagnostic disable-next-line: missing-fields
      unchecked = {
        marker = "[ ]",
        order = 1,
      },
      ---@diagnostic disable-next-line: missing-fields
      checked = {
        marker = "[x]",
        order = 2,
      },
    },
    metadata = {
      pms = {
        style = { fg = "#4343f9" },
        get_value = function()
          return "pms"
        end,
        key = "<leader>tP",
        sort_order = 5,
      },
      -- Example: A @priority tag that has dynamic color based on the priority value
      priority = {
        style = function(context)
          local value = context.value:lower()
          if value == "high" then
            return { fg = "#ff5555", bold = true }
          elseif value == "medium" then
            return { fg = "#ffb86c" }
          elseif value == "low" then
            return { fg = "#8be9fd" }
          else -- fallback
            return { fg = "#8be9fd" }
          end
        end,
        get_value = function()
          return "medium" -- Default priority
        end,
        choices = function()
          return { "low", "medium", "high" }
        end,
        key = "<leader>tp",
        sort_order = 10,
        jump_to_on_insert = "value",
        select_on_insert = true,
      },
      -- Example: A @started tag that uses a default date/time string when added
      started = {
        aliases = { "init" },
        style = { fg = "#9fd6d5" },
        get_value = function()
          return tostring(os.date("%m/%d/%y %H:%M"))
        end,
        key = "<leader>ts",
        sort_order = 20,
      },
      -- Example: A @done tag that also sets the todo item state when it is added and removed
      done = {
        aliases = { "completed", "finished" },
        style = { fg = "#96de7a" },
        get_value = function()
          return tostring(os.date("%m/%d/%y %H:%M"))
        end,
        key = "<leader>td",
        on_add = function(todo_item)
          require("checkmate").set_todo_item(todo_item, "checked")
        end,
        on_remove = function(todo_item)
          require("checkmate").set_todo_item(todo_item, "unchecked")
        end,
        sort_order = 30,
      },
    },
  },
}
