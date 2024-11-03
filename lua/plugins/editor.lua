return {
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    cmd = { "TodoTelescope", "TodoLocList" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>tt", "<cmd>TodoTelescope<cr>",                            desc = "List Todo in Telescope" },
      { "<leader>tl", "<cmd>TodoLocList<cr>",                              desc = "List Todo in LocList" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
}
