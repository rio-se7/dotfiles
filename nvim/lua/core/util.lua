-- ============================================================================
-- Utility Functions
-- ============================================================================
-- Helper functions used across the configuration

local M = {}

-- Format toggle state
M.format_enabled = true

-- Toggle format on save
function M.format_toggle()
    M.format_enabled = not M.format_enabled
    vim.notify("Format on save " .. (M.format_enabled and "enabled" or "disabled"))
end

-- Diagnostic toggle state
M.diagnostic_enabled = true

-- Toggle diagnostics
function M.diagnostic_toggle()
    M.diagnostic_enabled = not M.diagnostic_enabled
    if M.diagnostic_enabled then
        vim.diagnostic.enable()
        vim.notify("Diagnostics enabled")
    else
        vim.diagnostic.disable()
        vim.notify("Diagnostics disabled")
    end
end

-- Get icon for file or filetype
function M.get_icon(name, filetype)
    local has_devicons, devicons = pcall(require, "nvim-web-devicons")
    if has_devicons then
        return devicons.get_icon(name, filetype, { default = true })
    end
    return ""
end

-- Check if buffer is empty
function M.is_buffer_empty()
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

-- Check if buffer is valid and not special
function M.is_valid_buffer()
    local buftype = vim.bo.buftype
    local filetype = vim.bo.filetype
    
    if buftype == "" and filetype ~= "" then
        return true
    end
    
    return false
end

-- Get git root directory
function M.get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

-- Create augroup
function M.augroup(name)
    return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Format on save handler
function M.format_on_save(client, bufnr)
    if not M.format_enabled then
        return
    end
    
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = M.augroup("lsp_format"),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(c)
                        return c.id == client.id
                    end,
                })
            end,
        })
    end
end

return M
