local autocmd = vim.api.nvim_create_autocmd

-- restore cursor position
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if
      line > 1
      and line <= vim.fn.line("$")
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd('normal! g`"')
    end
  end,
})

autocmd("VimEnter", {
  callback = function()
    local spell_dir = vim.fn.stdpath("config") .. "/spell"
    local langs = vim.fn.glob(spell_dir .. "/*.add", false, true)
    for _, fname in ipairs(langs) do
      if vim.fn.filereadable(fname) == 1 then
        vim.cmd("silent! mkspell! " .. fname)
      end
    end
  end
})

