-- ============================================================================
-- Terminal Plugin
-- ============================================================================

return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<C-/>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
            { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
            { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal Vertical" },
        },
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<C-/>]],
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            persist_mode = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            auto_scroll = true,
            float_opts = {
                border = "curved",
                winblend = 0,
            },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)

            -- Terminal mode keymaps
            function _G.set_terminal_keymaps()
                local map_opts = { buffer = 0 }
                vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], map_opts)
                vim.keymap.set("t", "jk", [[<C-\><C-n>]], map_opts)
                vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], map_opts)
                vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], map_opts)
                vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], map_opts)
                vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], map_opts)
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

            -- LazyGit integration
            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
            })

            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end

            vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "LazyGit", silent = true })
        end,
    },
}
