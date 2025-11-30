# 💤 Neovim Config (Lazy / NeoVim 0.11+)

A modern Neovim configuration optimized for:
- TypeScript / JavaScript / React / Python / Terraform
- LSP / Formatter統一 (`Conform.nvim`)
- Git操作 (`gitsigns.nvim`, `vim-fugitive`)
- Minimal & Fast
- macOS / Linux (Pop!_OS) 両対応

---

## 🧠 Features

| 機能 | Plugin |
|------|--------|
| Plugin Manager | `lazy.nvim` |
| LSP | `nvim-lspconfig` + `mason.nvim` |
| Completion | `nvim-cmp` + `LuaSnip` |
| Formatting | `conform.nvim` (Prettier / Ruff / Terraform fmt) |
| Git UI | `gitsigns.nvim`, `vim-fugitive` |
| File Explorer | `oil.nvim` |
| UI | `tokyonight`, `lualine` |
| Treesitter | Syntax Highlight / Indent |

---

## 🧩 Supported Languages

| Language | LSP | Formatter |
|---------|-----|------------|
| TS / JS / React | `ts_ls` | `prettierd` / `prettier` |
| Python | `pyright` | `ruff_format` |
| Terraform | `terraformls` | `terraform_fmt` |
| Lua | `lua_ls` | `stylua` |

---

🔧 Usage

| Command | Description|
|---------|------------|
|:Mason | LSP installer|
|:Lazy | Plugin manager|
|:Format / <leader>f | Format file|
|<leader>gs | Git status (fugitive)|
|<leader>e | Oil file explorer|
|[c / ]c | Previous / Next hunk|
|<leader>hs | Stage hunk|
|<leader>hp | Preview hunk|
|<leader>hb | Blame|

---

📂 Directory Structure

```text
nvim
├── init.lua
└── lua
    ├── core
    │   ├── options.lua
    │   └── keymaps.lua
    └── plugins
        ├── ui.lua
        ├── coding.lua
        ├── lsp.lua
        ├── formatting.lua
        └── git.lua
```

🧪 Recommended Commands

```bash
nvim
:Mason
:Lazy sync
:LspInfo
:ConformInfo
```

