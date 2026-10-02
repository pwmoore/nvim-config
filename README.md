# Neovim configuration

This configuration is based on [LazyVim](https://github.com/LazyVim/LazyVim).
Keep `lazy-lock.json` with the configuration so new installations use the same
plugin revisions.

## Configuration overview

This is a LazyVim v8 profile geared toward systems work and polyglot
development:

- C, C++, and Objective-C use four-space indentation. `clangd` runs with
  background indexing, clang-tidy, detailed completion, and include insertion.
- Python uses four-space indentation and configures Pyright plus `ruff_lsp`.
  Pyright currently has macOS-specific search paths for IDA Pro 9.2 and a
  Python 3.14 framework installation; update them in `lua/plugins/lsp.lua` on
  machines with a different layout.
- `*.s` and `*.S` files use ARM assembly syntax through `arm64asm-vim`, while
  `*.asm` files use NASM syntax. Assembly buffers use four-space indentation.
- Tree-sitter parsers are requested for C/C++, Python, Lua, Vim, assembly,
  shell, Make, CMake, common data and markup formats, Rust, Go, JavaScript, and
  TypeScript. Highlighting is disabled for files larger than 100 KiB.
- LazyVim extras enable clangd, CMake, Docker, Git, Go, Markdown, Python, Rust,
  SQL, TeX, TOML, TypeScript, and YAML support.
- Neo-tree follows the current file and uses NERDTree-style mappings. LuaSnip
  provides custom C, C++, and Python snippets in addition to
  `friendly-snippets`.
- TokyoNight's classic `night` variant is selected explicitly; Catppuccin is
  installed but is not the active colorscheme.
- Line wrapping, persistent undo, backup files, and swap files are enabled.
  Auto-format-on-save and modelines are disabled. Local backup, swap, and undo
  data live under `~/.config/nvim/{backup,swap,undo}` and should not be
  committed or transferred as source configuration.

Notable custom mappings:

| Mode | Mapping | Action |
| --- | --- | --- |
| Normal | `Ctrl-h/j/k/l` | Move between windows |
| Normal | `<leader>/` | Clear search highlighting |
| Normal | `<leader>h/l` | Select the previous/next tab |
| Normal | `<leader>o/c` | Open/close a tab |
| Normal | `<leader>t` | Toggle Neo-tree |
| Normal | `;` | Enter command-line mode |
| Visual | `Ctrl-c` | Copy to the system clipboard |
| Command | `w!!` | Write the current file through `sudo tee` |
| Insert/select | `Ctrl-k/j` | Jump forward/backward through snippet fields |
| Insert | `Ctrl-l` | Select the next active snippet choice |

Inside Neo-tree, `o` opens, `t` opens a tab, `i` and `s` open splits, `p`
moves to the parent, and `a`, `d`, `R`, `y`, `x`, and `P` provide file
operations.

## Installed plugins

The 47 plugins pinned in `lazy-lock.json` are grouped below by purpose:

- Core: `LazyVim`, `lazy.nvim`, `plenary.nvim`, and `nui.nvim` provide the
  distribution, package manager, and shared Lua/UI libraries.
- Completion and snippets: `blink.cmp`, `LuaSnip`, and `friendly-snippets`.
- LSP and tool management: `nvim-lspconfig`, `mason.nvim`,
  `mason-lspconfig.nvim`, `lazydev.nvim`, `clangd_extensions.nvim`,
  `venv-selector.nvim`, and `SchemaStore.nvim`.
- Formatting, linting, and builds: `conform.nvim`, `nvim-lint`,
  `cmake-tools.nvim`, `rustaceanvim`, and `crates.nvim`.
- Syntax and editing: `nvim-treesitter`, `nvim-treesitter-textobjects`,
  `nvim-ts-autotag`, `ts-comments.nvim`, `arm64asm-vim`, `mini.ai`, and
  `mini.pairs`.
- Navigation and diagnostics: `neo-tree.nvim`, `flash.nvim`, `grug-far.nvim`,
  `trouble.nvim`, `which-key.nvim`, `todo-comments.nvim`, and `snacks.nvim`.
- UI, sessions, and themes: `bufferline.nvim`, `lualine.nvim`, `noice.nvim`,
  `mini.icons`, `persistence.nvim`, `tokyonight.nvim`, and `catppuccin`.
- Git: `gitsigns.nvim` supplies signs and buffer-local Git operations.
- Markdown and TeX: `markdown-preview.nvim`, `render-markdown.nvim`, and
  `vimtex`.
- Databases: `vim-dadbod`, `vim-dadbod-ui`, and `vim-dadbod-completion`.

`lua/plugins/lsp.lua` also contains a legacy `nvim-cmp` specification and its
completion-source dependencies. LazyVim v8 currently selects `blink.cmp`, so
that specification is inactive and those plugins are not present in the
lockfile or installed plugin directory.

## Install from Git

Keeping this directory in a Git repository is the preferred way to move it
between machines. On the new machine, clone it into Neovim's standard
configuration directory:

```bash
git clone "<repository-url>" "$HOME/.config/nvim"
nvim --headless "+Lazy! sync" +qa
nvim --headless "+checkhealth" +qa
```

Move any existing `~/.config/nvim` directory aside before cloning. The first
headless command installs the plugin revisions recorded in `lazy-lock.json`;
the second reports missing system dependencies.

To put an untracked configuration under version control:

```bash
cd "$HOME/.config/nvim"
git init
git add .
git commit -m "Track Neovim configuration"
git remote add origin "<repository-url>"
git push -u origin main
```

Review the files before publishing them. Do not commit API keys, access tokens,
credentials, or machine-specific absolute paths.

## One-off transfer

Create an archive containing only the configuration:

```bash
tar -C "$HOME/.config" \
  --exclude='nvim/.git' \
  --exclude='nvim/backup' \
  --exclude='nvim/swap' \
  --exclude='nvim/undo' \
  -czf "$HOME/nvim-config.tar.gz" nvim
scp "$HOME/nvim-config.tar.gz" "<new-machine>:"
```

On the new machine:

```bash
mkdir -p "$HOME/.config"
tar -C "$HOME/.config" -xzf "$HOME/nvim-config.tar.gz"
nvim --headless "+Lazy! sync" +qa
nvim --headless "+checkhealth" +qa
```

## Offline transfer

For a machine without network access, include the plugins and tools installed
under Neovim's data directory:

```bash
tar -C "$HOME" \
  --exclude='.config/nvim/.git' \
  --exclude='.config/nvim/backup' \
  --exclude='.config/nvim/swap' \
  --exclude='.config/nvim/undo' \
  -czf "$HOME/nvim-offline.tar.gz" \
  .config/nvim \
  .local/share/nvim
```

Copy the archive to the destination, then extract it from the destination home
directory:

```bash
tar -C "$HOME" -xzf "$HOME/nvim-offline.tar.gz"
nvim --headless "+checkhealth" +qa
```

Only reuse `.local/share/nvim` on a compatible operating system and CPU
architecture. Mason packages, native plugins, and Treesitter parsers may
contain platform-specific binaries. Do not copy `~/.cache/nvim` or
`~/.local/state/nvim` unless that transient state is specifically needed.

## System dependencies

Neovim plugins do not install every external command they invoke. Reinstall
the relevant tools separately, which may include Git, ripgrep, a compiler,
language servers, formatters, `fzf`, and a platform clipboard provider. Run
`:checkhealth` inside Neovim after migration to identify anything missing.

See the [LazyVim documentation](https://lazyvim.github.io/installation) for
general installation and troubleshooting guidance.
