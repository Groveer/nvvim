## What is it?

- This is a neovim config written in lua aiming to provide a configuration with very beautiful UI and blazing fast startuptime (around 0.02 secs ~ 0.07 secs). We tweak UI plugins such as fzf-lua, nvim-tree etc well to provide an aesthetic UI experience.

- Lazy loading is done 93% of the time meaning that plugins will not be loaded by default, they will be loaded only when required also at specific commands, events etc. This lowers the startuptime.

- Can use this repository directly, or import it with the starter of [LazyVim](https://github.com/LazyVim/starter) or [NvChad](https://github.com/NvChad/starter), and then override some plugin configurations by yourself.

## Plugins list

### AI

- Use Neovim like using Cursor AI IDE! [avante.nvim](https://github.com/yetone/avante.nvim)
- A native neovim extension for Codeium [codeium.nvim](https://github.com/Exafunction/codeium.nvim)
- Autocompletion with Copilot [copilot.lua](https://github.com/zbirenbaum/copilot.lua) + [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp)
- Autocompletion with other AI [minuet-ai.nvim](https://github.com/milanglacier/minuet-ai.nvim)

### Coding

- Managing crates.io dependencies [crates.nvim](https://github.com/Saecki/crates.nvim)
- Autocompletion with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Useful snippets with [friendly snippets](https://github.com/rafamadriz/friendly-snippets) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
- Autoclosing braces and html tags with [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- Render PlantUML diagrams with [plantuml.nvim](https://gitlab.com/itaranto/plantuml.nvim)

### Editor

- Smart and powerful comment plugin [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- Git integration for buffers [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- A customizable yank [smartyank.nvim](https://github.com/ibhagwan/smartyank.nvim)
- A search panel for neovim [spectre.nvim](https://github.com/nvim-pack/spectre.nvim)
- A plugin to read or write files with sudo command [suda.vim](https://github.com/lambdalisue/suda.vim)
- File searching, previewing text files and more with [fzf-lua](https://github.com/ibhagwan/fzf-lua).
- Highlight, list and search todo comments with [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- Manage trailspace with [mini.trailspace](https://github.com/echasnovski/mini.trailspace)
- Popup mappings keysheet [whichkey.nvim](https://github.com/folke/which-key.nvim)

### Format

- Lightweight yet powerful formatter [conform.nvim](https://github.com/stevearc/conform.nvim)

### Lsp

- Fully customizable previewer for LSP code actions [actions-preview.nvim](https://github.com/aznhe21/actions-preview.nvim)
- A code outline window [aerial.nvim](https://github.com/stevearc/aerial.nvim)
- NeoVim Lsp configuration with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and [mason.nvim](https://github.com/williamboman/mason.nvim)
- Supercharge your Rust experience with [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)

### Render

- The fastest Neovim colorizer with [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
- Indentlines with [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- Highlight uses of word under the cursor [local-highlight.nvim](https://github.com/tzachar/local-highlight.nvim)
- Display LSP inlay hints at the end of the line [nvim-lsp-endhints](https://github.com/chrisgrieser/nvim-lsp-endhints)
- Improve viewing Markdown files with [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- Syntax highlighting with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Display prettier diagnostic messages with [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim)

### UI

- Many beautiful themes, theme toggler by our [base46 plugin](https://github.com/NvChad/base46)
- Lightweight & performant ui plugin with [NvChad UI](https://github.com/NvChad/ui) It provides statusline modules, tabufline ( tabs + buffer manager) , beautiful cheatsheets, NvChad updater, hide & unhide terminal buffers, theme switcher and much more!
- File navigation with [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- Beautiful and configurable icons with [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

## Usage

There are two ways to use this config:

1. Use this repository directly:

```bash
git clone https://github.com/Groveer/nvvim.git ~/.config/nvim
```

2. use [LazyVim](https://github.com/LazyVim/starter) or your custom starter to import it:

```lua
spec = {
  -- add nvvim and import its plugins
  { "Groveer/nvvim", import = "nvvim.plugins" },
  -- import/override with your plugins
  { import = "plugins" },
},
```

And you can import some one plugins like:

```lua
spec = {
  -- add nvvim and import its plugins
  { "Groveer/nvvim", import = "nvvim.plugins.ai.copilot" },
  -- import/override with your plugins
  { import = "plugins" },
}
```
