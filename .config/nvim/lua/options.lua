require("nvchad.options")

local o = vim.o
local opt = vim.opt
local undodirpath = vim.fn.stdpath("data") .. "/undo"

o.cursorlineopt = "both"
o.statuscolumn = "%!v:lua.require'configs.statuscolumn'.statuscolumn()"
opt.shell = "fish"
opt.cmdheight = 1
opt.autoindent = true
opt.title = true
o.scrolloff = 10

-- file handling
opt.swapfile = false -- don't create swap files
opt.writebackup = false -- don't create backup before writing
opt.backup = false -- don't create backup files
opt.undofile = true -- persist undo
opt.undodir = undodirpath

-- create undo directory if it doesn't exist
if vim.fn.isdirectory(undodirpath) then
	vim.fn.mkdir(undodirpath, "p")
end

opt.redrawtime = 10000
opt.maxmempattern = 20000
opt.incsearch = true -- Show matches as you type

opt.backspace = { "start", "eol", "indent" }
