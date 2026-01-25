## What is it?

 - This is a neovim config written in lua aiming to provide a configuration with very beautiful UI and blazing fast startuptime (around 0.02 secs ~ 0.07 secs). We tweak UI plugins such as snacks.nvim etc well to provide an aesthetic UI experience. **Requires Neovim >= 0.12.**

- Lazy loading is done 93% of the time meaning that plugins will not be loaded by default, they will be loaded only when required also at specific commands, events etc. This lowers the startuptime.

- Can use this repository directly, or import it with the starter of [LazyVim](https://github.com/LazyVim/starter) or [NvChad](https://github.com/NvChad/starter), and then override some plugin configurations by yourself.


## Features

- Native LSP configuration with isolated settings for multiple languages.
- Supports Neovim 0.12's native inline completion, and provides a Copilot login command.
- Uses LSP semantic_tokens for syntax highlighting instead of nvim-treesitter.
- Any plugin can be used independently without dependency issues.

## Plugins list

### AI

- Interactive CLI tool for Neovim [opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)

### Coding

- Managing crates.io dependencies [crates.nvim](https://github.com/Saecki/crates.nvim)
- Autocompletion with [blink.cmp](https://github.com/saghen/blink.cmp)
- Useful snippets with [friendly snippets](https://github.com/rafamadriz/friendly-snippets) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip).

### Editor

- Smart and powerful comment plugin [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- Git integration for buffers [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
 - A smartly yank [smartyank.nvim](https://github.com/ibhagwan/smartyank.nvim)
- A plugin to read or write files with sudo command [suda.vim](https://github.com/lambdalisue/suda.vim)
- Highlight, list and search todo comments with [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- Manage trailspace with [mini.trailspace](https://github.com/echasnovski/mini.trailspace)
- Popup mappings keysheet [whichkey.nvim](https://github.com/folke/which-key.nvim)

### Format

- Lightweight yet powerful formatter [conform.nvim](https://github.com/stevearc/conform.nvim)

### Lsp

- A code outline window [aerial.nvim](https://github.com/stevearc/aerial.nvim)
- Supercharge your Rust experience with [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)

### Render

- The fastest Neovim colorizer with [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
- Improve viewing Markdown files with [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- Display prettier diagnostic messages with [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim)

### UI

- Many beautiful themes, theme toggler by our [base46 plugin](https://github.com/NvChad/base46)
- Lightweight & performant ui plugin with [NvChad UI](https://github.com/NvChad/ui) It provides statusline modules, tabufline ( tabs + buffer manager) , beautiful cheatsheets, NvChad updater, hide & unhide terminal buffers, theme switcher and much more!
- Beautiful and configurable icons with [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- Ultimate Neovim plugin with pickers, explorer, toggles, terminal, and more with [snacks.nvim](https://github.com/folke/snacks.nvim)

## Usage

### 1. Use this repository directly

Requires Neovim >= 0.12.

```bash
git clone https://github.com/Groveer/nvvim.git ~/.config/nvim
```

### 2. Use with LazyVim, NvChad or other starters

You can import specific plugins from this repository. **Note: Do not import `nvvim.plugins` directly as it contains global configurations that may conflict with your starter.**

Example of importing a specific plugin (e.g., `opencode`):

```lua
-- In your lazy.nvim spec
{
  { "Groveer/nvvim", import = "nvvim.plugins.opencode" },
  -- your other plugins...
}
```

Or using [zpack.nvim](https://github.com/zuqini/zpack.nvim):

```lua
require('zpack').setup({
  { import = 'nvvim.plugins.opencode' },
  -- your other plugins...
})
```
