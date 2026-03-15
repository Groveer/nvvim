# NVVim - Modern Neovim Configuration

A high-performance Neovim configuration written in Lua, designed for speed, aesthetics, and developer productivity. Built on top of NvChad with extensive customization and modern plugins.

## 🚀 Features

### Performance & Startup
- **Blazing Fast Startup**: 0.02s - 0.07s startup time
- **Lazy Loading**: 93% of plugins loaded on-demand
- **Optimized Performance**: Disabled unnecessary built-in plugins

### AI Integration
- **Code Companion**: Zed-like AI IDE experience with [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)
- **GitHub Copilot**: Native integration with inline completions

### Language Support
- **Native LSP**: Comprehensive language server configuration
- **Semantic Tokens**: Uses LSP semantic tokens for advanced syntax highlighting
- **Rust Enhancement**: Supercharged Rust development with [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)
- **Crates Management**: Dependency management for Rust projects

### UI & Experience
- **Beautiful Themes**: Multiple themes with theme toggler via [base46](https://github.com/NvChad/base46)
- **Modern UI**: Statusline, tabufline, and cheatsheets via [NvChad UI](https://github.com/NvChad/ui)
- **File Navigation**: Enhanced file explorer with [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- **Smart Navigation**: Advanced movement with [flash.nvim](https://github.com/folke/flash.nvim)

### Editor Enhancements
- **Fuzzy Finder**: Fast file searching and preview with [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- **Git Integration**: Buffer-level git integration with [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- **Todo Management**: Highlight and search todo comments
- **Formatting**: Lightweight formatting with [conform.nvim](https://github.com/stevearc/conform.nvim)

## 📦 Plugin Categories

### AI & Assistants
- [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) - AI-powered coding assistant
- GitHub Copilot integration

### Language & LSP
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Native LSP configuration
- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) - Enhanced Rust development
- [crates.nvim](https://github.com/Saecki/crates.nvim) - Rust dependency management
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax parsing

### Completion & Snippets
- [blink.cmp](https://github.com/saghen/blink.cmp) - Smart autocompletion
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Community snippets

### Navigation & Search
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) - Fast fuzzy finder
- [flash.nvim](https://github.com/folke/flash.nvim) - Enhanced navigation
- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) - File explorer
- [aerial.nvim](https://github.com/stevearc/aerial.nvim) - Code outline

### Git & Version Control
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration
- [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) - Merge conflict resolution

### UI & Visuals
- [NvChad UI](https://github.com/NvChad/ui) - Modern interface components
- [base46](https://github.com/NvChad/base46) - Theme system
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) - File icons
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides

### Quality of Life
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Todo management
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding help
- [smartyank.nvim](https://github.com/ibhagwan/smartyank.nvim) - Smart yanking
- [suda.vim](https://github.com/lambdalisue/suda.vim) - Sudo file operations

## 🛠 Installation

### Method 1: Direct Installation

```bash
git clone https://github.com/Groveer/nvvim.git ~/.config/nvim
```

### Method 2: Use with LazyVim Starter

```lua
-- In your LazyVim configuration
spec = {
  -- Import nvvim plugins
  { "Groveer/nvvim", import = "nvvim.plugins" },
  -- Your custom plugins
  { import = "plugins" },
}
```

### Method 3: Selective Plugin Import

```lua
-- Import only specific plugin categories
spec = {
  -- Import AI plugins
  { "Groveer/nvvim", import = "nvvim.plugins.codecompanion" },
  -- Import LSP plugins
  { "Groveer/nvvim", import = "nvvim.plugins.fzf-lua" },
  -- Your custom plugins
  { import = "plugins" },
}
```

## ⚙️ Configuration

### Customizing Themes

Edit `lua/chadrc.lua` to customize themes and UI:

```lua
M.base46 = {
  theme = "chadracula-evondev",
  transparency = true,
  integrations = {
    "notify",
    "todo",
    "navic",
    -- Add your integrations
  },
}
```

### Statusline Configuration

Customize the statusline in `lua/chadrc.lua`:

```lua
M.ui = {
  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "git", "navic", "%=", "diagnostics", "cursor", "lsp", "cwd" },
    -- Custom modules
  },
}
```

## 🎯 Key Features

- **Modular Architecture**: Each plugin can be used independently
- **Performance Focused**: Optimized for speed and responsiveness
- **Modern Tooling**: Integration with latest Neovim features
- **Developer Experience**: Thoughtful defaults with extensive customization

## 🤝 Contributing

This configuration is designed to be modular and extensible. Feel free to:
- Fork and customize for your workflow
- Submit issues for bugs or feature requests
- Contribute improvements via pull requests

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details.
