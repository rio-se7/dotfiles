-- ============================================================================
-- Autocommands
-- ============================================================================
-- Automatic commands for various events

local util = require("core.util")
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- Highlight on yank
-- ============================================================================
autocmd("TextYankPost", {
    group = util.augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- ============================================================================
-- Resize splits when window is resized
-- ============================================================================
autocmd({ "VimResized" }, {
    group = util.augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- ============================================================================
-- Close certain filetypes with q
-- ============================================================================
autocmd("FileType", {
    group = util.augroup("close_with_q"),
    pattern = {
        "help",
        "lspinfo",
        "man",
        "qf",
        "query",
        "checkhealth",
        "startuptime",
        "notify",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- ============================================================================
-- Auto create dir when saving a file
-- ============================================================================
autocmd({ "BufWritePre" }, {
    group = util.augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- ============================================================================
-- Remember cursor position
-- ============================================================================
autocmd("BufReadPost", {
    group = util.augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- ============================================================================
-- Wrap and spell in text filetypes
-- ============================================================================
autocmd("FileType", {
    group = util.augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- ============================================================================
-- Fix conceallevel for json files
-- ============================================================================
autocmd({ "FileType" }, {
    group = util.augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- ============================================================================
-- Terminal settings
-- ============================================================================
autocmd("TermOpen", {
    group = util.augroup("terminal"),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.cmd("startinsert")
    end,
})

-- ============================================================================
-- File-type specific settings
-- ============================================================================
autocmd("FileType", {
    group = util.augroup("filetype_settings"),
    pattern = "go",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

autocmd("FileType", {
    group = util.augroup("filetype_settings"),
    pattern = { "python", "rust" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

autocmd("FileType", {
    group = util.augroup("filetype_settings"),
    pattern = "yaml",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.cursorcolumn = true
    end,
})

-- ============================================================================
-- Remove trailing whitespace on save
-- ============================================================================
autocmd("BufWritePre", {
    group = util.augroup("trim_whitespace"),
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function()
            vim.cmd([[%s/\s\+$//e]])
        end)
        vim.fn.setpos(".", save_cursor)
    end,
})

-- ============================================================================
-- Disable autoformat for certain filetypes
-- ============================================================================
autocmd("FileType", {
    group = util.augroup("no_autoformat"),
    pattern = { "sql", "java" },
    callback = function()
        vim.b.autoformat = false
    end,
})
