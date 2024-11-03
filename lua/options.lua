vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- only one completion menu and manually selected
vim.opt.mouse = 'a'                                     -- allow the mouse to be used in Nvim
vim.opt.encoding = "utf-8"
vim.opt.signcolumn = "yes"                              -- Always show the sign column
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.spelllang = { "en" } --"en,es" english spanish spelling
vim.opt_global.spellsuggest = { "best", "9" } -- Show best nine spell checking candidates at most
-- When a word is CamelCased, assume "Cased" is a separate word: every upper-case character
-- in a word that comes after a lower case character indicates the start of a new word.
vim.opt.spelloptions = "camel"
vim.opt.showmatch = true -- Highlight matching brace
--When this option is set, the screen will not be redrawn while executing
--macros, registers and other commands that have not been typed
vim.opt.lazyredraw = false

-- UI config
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true     -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true     -- open new vertical split bottom
vim.opt.splitright = true     -- open new horizontal splits right
vim.t_Co = 256
--vim.opt.termguicolors = true
vim.opt_global.diffopt:append({ "vertical" }) -- make diff mode always open in vertical split

-- Tab shit
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.showtabline = 2
vim.opt.breakindent = true

---@diagnostic disable-next-line: deprecated
vim.api.nvim_set_option('fillchars', 'eob: ') -- empty lines actually empty instead of ~

vim.opt.undofile = true                       -- undo history iirc
vim.opt.undolevels = 10000

-- show invisibles
-- -- Unprintable chars mapping
-- -- {tab = "••"|">~",eol = "↴"|"¶"|"$", nbsp = "␣"|"%", space = "_"
vim.opt.listchars = { tab = "  ", trail = "·", extends = "»", precedes = "«", nbsp = "░" }
vim.opt.list = true


--Make a backup before overwriting a file.  The backup is removed after the file was successfully written
-- unless the 'backup' option is also on.
vim.opt.writebackup = true

--Make a backup before overwriting a file.  Leave it around after the file has been successfully written.
--this make sure you alway have a backup of a file around,meaning in cases where there is no swapfile
--to recover from you can use the backup file directly
vim.opt.backup = true

--List of directories for the backup file
vim.opt_global.backupdir = { "/tmp//" }

-- tells neovim how backups are done
vim.opt.backupcopy = "auto"

-- The extension to be used for vim backup files
vim.opt.backupext = ".vimbak"

-- enable saving unsaved/unwritten files in a *.swp file
vim.opt.swapfile = true
