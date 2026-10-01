-- ~/.config/nvim/lua/plugins/lsp.lua
-- LSP configuration for C/C++ and Python

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- LSP Server settings
      servers = {
        -- C/C++ Language Server (clangd)
        clangd = {
          keys = {
            { "<C-]>", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition" },
            { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition" },
            { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
            { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Go to Declaration" },
            { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Go to Implementation" },
            { "gy", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Go to Type Definition" },
            { "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover Documentation" },
            { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
            { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        -- Python Language Server (pyright)
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                extraPaths = {
                  "/Applications/IDA Professional 9.2.app/Contents/MacOS/python",
                  "/Library/Frameworks/Python.framework/Versions/3.14/lib/python3.14/site-packages",
                },
              },
            },
          },
        },

        -- Alternative Python LSP (ruff_lsp for linting)
        ruff_lsp = {
          init_options = {
            settings = {
              args = {},
            },
          },
        },
      },

      -- Global LSP settings
      setup = {
        clangd = function(_, opts)
          opts.capabilities = opts.capabilities or {}
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },

  -- Additional completion sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      })

      -- Disable completion preview window
      opts.window = {
        documentation = cmp.config.disable,
      }

      return opts
    end,
  },
}
