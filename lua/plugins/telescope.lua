return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "andrew-george/telescope-themes",
  },
  config = function()
    require('telescope').load_extension('themes')
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    --vim.keymap.set("n", "<leader>ps", ":Telescope possession list<CR>", { desc = "Telescope help tags" })
    --vim.keymap.set("n", "<leader>hs", ":Telescope harpoon marks<CR>", { desc = "Telescope help tags" })
    vim.keymap.set('n', '<leader>fs', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})

    require("telescope").setup({
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.6,
            results_width = 0.8,
          },

          width = function(_, max_columns, _)
            return math.min(max_columns, 110)
          end,
          height = function(_, _, max_lines)
            return math.min(max_lines, 40)
          end,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        --border = {},
        --borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        --set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        --buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        --mappings = {
        --  n = { ["q"] = require("telescope.actions").close },
        --},
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-c>"] = require("telescope.actions").close,
            ["<C-d>"] = require("telescope.actions").delete_buffer, -- Keymap to delete buffer in insert mode
          },
          n = {
            ["j"] = require("telescope.actions").move_selection_next,
            ["k"] = require("telescope.actions").move_selection_previous,
            ["<C-c>"] = require("telescope.actions").close,
            ["q"] = require("telescope.actions").close,
            ["<C-d>"] = require("telescope.actions").delete_buffer, -- Keymap to delete buffer in normal mode
          },
        },
      },

      extensions_list = { "themes", "terms" },
      extensions = {},
    })
  end,
}
