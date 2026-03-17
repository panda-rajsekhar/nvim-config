# Neovim Configuration

A clean, minimal, and modern **Neovim configuration** built with **Lua** and managed using **lazy.nvim**.
This setup focuses on **performance, readability, and essential developer tooling** without unnecessary bloat.

---

## 📸 Preview

![Neovim Setup](./Screenshot%20from%202026-03-17%2023-18-47.png)

---

## ✨ Features

* Modern **Lua-based configuration**
* Plugin management with **lazy.nvim**
* Fast **fuzzy file searching** using Telescope
* **Treesitter-based syntax highlighting**
* Clean UI using the **Tokyo Night** colorscheme
* Useful **quality-of-life keybindings**
* Sensible defaults for development

---

## 📦 Plugins

### Core

| Plugin                                      | Purpose              |
| ------------------------------------------- | -------------------- |
| folke/lazy.nvim                             | Plugin manager       |
| folke/tokyonight.nvim                       | Colorscheme          |
| nvim-telescope/telescope.nvim               | Fuzzy finder         |
| nvim-lua/plenary.nvim                       | Telescope dependency |
| nvim-telescope/telescope-fzf-native.nvim    | Faster fuzzy search  |
| nvim-treesitter/nvim-treesitter             | Syntax highlighting  |
| nvim-treesitter/nvim-treesitter-textobjects | Code navigation      |

---

## 📁 Directory Structure

```
~/.config/nvim/
│
├── init.lua
└── lua/
```

Plugins are installed automatically by **lazy.nvim** on first launch.

---


## ⌨️ Keybindings

### Leader Key

```
<Space>
```

### Window Navigation

| Key      | Action           |
| -------- | ---------------- |
| Ctrl + h | Move left window |
| Ctrl + j | Move down        |
| Ctrl + k | Move up          |
| Ctrl + l | Move right       |

---

### Telescope

| Key          | Action       |
| ------------ | ------------ |
| `<leader>ff` | Find files   |
| `<leader>fg` | Live grep    |
| `<leader>fb` | Find buffers |
| `<leader>fr` | Recent files |
| `<leader>fh` | Help tags    |

---

### Buffers

| Key          | Action          |
| ------------ | --------------- |
| Shift + h    | Previous buffer |
| Shift + l    | Next buffer     |
| `<leader>bd` | Delete buffer   |

---

### Editing

| Key         | Action                 |
| ----------- | ---------------------- |
| `<leader>w` | Save file              |
| `<leader>q` | Quit                   |
| `<Esc>`     | Clear search highlight |

---

## 🎨 UI Settings

* Absolute line numbers
* Cursor line highlight
* 24-bit terminal colors
* No line wrapping
* Persistent undo
* System clipboard integration

---

## 🚀 Performance Optimizations

* Lazy plugin loading via **lazy.nvim**
* Native **FZF extension** for Telescope
* Treesitter parsing for efficient syntax highlighting
* Reduced `updatetime` for faster diagnostics

---

## 🛠 Requirements

* **Neovim ≥ 0.9**
* **Git**
* **C compiler** (for telescope-fzf-native)
* `make`

---

## 📌 Future Improvements

Potential additions:

* LSP configuration
* Autocompletion (`nvim-cmp`)
* Git integration (`gitsigns`)
* Statusline (`lualine`)
* Debug adapter support

---


