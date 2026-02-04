# dotfiles

Mac 向けの個人用 dotfiles です。
WezTerm と Neovim（LazyVim）を中心に、開発環境を Git 管理しています。

**clone → install.sh 実行** だけで、他のデバイスでも同じ環境を再現できます。

---

## 対応環境

* macOS
* WezTerm
* Neovim（LazyVim）
* Homebrew

---

## ディレクトリ構成

```text
dotfiles
├── nvim/                  # Neovim (LazyVim) 設定
│   ├── init.lua
│   ├── lua/
│   │   ├── config/        # options / keymaps / colorscheme など
│   │   ├── plugins/       # Lazy.nvim プラグイン定義
│   │   └── ...
│   └── lazy-lock.json     # プラグインバージョン固定（重要）
│
├── wezterm/
│   └── wezterm.lua        # WezTerm 設定
│
├── Brewfile               # Homebrew 依存関係
├── install.sh             # セットアップ用スクリプト
└── README.md
```

---

## セットアップ手順（新しい Mac）

### 1. Homebrew をインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

### 2. dotfiles を clone

```bash
git clone git@github.com:HarumaIto/wezterm-neovim-dotfiles.git ~/dotfiles
cd ~/dotfiles
```

---

### 3. 依存関係をインストール

```bash
brew bundle
```

---

### 4. 設定ファイルをリンク

```bash
./install.sh
```

以下のシンボリックリンクが作成されます。

* `~/.config/nvim` → `~/dotfiles/nvim`
* `~/.wezterm.lua` → `~/dotfiles/wezterm/wezterm.lua`

---

### 5. Neovim を起動

```bash
nvim
```

* Lazy.nvim が自動でプラグインをインストールします
* `lazy-lock.json` により、同一バージョンの環境が再現されます

