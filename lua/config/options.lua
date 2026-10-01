-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- -- ~/.config/nvim/lua/config/options.lua
-- Options are automatically loaded before lazy.nvim startup

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = false -- Set to true if you want relative numbers

-- Mouse
opt.mouse = "a"

-- Backup and undo
opt.backup = true
opt.backupdir = vim.fn.expand("~/.config/nvim/backup")
opt.directory = vim.fn.expand("~/.config/nvim/swap")
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- Create directories if they don't exist
local function ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end
end

ensure_dir(vim.fn.expand("~/.config/nvim/backup"))
ensure_dir(vim.fn.expand("~/.config/nvim/swap"))
ensure_dir(vim.fn.expand("~/.config/nvim/undo"))

-- Wrapping
opt.wrap = true
opt.linebreak = true

-- Search
opt.incsearch = true
opt.hlsearch = true

-- Command line
opt.showcmd = true
opt.showmode = true

-- Matching brackets
opt.showmatch = true

-- Wildcard mode
opt.wildmode = "list:longest,full"

-- Title
opt.title = true

-- Scrolling
opt.scrolljump = 5
opt.scrolloff = 3

-- Folding
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Disable preview window for completion
opt.completeopt = "menu,menuone,noselect"

-- Backspace behavior
opt.backspace = "indent,eol,start"

-- Disable modelines for security
opt.modelines = 0

-- Disable auto-formatting on save (LazyVim default behavior)
vim.g.autoformat = false
