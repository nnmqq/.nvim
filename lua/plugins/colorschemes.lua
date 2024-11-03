return {
  {
    "ellisonleao/gruvbox.nvim",
    -- "sainnhe/gruvbox-material",
    -- "morhetz/gruvbox",
    priority = 1000,
    config = function()
      vim.o.background = "dark"

      require("gruvbox").setup({
        --transparent_mode = true,
      })
    end,
  },
  {
    "sho-87/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
