return {
  -- auto-completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Basic sources for nvim-cmp
      "hrsh7th/cmp-nvim-lsp",     -- LSP completion
      "hrsh7th/cmp-buffer",       -- Buffer completion
      "hrsh7th/cmp-path",         -- Path completion
      "hrsh7th/cmp-cmdline",      -- Cmdline completion
      "hrsh7th/cmp-emoji",        -- Emoji completion
      "saadparwaiz1/cmp_luasnip", -- Snippet completion
      "onsails/lspkind.nvim",     -- Pictograms for completion
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      { "saadparwaiz1/cmp_luasnip", lazy = true },       -- luasnip completion source for nvim-cmp
      {
        "rafamadriz/friendly-snippets",
        lazy = true,
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
  },
  -- auto pairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
}
