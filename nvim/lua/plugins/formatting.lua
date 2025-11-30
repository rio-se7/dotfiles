-- lua/plugins/formatting.lua

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")

    conform.setup({
      -- Map of filetype to formatters
      -- See :help conform-formatters and README for names
      -- javascript/typescript/tsx/jsx/python/terraform をここでまとめて指定
      formatters_by_ft = {
        -- JS / TS 系
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true }, -- .jsx
        typescriptreact = { "prettierd", "prettier", stop_after_first = true }, -- .tsx

        -- Python
        python = { "ruff_format" },

        -- Terraform
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },

        -- (おまけ) Lua をいじるなら
        lua = { "stylua" },
      },

      -- Default options when calling conform.format()
      default_format_opts = {
        timeout_ms = 3000,
        lsp_format = "fallback", -- Use LSP formatter if no external formatter
      },

      -- ★自動フォーマットはとりあえず OFF
      -- 必要になったらここで format_on_save を有効化する
      -- format_on_save = {
      --   lsp_format = "fallback",
      --   timeout_ms = 3000,
      -- },
      format_on_save = function(bufnr)
        -- 限定した filetype だけ自動フォーマット
        local ft = vim.bo[bufnr].filetype
        local enable = {
          javascript = true,
          typescript = true,
          javascriptreact = true,
          typescriptreact = true,
          python = true,
          terraform = true,
          tf = true,
          ["terraform-vars"] = true,
          lua = true,
        }
        if enable[ft] then
          return { lsp_format = "fallback", timeout_ms = 3000 }
        end
        -- その他は何もしない
        return nil
      end,
    })

    -- :Format コマンドを定義（バッファ全体をフォーマット）
    vim.api.nvim_create_user_command("Format", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
      })
    end, { desc = "Format current buffer" })

    -- <leader>f でも同じことができるようにする
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
      })
    end, { desc = "Format buffer" })
  end,
}
