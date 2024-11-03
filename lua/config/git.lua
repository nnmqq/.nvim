require('gitsigns').setup {
  signs               = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged        = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn          = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl               = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl              = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff           = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir        = {
    follow_files = true
  },

  current_line_blame  = false,
  on_attach           = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>ghS', gs.stage_buffer)
    map('n', '<leader>gha', gs.stage_hunk)
    map('n', '<leader>ghu', gs.undo_stage_hunk)
    map('n', '<leader>ghR', gs.reset_buffer)
    map('n', '<leader>ghp', gs.preview_hunk)
    map('n', '<leader>ghb', function() gs.blame_line { full = true } end)
    map('n', '<leader>gtb', gs.toggle_current_line_blame)
    map('n', '<leader>ghd', gs.diffthis)
    map('n', '<leader>ghD', function() gs.diffthis('~') end)

    -- Text object
    map({ 'o', 'x' }, 'igh', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- This contains mainly Neogit but also a bunch of Git settings
-- like fetching branches with telescope or blaming with fugitive
local neogit = require('neogit')

vim.keymap.set("n", "<leader>gs", neogit.open,
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gP", ":Neogit pull<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gB", ":G blame<CR>",
  {silent = true, noremap = true}
)
