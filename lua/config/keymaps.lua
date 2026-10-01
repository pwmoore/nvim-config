-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ~/.config/nvim/lua/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event

local map = vim.keymap.set

-- Set space as leader (LazyVim does this by default, but being explicit)
--vim.g.mapleader = " "
--vim.g.maplocalleader = " "

-- Window navigation (matching your C-h/j/k/l mappings)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Clear search highlighting
map("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- Tab navigation
map("n", "<leader>h", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>l", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>o", ":tabnew<CR>", { desc = "New tab" })
map("n", "<leader>c", ":tabclose<CR>", { desc = "Close tab" })

-- Neo-tree toggle (replacing NERDTree mapping)
map("n", "<leader>t", ":Neotree toggle<CR>", { desc = "Toggle file tree", silent = true })

-- Semicolon as colon for commands
map("n", ";", ":", { desc = "Command mode" })

-- Visual mode: yank to system clipboard
map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- Sudo write
map("c", "w!!", "w !sudo tee % >/dev/null", { desc = "Sudo write" })

-- Brace completion with newline
map("i", "{<CR>", "{<CR>}<Esc>O", { desc = "Brace block" })
