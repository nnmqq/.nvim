-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true,  -- do not show message
}

-- Function to map keys in a clearer and more flexible way
local function map(mode, key, result, optw)
  -- Set default options
  optw = optw or { noremap = true, silent = false, expr = false }

  -- Check that mode and key are not empty
  if mode and key then
    vim.keymap.set(mode, key, result, optw)
  else
    print("Error: mode or key is missing.")
  end
end
-- Set leader key
vim.g.mapleader = " "

-- Keybindings for nvim-tree
--vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>nf", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

-- Remap enter key to open Fine command line
vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>FineCmdline<CR>', { noremap = true })

-- open telescope themes
map("n", "<leader>th", ":Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme Switcher" })

-- open nvim config
map("n", "<leader>cn", ":Ex ~/.config/nvim/<CR>")

-- netwr i think was called
map("n", "<leader>fd", vim.cmd.Ex)

-- expand status bar that logs stuff idk
map('n', '<leader>m', ':messages<CR>', { noremap = true, silent = true })

-- remove trailing whitespaces
vim.api.nvim_create_user_command('Nows', function()
  vim.cmd("%s/\\s\\+$//e")
end, {
  desc = "Remove trailing whitespace"
})

map("n", "<Esc><Esc>", "<cmd>Nows<CR>")

-- clear highlights
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- save file
map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })

-- hard close window
map("n", "<leader>qq", ":NvimTreeClose<CR>:q!<CR>", { noremap = true, silent = true, expr = false })
-- hard close all windows
map("n", "<leader>qa", ":NvimTreeClose<CR>:qa!<CR>", { noremap = true, silent = true, expr = false })
-- Close current window
map("n", "<leader>wd", "<Cmd>:q<CR>", { noremap = true, silent = true, expr = false })

--Window
map("n", "<leader>ws", "<C-W>s", { desc = "Split Window Below", silent = true })
map("n", "<leader>ww", "<C-W>v", { desc = "Split Window Right", silent = true })


-- Keybindings for moving between tabs
map('n', '<leader>1', '1gt', { desc = "Go to tab 1" })
map('n', '<leader>2', '2gt', { desc = "Go to tab 2" })
map('n', '<leader>3', '3gt', { desc = "Go to tab 3" })
map('n', '<leader>4', '4gt', { desc = "Go to tab 4" })
map('n', '<leader>5', '5gt', { desc = "Go to tab 5" })
map('n', '<leader>6', '6gt', { desc = "Go to tab 6" })
map('n', '<leader>7', '7gt', { desc = "Go to tab 7" })
map('n', '<leader>8', '8gt', { desc = "Go to tab 8" })
map('n', '<leader>9', '9gt', { desc = "Go to tab 9" })

-- Next and previous tab navigation
map('n', '<leader>l', 'gt', { desc = "Next tab" })
map('n', '<leader>h', 'gT', { desc = "Previous tab" })

-- tab management
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = "New tab" })
vim.keymap.set('n', '<leader>td', ':tabclose<CR>', { desc = "Close tab" })
vim.keymap.set('n', '<leader>tl', ':tabs<CR>', { desc = "List tabs" })


-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
