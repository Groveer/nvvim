return {
  "mistricky/codesnap.nvim",
  build = "make build_generator",
  enabled = not require("nvvim.configs").is_windows,
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
