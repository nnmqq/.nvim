local kanagawa_paper = require("lualine.themes.kanagawa-paper")

require('kanagawa-paper').setup({
  undercurl = true,
  transparent = true,
  gutter = false,
  dimInactive = false, -- disabled when transparent
  terminalColors = true,
  commentStyle = { italic = true },
  functionStyle = { italic = false },
  keywordStyle = { italic = false, bold = false },
  statementStyle = { italic = false, bold = false },
  typeStyle = { italic = false },
  colors = { theme = {}, palette = {} }, -- override default palette and theme colors
  overrides = function()                 -- override highlight groups
    return {}
  end,
})

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = kanagawa_paper, -- Change to any theme, e.g., "tokyonight", "dracula", or "onedark"
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "packer", "DAP" },
    always_divide_middle = true,
    globalstatus = true, -- Use a global statusline across splits
  },
  sections = {
    -- Left side
    lualine_a = {
      { "mode", upper = true },
    },
    lualine_b = {
      {
        "branch",
        icon = "", -- Git branch icon
      },
      {
        "diff",
        symbols = { added = " ", modified = "柳", removed = " " },
        colored = true,
        source = nil, -- Requires 'gitsigns.nvim' to work
      },
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
      {
        "filename",
        file_status = true, -- Show file status (readonly, modified, etc.)
        path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
        symbols = { modified = "[+]", readonly = "", unnamed = "[No Name]" },
      },
    },
    -- Right side
    lualine_x = {
      { "encoding" },
      { "fileformat", symbols = { unix = "", dos = "", mac = "" } },
      { "filetype", colored = true, icon_only = true },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {}, -- Leave empty or add custom tabs if needed
  extensions = { "fugitive", "quickfix", "nvim-tree" },
})



local colors = require("kanagawa-paper.colors").setup()
local palette_colors = colors.palette

local theme = {
  fill = { bg = palette_colors.sumiInk0, fg = palette_colors.katanaGray },
  head = { bg = palette_colors.oniViolet, fg = palette_colors.sumiInk0, style = "bold" },
  current_tab = { bg = palette_colors.sumiInk3, fg = palette_colors.fujiWhite, style = "bold" },
  tab = { bg = palette_colors.sumiInk1, fg = palette_colors.fujiGray },
  win = { bg = palette_colors.sumiInk3, fg = palette_colors.fujiWhite },
  tail = { bg = palette_colors.sakuraPink, fg = palette_colors.sumiInk0 },
}

local excluded_filetypes = { "dap-repl", "NvimTree", "neo-tree", "dapui_scopes", "dapui_stacks", "dapui_watches",
  "dapui_breakpoints" }

require('tabby').setup({
  line = function(line)
    return {
      {
        { '  ', hl = theme.head },
        line.sep('', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep('', hl, theme.fill),
          tab.is_current() and '' or '󰆣',
          tab.number(),
          --tab.name(),
          tab.close_btn(''),
          line.sep('', hl, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        ---@diagnostic disable-next-line: deprecated
        local buf_ft = vim.api.nvim_buf_get_option(win.buf().id, "filetype")
        if vim.tbl_contains(excluded_filetypes, buf_ft) then
          return nil
        end
        return {
          line.sep('', theme.win, theme.fill),
          win.is_current() and '' or '',
          win.buf_name(),
          line.sep('', theme.win, theme.fill),
          hl = theme.win,
          margin = ' ',
        }
      end),
      {
        line.sep('', theme.tail, theme.fill),
        { '  ', hl = theme.tail },
      },
      hl = theme.fill,
    }
  end,
  -- option = {}, -- setup modules' option,
})

local highlight = {
  "def",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "def", { fg = "#515152" })
end)

-- makes {[]} be the color set in hightlight
--vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup {
  scope = { enabled = false },
  indent = { highlight = highlight },
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
