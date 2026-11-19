# Modern Neovim Configuration

A high-performance Neovim configuration written in Lua, designed for speed, aesthetics, and
developer productivity. Built on top of NvChad with extensive customization and modern plugins.

## 🚀 Features

### Performance & Startup
- **Fast Startup**: 0.02s - 0.07s startup time
- **Lazy Loading**: Most plugins are loaded on demand via `lazy.nvim` events, commands, `ft` and `keys`
- **Trimmed Runtime**: Disabled unnecessary built-in plugins

### AI Integration
- **Code Companion**: Zed-like AI workflow with [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)
- **Copilot Adapter**: Copilot backing the chat/CLI adapters, installed through Mason

### Language Support
- **Native LSP**: Shared `on_attach`, keymaps and capabilities in `lua/configs/lsp.lua`
- **Semantic Tokens**: Uses LSP semantic tokens for advanced syntax highlighting
- **Rust Enhancement**: Supercharged Rust development with [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)
- **Crates Management**: Dependency management for Cargo projects
- **Python Provider**: Dedicated venv in `stdpath("data")/.venv` with `pynvim` and the `markitdown` CLI installed on demand

### UI & Experience
- **Beautiful Themes**: Multiple themes with theme toggler via [base46](https://github.com/NvChad/base46)
- **Modern UI**: Statusline, tabufline and cheatsheet via [NvChad UI](https://github.com/NvChad/ui)
- **File Navigation**: File explorer with [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- **Smart Navigation**: Jump anywhere with [flash.nvim](https://github.com/folke/flash.nvim)

### Editor Enhancements
- **Fuzzy Finder**: Fast file search and preview with [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- **Git Integration**: Buffer-level git signs with [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- **Todo Management**: Highlight and search todo comments
- **Formatting**: Lightweight formatting with [conform.nvim](https://github.com/stevearc/conform.nvim)

## 📦 Plugin Categories

### AI & Assistants
- [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) - AI-powered coding assistant
- Copilot adapter integration

### Language & LSP
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Native LSP configuration
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP/DAP/linter installer
- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) - Enhanced Rust development
- [crates.nvim](https://github.com/Saecki/crates.nvim) - Cargo dependency management
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax parsing
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Sticky context lines
- [nvim-lsp-endhints](https://github.com/chrisgrieser/nvim-lsp-endhints) - Inline type hints
- [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) - Inline diagnostics
- [nvim-navic](https://github.com/SmiteshP/nvim-navic) - Breadcrumb navigation

### Completion & Snippets
- [blink.cmp](https://github.com/saghen/blink.cmp) - Smart autocompletion
- [blink.pairs](https://github.com/saghen/blink.pairs) - Auto pairs
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Community snippets

### Navigation & Search
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) - Fast fuzzy finder
- [flash.nvim](https://github.com/folke/flash.nvim) - Enhanced navigation
- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) - File explorer
- [aerial.nvim](https://github.com/stevearc/aerial.nvim) - Code outline
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) - Project-wide search & replace

### Git & Version Control
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration
- [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) - Merge conflict resolution
- [vscode-diff.nvim](https://github.com/esmuellert/vscode-diff.nvim) - VSCode-style diff view

### UI & Visuals
- [NvChad UI](https://github.com/NvChad/ui) - Modern interface components
- [base46](https://github.com/NvChad/base46) - Theme system
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) - File icons
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides
- [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua) - Color previews
- [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) - Smooth scrolling
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) - Markdown rendering
- [image.nvim](https://github.com/3rd/image.nvim) - In-buffer image preview

### Quality of Life
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Todo management
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding help
- [checkmate.nvim](https://github.com/bngarren/checkmate.nvim) - Markdown todo lists
- [mini.trailspace](https://github.com/nvim-mini/mini.trailspace) - Trailing whitespace
- [stcursorword](https://github.com/sontungexpt/stcursorword) - Highlight word under cursor
- [smartyank.nvim](https://github.com/ibhagwan/smartyank.nvim) - Smart yanking
- [suda.vim](https://github.com/lambdalisue/suda.vim) - Sudo file operations
- [img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim) - Paste images from clipboard

## 🛠 Installation

### Requirements

- Neovim >= 0.11 (built with LuaJIT)
- `git`, `rg`, `fd` and a Nerd Font for icons
- Optional per-feature dependencies: `imagemagick` (image rendering), `cargo` (Rust)

### Setup

Back up any existing config first, then clone into place:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/Groveer/nvvim.git ~/.config/nvim
```

Launch `nvim` — `lazy.nvim` bootstraps itself, then installs every plugin pinned in
`lazy-lock.json`. Use `:Lazy` to inspect or update plugins, `:Mason` to manage language servers.

## 📁 Project Structure

```text
~/.config/nvim
├── init.lua              # Entry point: lazy.nvim bootstrap + setup, ui2, config loading
├── lua/
│   ├── configs/          # Core config modules
│   │   ├── global.lua    # Shared globals (vim.g.cfg_*): platform flags, paths
│   │   ├── options.lua   # vim.opt options
│   │   ├── keymap.lua    # Global keymaps
│   │   ├── autocmds.lua  # Autocommands
│   │   ├── python.lua    # Python venv (provider, PATH, package installs)
│   │   └── lsp.lua       # Shared LSP on_attach / keymaps / capabilities
│   ├── plugins/          # One file per plugin, auto-imported by lazy.nvim
│   └── chadrc.lua        # NvChad theme and UI config
├── after/                # Filetype-specific overrides
├── snippets/             # Custom snippets
├── spell/                # Spellfile word lists
├── skills/  prompts/     # CodeCompanion skills and prompt library
└── lazy-lock.json        # Plugin version lockfile
```

Plugin specs resolve as `plugins.<name>`, core config as `configs.global`, `configs.lsp`, and so on.
A new plugin only needs a file dropped into `lua/plugins/` — there is no registration step.

The Python venv is intentionally *not* in this tree. It lives in
`stdpath("data")/.venv` (e.g. `~/.local/share/nvim/.venv`): `configs.python`
creates it lazily and exports `VIRTUAL_ENV` plus `PATH`, while
`configs.python.ensure_package()` installs `pynvim` and — through the codecompanion
`build` hook — `markitdown[all]`.

## ⚙️ Configuration

### Entry Point

`init.lua` sets up the runtime in this order: bootstrap `lazy.nvim` → load `configs.global`,
`configs.options`, `configs.autocmds`, `configs.keymap`, `configs.lsp`, `configs.python` →
`require("lazy").setup({ ... })` (config inlined in `init.lua`) → enable `vim._core.ui2`.

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

### Platform Handling

`lua/configs/global.lua` detects `cfg_is_mac`, `cfg_is_linux`, `cfg_is_windows` and `cfg_is_wsl`
once at startup and stores them as `vim.g.cfg_*`. Plugins read `vim.g`
directly instead of requiring `configs` — for example `image.nvim` is disabled on Windows:

```lua
enabled = not vim.g.cfg_is_windows,
```

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details.
