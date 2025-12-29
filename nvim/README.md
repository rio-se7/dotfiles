# Neovim Configuration - Oil.nvim Edition

シンプルで強力なNeovim設定。**Oil.nvim**をメインファイルエクスプローラーとして採用。

## ✨ 特徴

### 🚀 パフォーマンス
- **⚡ 超高速起動** - 最小限のプラグイン
- **🔋 軽量設計** - 必要なものだけ
- **📦 Oil.nvim** - バッファベースのファイル操作

### 🎨 UI/UX
- **Tokyo Night** - モダンなカラースキーム
- **Lualine** - ステータスライン
- **Bufferline** - バッファータブ
- **Dashboard** - 起動画面
- **Noice** - 洗練されたUI

### 🔧 開発機能
- **LSP** - Mason + nvim-lspconfig
- **自動補完** - nvim-cmp + LuaSnip
- **フォーマット** - conform.nvim
- **リンティング** - nvim-lint
- **診断** - Trouble.nvim

### 📁 ファイル管理
- **Oil.nvim** - ディレクトリをバッファとして編集
- バッファ管理 - Bufferline
- セッション - persistence.nvim

### 🎯 Git統合
- **Gitsigns** - インラインgit統合
- **Fugitive** - Gitコマンド
- **LazyGit** - ターミナルUI

### 🌳 その他
- **Treesitter** - シンタックスハイライト
- **ターミナル** - toggleterm.nvim
- **TODO管理** - todo-comments.nvim

## 📦 対応言語

| 言語 | LSP | フォーマット | リント |
|------|-----|------------|--------|
| Lua | ✅ lua_ls | ✅ stylua | ✅ |
| Python | ✅ pyright | ✅ black, isort | ✅ flake8 |
| Go | ✅ gopls | ✅ gofmt, goimports | ✅ golangci-lint |
| Bash | ✅ bashls | ✅ shfmt | ✅ shellcheck |
| YAML | ✅ yamlls | ✅ prettier | ✅ yamllint |
| JSON | ✅ jsonls | ✅ prettier | - |
| Markdown | ✅ marksman | ✅ prettier | - |
| Dockerfile | ✅ dockerls | - | ✅ hadolint |
| Rust | ✅ rust_analyzer | ✅ rustfmt | ✅ |

## 🚀 インストール

### macOS

```bash
# 依存関係をインストール
brew install neovim ripgrep fd lazygit
brew install --cask font-jetbrains-mono-nerd-font

# 設定をインストール
tar xzf nvim-complete-final.tar.gz
cp -r nvim-complete ~/.config/nvim

# 起動
nvim
```

### Linux

```bash
# Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update && sudo apt install neovim ripgrep fd-find

# 設定をインストール
tar xzf nvim-complete-final.tar.gz
cp -r nvim-complete ~/.config/nvim

# 起動
nvim
```

## ⌨️ キーバインド

### リーダーキー: `,` (カンマ)

### 🎯 Oil.nvim - メインファイルエクスプローラー

| キー | 動作 |
|------|------|
| `,e` | Oilを開く |
| `,fe` | Oilを開く |
| `-` | 親ディレクトリ / Oilを開く |

**起動画面（Dashboard）**:
- `e` キーを押すだけでOilが開きます

**Oil内での操作**:
| キー | 動作 |
|------|------|
| `<CR>` | ファイル/ディレクトリを開く |
| `-` | 親ディレクトリへ移動 |
| `h` | 親ディレクトリへ移動（Vim風） |
| `<BS>` | 親ディレクトリへ移動（Backspace） |
| `l` | ファイル/ディレクトリを開く（Vim風） |
| `_` | カレントディレクトリのルート |
| `i` | 編集モード（ファイル名変更） |
| `dd` | ファイルを削除マーク |
| `:w` | 変更を保存（ファイル操作実行） |
| `g.` | 隠しファイル表示切り替え |
| `<C-v>` | 垂直分割で開く |
| `<C-s>` | 水平分割で開く |
| `<C-p>` | プレビュー |
| `g?` | ヘルプ |

**画面表示**:
- 一番上に `../` が表示される（親ディレクトリ）
- `<CR>` または `l` で `../` を選択すると親ディレクトリに移動

### バッファ & ウィンドウ

| キー | 説明 |
|------|------|
| `<S-h>` / `<S-l>` | 前/次のバッファ |
| `,bd` | バッファを閉じる |
| `<C-h/j/k/l>` | ウィンドウ間移動 |
| `,-` | 水平分割 |
| `,|` | 垂直分割 |

### LSP

| キー | 説明 |
|------|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照を表示 |
| `K` | ホバードキュメント |
| `,ca` | コードアクション |
| `,cr` | 名前変更 |
| `,cf` | フォーマット |
| `]d` / `[d` | 次/前の診断 |

### Git

| キー | 説明 |
|------|------|
| `,gg` | LazyGit |
| `,ghs` | ハンクをステージ |
| `,ghr` | ハンクをリセット |
| `,ghp` | ハンクをプレビュー |
| `]h` / `[h` | 次/前のハンク |

### ターミナル

| キー | 説明 |
|------|------|
| `<C-/>` | ターミナル切り替え |
| `,tt` | ターミナル切り替え |
| `,tf` | フローティングターミナル |

### その他

| キー | 説明 |
|------|------|
| `,l` | Lazy (プラグインマネージャー) |
| `,cm` | Mason (LSPマネージャー) |
| `,qq` | 全て終了 |
| `jk` / `kj` | Escapeの代替 |

## 🎓 Oil.nvimの使い方

### ファイル名の一括変更

```
1. ,e でディレクトリを開く
2. i で編集モードに入る
3. 複数のファイル名を編集（通常のVim操作）
4. :w で変更を保存
```

### ファイルの削除

```
1. ,e でディレクトリを開く
2. dd で削除したいファイルをマーク
3. :w で削除を実行
```

### ディレクトリの作成

```
1. ,e でディレクトリを開く
2. i で編集モード
3. o で新しい行を追加
4. new_folder/ と入力（末尾のスラッシュが重要）
5. :w で作成
```

## 🔧 カスタマイズ

### LSPサーバーの追加

`lua/plugins/lsp.lua`:
```lua
servers = {
    lua_ls = { ... },
    your_lsp = {},  -- 追加
}
```

### フォーマッターの追加

`lua/plugins/formatting.lua`:
```lua
formatters_by_ft = {
    your_filetype = { "your_formatter" },
}
```

## 📁 ディレクトリ構造

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── core/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   ├── autocmds.lua
│   │   ├── lazy.lua
│   │   └── util.lua
│   └── plugins/
│       ├── colorscheme.lua
│       ├── ui.lua
│       ├── editor.lua        # Oil.nvim設定
│       ├── lsp.lua
│       ├── completion.lua
│       ├── treesitter.lua
│       ├── git.lua
│       ├── terminal.lua
│       ├── formatting.lua
│       ├── linting.lua
│       └── utilities.lua
└── README.md
```

## 🐛 トラブルシューティング

### Oil.nvimが起動しない

```vim
:Lazy sync
:Oil
```

### LSPが動作しない

```vim
:Mason
:checkhealth lsp
```

### 完全リセット

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
cp -r nvim-complete ~/.config/nvim
nvim
```

## 💡 ヒント

- **Oil.nvimの本質**: ディレクトリをバッファとして編集できる
- **Vimの操作がそのまま使える**: dd, yy, p, /, など
- **マクロも使える**: 複雑なファイル操作も自動化可能
- **`:w`を忘れずに**: 編集しただけでは変更されない

## 📝 ライセンス

MIT

## 🙏 クレジット

- [Oil.nvim](https://github.com/stevearc/oil.nvim) - 革新的なファイルエクスプローラー
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

---

**Oil.nvimで快適なファイル編集を！ 🛢️**

## 🎯 Treesitter Text Objects

コード構造に基づいた強力な選択と移動機能：

### 選択（Visual/Operator-pending mode）

| キー | 説明 |
|------|------|
| `af` | 関数全体（外側） |
| `if` | 関数の中身 |
| `ac` | クラス全体（外側） |
| `ic` | クラスの中身 |
| `al` | ループ全体 |
| `il` | ループの中身 |
| `aa` | 引数全体 |
| `ia` | 引数の中身 |

**使用例**:
```
vaf  - 関数全体を選択
dif  - 関数の中身を削除
cac  - クラス全体を変更
yaa  - 引数をヤンク
```

### 移動

| キー | 説明 |
|------|------|
| `]f` / `[f` | 次/前の関数へ |
| `]c` / `[c` | 次/前のクラスへ |
| `]a` / `[a` | 次/前の引数へ |
| `]F` / `[F` | 次/前の関数の終わりへ |

### 引数の入れ替え

| キー | 説明 |
|------|------|
| `,a` | カーソル下の引数を次と入れ替え |
| `,A` | カーソル下の引数を前と入れ替え |

