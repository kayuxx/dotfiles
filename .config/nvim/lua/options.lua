require("nvchad.options")

local o = vim.o
local opt = vim.opt

o.cursorlineopt = "both"
o.statuscolumn = "%!v:lua.require'configs.statuscolumn'.statuscolumn()"
opt.shell = "fish"
opt.cmdheight = 1
opt.autoindent = true
opt.title = true
o.scrolloff = 10
