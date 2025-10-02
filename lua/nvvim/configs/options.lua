local opt = vim.opt
local g = vim.g
local filetype = vim.filetype

-------------------------------------- options ------------------------------------------
-- Set status line to always be visible and only the last window
opt.laststatus = 3
-- Don't show the mode, since it's already in the status line plugin
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)
-- Show which line your cursor is on
opt.cursorline = true
-- Hightlight cursorline and number
opt.cursorlineopt = "both"

-- Use spaces instead of tabs
opt.expandtab = true
-- Enable smart indentation
opt.smartindent = true
-- Number of spaces that a <Tab> counts for
opt.tabstop = 2

-- Use space instead of `end of buffer ~`
opt.fillchars = { eob = " " }

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Enable mouse support in all modes
opt.mouse = "a"

-- Enable line numbers
opt.number = true
-- Set number column width to 2
opt.numberwidth = 2
-- Don't show position of the cursor, since it's already in the status line plugin
opt.ruler = false

-- Disable nvim intro
opt.shortmess:append("sI")

-- Keep signcolumn on by default
opt.signcolumn = "yes"
-- New horizontally split windows will be below the current window
opt.splitbelow = true
-- New vertically split windows will be to the right of the current window
opt.splitright = true

-- Decrease mapped sequence wait time
opt.timeoutlen = 400

-- Save undo history
opt.undofile = true

-- Interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- Go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- Disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- set leader key
g.mapleader = " "

-- Enable 24-bit RGB color in the TUI
opt.termguicolors = true

-- Enable spell check
opt.spell = true
opt.spelllang = { "en", "cjk" }
opt.spelloptions = "camel"

-- Define custom filetypes
filetype.add({ extension = { json = "jsonc" } })
-- filetype for plantuml
filetype.add({
  extension = {
    puml = "plantuml",
    plantuml = "plantuml",
    uml = "plantuml",
  },
})
-- filetype for qml
filetype.add({ extension = { qml = "qmljs" } })
-- filetype for image
filetype.add({
  extension = {
    png = "image",
    jpg = "image",
    jpeg = "image",
    gif = "image",
    webp = "image",
    avif = "image",
  },
})

filetype.add({
  extension = {
    todo = "markdown",
  },
})
