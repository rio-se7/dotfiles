-- lua/plugins/lsp.lua

return {
  -- Mason: install LSP servers / tools
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  -- LSP core (use new vim.lsp.config / vim.lsp.enable API)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Capabilities for nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Common on_attach for all servers
      local on_attach = function(_, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- LSP keymaps (if you prefer独自マップ。0.11標準のキーマップでもOK)
        bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
        bufmap("n", "gr", vim.lsp.buf.references, "References")
        bufmap("n", "K", vim.lsp.buf.hover, "Hover docs")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        bufmap("n", "<leader>fd", vim.diagnostic.open_float, "Line diagnostics")
        bufmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
      end

      -- LSP servers you want to use
      local servers = {
        "ts_ls",       -- TypeScript / JavaScript / TSX / JSX (tsserver の新名)
        "pyright",     -- Python
        "terraformls", -- Terraform
        "lua_ls",      -- Lua (Neovim config 用)
      }

      -- Apply per-server config with new API
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
          on_attach = on_attach,
          -- 必要ならここに server ごとの settings を足せる:
          -- settings = { ... },
          vim.lsp.config("pyright", {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                },
              },
            },
          })
        })
      end

      -- Enable all configured servers (Neovim 0.11+)
      vim.lsp.enable(servers)
    end,
  },
}
