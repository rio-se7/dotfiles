-- lua/plugins/lsp_python.lua

return {
  "astral-sh/ruff-lsp",
  config = function()
    vim.lsp.config("ruff_lsp", {
      on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
      end,
    })
    vim.lsp.enable({ "ruff_lsp" })
  end,
}
