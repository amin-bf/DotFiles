local opt = vim.opt
local g = vim.g

opt.clipboard = "unnamedplus"
opt.cursorline = true
-- opt.cursorcolumn = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = {
  eob = " "
}
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  command = [[setlocal nofoldenable]]
})
vim.opt.foldmethod = "indent"

opt.relativenumber = true
opt.cursorlineopt = "line,number"
opt.spell = true
opt.spellsuggest = "best"
opt.spelloptions = "camel"
