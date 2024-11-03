return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 20,
        side = "left",
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = " ",
            symlink = " ",
            folder = {
              default = " ",
              open = " ",
              empty = " ",
              empty_open = " ",
              symlink = " ",
            },
            git = {
              unstaged = "✗ ",
              staged = "✓ ",
              unmerged = " ",
              renamed = "➜ ",
              untracked = "★ ",
              deleted = " ",
              ignored = "◌",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
      },
      git = {
        enable = false,
        ignore = false,
        timeout = 500,
      },
      diagnostics = {
        enable = false,
        show_on_dirs = true,
        icons = {
          hint = " ",
          info = " ",
          warning = " ",
          error = " ",
        },
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
        },
      },
      system_open = {
        cmd = "open", -- Change to "xdg-open" on Linux
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = { "help" },
      },
      -- Define custom mappings with on_attach function
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Custom key mappings
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
        vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close Node"))
        vim.keymap.set("n", "<C-r>", api.tree.reload, opts("Refresh"))
        vim.keymap.set("n", "<C-n>", api.tree.toggle, opts("Toggle"))
        vim.keymap.set("n", "<leader>n", api.tree.find_file, opts("Find Current File"))
      end,
    })
  end,
}
