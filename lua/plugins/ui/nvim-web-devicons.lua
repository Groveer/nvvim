return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      local has_base46, _ = pcall(require, "base46")
      if has_base46 then
        dofile(vim.g.base46_cache .. "devicons")
      end

      return { override = require("nvchad.icons.devicons") }
    end,
  },
}
