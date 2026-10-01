-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocmds are automatically loaded on the VeryLazy event

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Sandbox files as scheme
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("sandbox_scheme"),
  pattern = "*.sb",
  callback = function()
    vim.bo.filetype = "scheme"
  end,
})

-- Scheme settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("scheme_settings"),
  pattern = "scheme",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

-- ARM assembly files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("arm_asm"),
  pattern = { "*.s", "*.S" },
  callback = function()
    vim.g.asmsyntax = "armasm"
    vim.g.filetype_inc = "armasm"
  end,
})

-- NASM files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("nasm_asm"),
  pattern = "*.asm",
  callback = function()
    vim.g.asmsyntax = "nasm"
  end,
})

-- Assembly settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("asm_settings"),
  pattern = { "asm", "nasm" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
  end,
})

-- Objective-C files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("objc"),
  pattern = "*.m",
  callback = function()
    vim.bo.filetype = "objc"
  end,
})

-- C/C++/Objective-C settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("c_like"),
  pattern = { "c", "cpp", "objc" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.cindent = true
  end,
})

-- C format options
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("c_format"),
  pattern = "c",
  callback = function()
    vim.bo.formatoptions = vim.bo.formatoptions .. "ro"
  end,
})

-- Python settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("python_settings"),
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
  end,
})

-- JavaScript settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("javascript_settings"),
  pattern = "javascript",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.cindent = true
  end,
})

-- HTML settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("html_settings"),
  pattern = "html",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})

-- Shell script settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("shell_settings"),
  pattern = "sh",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})

-- Makefile settings (tabs, not spaces!)
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("makefile_settings"),
  pattern = "make",
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 8
  end,
})
