-- ============================================================================
-- Core Options
-- ============================================================================
-- General editor settings and behavior

local opt = vim.opt
local g = vim.g

-- ============================================================================
-- UI/Display
-- ============================================================================
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.showcmd = true
opt.laststatus = 3 -- global statusline
opt.cmdheight = 1
opt.pumheight = 10
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = {
    tab = "→ ",
    trail = "·",
    nbsp = "␣",
    extends = "⟩",
    precedes = "⟨",
}
opt.fillchars = {
    eob = " ",
    fold = " ",
    foldsep = " ",
    diff = "╱",
}

-- ============================================================================
-- Editor Behavior
-- ============================================================================
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.timeoutlen = 300
opt.completeopt = { "menu", "menuone", "noselect" }
opt.virtualedit = "block"

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Completion
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"
opt.pumblend = 10
opt.winblend = 10

-- File handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.autowrite = true
opt.confirm = true

-- Performance
opt.synmaxcol = 300

-- Folding (with treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Formatting
opt.formatoptions = "jcroqlnt"

-- Spell
opt.spelllang = { "en" }
opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- ============================================================================
-- Provider Configuration
-- ============================================================================
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

-- ============================================================================
-- Platform-specific
-- ============================================================================
if vim.fn.has("win32") == 1 then
    opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    opt.shellcmdflag =
        "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
    opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    opt.shellquote = ""
    opt.shellxquote = ""
end
