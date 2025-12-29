-- ============================================================================
-- LSP Configuration
-- ============================================================================

return {
    -- LSPConfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
            },
            inlay_hints = {
                enabled = false,
            },
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            diagnostics = { globals = { "vim" } },
                        },
                    },
                },
                pyright = {},
                gopls = {}, -- Install manually: brew install gopls
                bashls = {},
                yamlls = {},
                jsonls = {},
                dockerls = {},
                marksman = {},
                rust_analyzer = {},
            },
        },
        config = function(_, opts)
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {}
            )

            -- Setup function for each server
            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})
                
                -- Get lspconfig once to avoid the deprecation warning
                local lspconfig = require("lspconfig")
                local server_config = lspconfig[server]
                
                if server_config then
                    server_config.setup(server_opts)
                end
            end

            -- Setup all configured servers
            for server in pairs(servers) do
                setup(server)
            end
        end,
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
            },
        },
    },

    -- Mason LSPConfig
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                -- "gopls", -- Install manually: brew install gopls
                "bashls",
                "yamlls",
                "jsonls",
                "dockerls",
                "marksman",
            },
        },
    },
}
