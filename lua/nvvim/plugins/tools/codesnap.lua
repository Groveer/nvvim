return {
  "mistricky/codesnap.nvim",
  build = "make",
  cmd = {
    "CodeSnap",
    "CodeSnapASCII",
    "CodeSnapSave",
    "CodeSnapHightlight",
    "CodeSnapSaveHightlight",
  },
  opts = {
    save_path = "~/Pictures/Screenshots/",
    has_breadcrumbs = true,
    has_line_number = true,
    bg_theme = "bamboo",
    bg_padding = 0,
    code_font_family = "Maple Mono NF CN",
  },
}
