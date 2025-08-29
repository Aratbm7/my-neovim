# My Neovim Setup

This repository contains my Neovim configuration using **ThePrimeagen's setup** with **Snacks.nvim** for enhanced productivity. It is tailored for coding in multiple languages with modern LSP support and VSCode-like behavior.

---

## Features

- **Auto-save** on text change, mimicking VSCode behavior.
- **LSP integration** with auto inlay hints.
- **Snacks.nvim** for explorer, quickfile, and toggles.
- **Beautiful themes**: TokyoNight, Rose-Pine-Moon.
- **JetBrains Mono font** for clean code readability.
- **UTF-8 ready** for Persian and other languages.

---

## Keymaps (Snacks.nvim)

### Toggle Options
| Action | Keymap |
|--------|--------|
| Toggle Spelling | `<leader>us` |
| Toggle Line Wrap | `<leader>uw` |
| Toggle Relative Number | `<leader>uL` |
| Toggle Diagnostics | `<leader>ud` |
| Toggle Line Numbers | `<leader>ul` |
| Toggle Conceal Level | `<leader>uc` |
| Toggle Treesitter | `<leader>uT` |
| Toggle Background (Light/Dark) | `<leader>ub` |
| Toggle Inlay Hints | `<leader>uh` |
| Toggle Indent Guides | `<leader>ug` |
| Toggle Dim Text | `<leader>uD` |

### LSP Navigation
| Action | Keymap |
|--------|--------|
| Go to Definition | `gd` |
| Go to Declaration | `gD` |
| Go to Implementation | `gI` |
| Go to References | `gr` |
| Go to Type Definition | `gy` |
| Workspace Symbols | `<leader>sS` |
| LSP Symbols | `<leader>ss` |

---

## Installation

1. Make sure you have **Neovim >= 0.11** installed.
2. Clone this repo:

```bash
git clone https://github.com/yourusername/your-neovim-config.git ~/.config/nvim

