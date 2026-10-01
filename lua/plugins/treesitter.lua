-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Enhanced syntax highlighting with Tree-sitter

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Core languages
        "c",
        "cpp",
        "python",
        "lua",
        "vim",
        "vimdoc",

        -- Assembly
        "asm",

        -- Shell
        "bash",

        -- Build systems
        "make",
        "cmake",

        -- Data formats
        "json",
        "yaml",
        "toml",

        -- Markup
        "markdown",
        "markdown_inline",
        "html",
        "css",

        -- Other useful languages
        "rust",
        "go",
        "javascript",
        "typescript",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        enable = true,
        -- Disable for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },

  -- Additional syntax highlighting for ARM assembly
  {
    "compnerd/arm64asm-vim",
    ft = { "asm", "s" },
  },
}
