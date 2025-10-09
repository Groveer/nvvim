return {
  "saghen/blink.pairs",
  event = { "BufReadPost", "BufNewFile" },
  version = "*", -- (recommended) only required with prebuilt binaries
  -- download prebuilt binaries from github releases
  dependencies = "saghen/blink.download",
  -- OR build from source, requires nightly:
  -- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = "cargo build --release",
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    mappings = {
      -- you can call require("blink.pairs.mappings").enable()
      -- and require("blink.pairs.mappings").disable()
      -- to enable/disable mappings at runtime
      enabled = true,
    },
    highlights = {
      enabled = true,
    },
    debug = false,
  },
}
