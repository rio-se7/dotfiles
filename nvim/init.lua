-- init.lua

-- Leader keys must be set before plugins and keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core settings
require("core.options")
require("core.keymaps")

-- Bootstrap lazy.nvim --------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins (load all modules under lua/plugins/)
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
