-- lua/core/options.lua

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.termguicolors = true

-- Indent / tabs
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Other
opt.clipboard = "unnamedplus"
opt.scrolloff = 4
opt.splitright = true
opt.splitbelow = true
