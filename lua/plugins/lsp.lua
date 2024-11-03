return {
  -- Mason for managing LSP servers and DAP installations
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim"
    },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
    end,
  },

  -- LSP configurations using nvim-lspconfig, with Mason support and LSP UI tools
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason-LSPConfig bridge for easy integration
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "clangd", "pyright", "rust_analyzer", "jdtls", "lua_ls" },
          })
        end,
      },
      {
        "glepnir/lspsaga.nvim",
        config = function()
          require("lspsaga").setup({
            -- Add any custom UI options if needed
          })
        end,
      },
    },
    config = function()
      require("config.lspconfig")
    end,
  },

  -- diagnostics and stuff
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- linters and formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.diagnostics.cppcheck,
        },
      })
    end
  },

  { "mfussenegger/nvim-jdtls" }
}
