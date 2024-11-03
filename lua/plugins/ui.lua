return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    ---@module "ibl"
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type ibl.config
    opts = {
      --scope = { enabled = true },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "nvim-lualine/lualine.nvim",
  },
  --{
  --  "folke/which-key.nvim",
  --  event = "VeryLazy",
  --  opts = {
  --    -- your configuration comes here
  --    -- or leave it empty to use the default settings
  --    -- refer to the configuration section below
  --  },
  --  keys = {
  --    {
  --      "<leader>?",
  --      function()
  --        require("which-key").show({ global = false })
  --      end,
  --      desc = "Buffer Local Keymaps (which-key)",
  --    },
  --  },
  --},
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true
          -- ...
        },
      })
    end
  },
  { 'danilamihailov/beacon.nvim' }, -- dont lose mouse
  {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      -- configs...
    end,
  },
}
