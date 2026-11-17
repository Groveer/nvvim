return {
  "saghen/blink.pairs",
  event = { "BufReadPost", "BufNewFile" },
  version = "*", -- (recommended) only required with prebuilt binaries
  dependencies = "saghen/blink.lib",
  build = function()
    require("blink.pairs").download():pwait(60000)
  end,
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    mappings = {
      -- you can call require("blink.pairs.mappings").enable()
      -- and require("blink.pairs.mappings").disable()
      -- to enable/disable mappings at runtime
      enabled = true,
      disabled_filetypes = {
        "TelescopePrompt",
        "vim",
        "markdown",
        "help",
        "text",
        "plaintext",
        "git",
      },
    },
    highlights = {
      enabled = true,
    },
    debug = false,
  },
}
