-- ============================================================================
-- Neovim Configuration
-- ============================================================================
-- Modern, minimal, and fast Neovim config for DevOps/Infrastructure work
-- Optimized for: Lua, Python, Go, Bash, YAML, JSON, Markdown, Dockerfile

-- Set leader keys before loading any plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Disable built-in plugins we don't need
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Load configuration modules
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Bootstrap and load lazy.nvim
require("core.lazy")
