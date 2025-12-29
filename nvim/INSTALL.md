# Neovim Configuration - インストールガイド

## 🚀 クイックスタート

### 1. 既存の設定をバックアップ

```bash
# 既存の設定がある場合はバックアップ
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)
mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d)
mv ~/.cache/nvim ~/.cache/nvim.backup.$(date +%Y%m%d)
```

### 2. 設定をインストール

```bash
# アーカイブを展開
tar xzf nvim-complete-fixed.tar.gz

# 設定をコピー
cp -r nvim-complete ~/.config/nvim

# Neovimを起動
nvim
```

### 3. 初回起動時の注意

初回起動時にエラーが出る場合があります。これは正常です：

```
Failed to source nvim-treesitter-textobjects
module 'nvim-treesitter.configs' not found
```

**解決方法**:

1. Neovimを一度終了 (`:qa!`)
2. キャッシュをクリア:
```bash
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim/lazy
```

3. 再度Neovimを起動:
```bash
nvim
```

4. プラグインを手動インストール:
```vim
:Lazy sync
```

5. Treesitterパーサーをインストール:
```vim
:TSInstall all
```

6. Neovimを再起動

## 🔧 トラブルシューティング

### Treesitterエラーが出る

```bash
# Treesitterデータをクリア
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter

# Neovimを起動して再インストール
nvim
:Lazy sync
:TSInstall bash lua python go yaml json markdown dockerfile
```

### LSPが動作しない

```vim
:Mason
:MasonInstall lua-language-server pyright gopls bash-language-server
```

### プラグインのインストールが止まる

```vim
:Lazy clear
:Lazy sync
```

### 完全クリーンインストール

```bash
# すべてのNeovim関連データを削除
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim

# 設定を再インストール
cp -r nvim-complete ~/.config/nvim
nvim
```

## ⚙️ 段階的インストール方法

問題を避けるため、段階的にインストールすることをお勧めします：

### ステップ1: 基本設定のみ

```bash
# プラグインを無効化してテスト
nvim --noplugin
```

### ステップ2: プラグインマネージャーのみ

```bash
# 設定をインストール
nvim

# lazy.nvimが自動的にインストールされるのを待つ
# エラーが出たら :qa! で終了し、再度起動
```

### ステップ3: コアプラグイン

```vim
:Lazy sync
```

Treesitter関連のエラーは無視して進めます。

### ステップ4: Treesitterのクリーンインストール

```vim
:TSUninstall all
:TSInstall bash lua python go yaml json markdown
```

### ステップ5: LSPサーバー

```vim
:Mason
```

そして必要なLSPサーバーを選択してインストール (`i`キーでインストール)。

## 📋 インストール後のチェックリスト

```vim
# 健全性チェック
:checkhealth

# プラグインの状態確認
:Lazy

# LSPサーバーの状態確認
:Mason

# Treesitterの状態確認
:TSInstallInfo
```

すべてが正常に動作していることを確認してください。

## 🎯 推奨される初回起動手順

```bash
# 1. 完全クリーンスタート
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim

# 2. 設定をコピー
cp -r nvim-complete ~/.config/nvim

# 3. Neovimを起動（エラーは無視）
nvim

# 4. 終了
# Neovim内で :qa!

# 5. 再度起動（今度はエラーが少ないはず）
nvim

# 6. プラグインが自動インストールされるのを待つ
# 完了したら再起動

# 7. 最終チェック
nvim
# :checkhealth を実行
```

## 💡 ヒント

- **忍耐が必要**: 初回起動時は1-2分かかることがあります
- **再起動が鍵**: エラーが出たら一度終了して再起動
- **段階的に**: すべてを一度にインストールしようとしない
- **ログを確認**: `:messages` でエラーメッセージを確認

## 📞 よくある質問

### Q: "module not found" エラーが出る

A: キャッシュをクリアして再起動:
```bash
rm -rf ~/.cache/nvim && nvim
```

### Q: プラグインが読み込まれない

A: Lazy.nvimを再同期:
```vim
:Lazy sync
```

### Q: 起動が非常に遅い

A: Treesitterを無効化してテスト:
```lua
-- lua/plugins/treesitter.lua を一時的にリネーム
mv ~/.config/nvim/lua/plugins/treesitter.lua ~/.config/nvim/lua/plugins/treesitter.lua.bak
```

### Q: LSPが動作しない

A: Masonで手動インストール:
```vim
:Mason
```
必要なサーバーを選択して `i` でインストール。

---

問題が解決しない場合は、`:checkhealth` の出力を確認してください。
