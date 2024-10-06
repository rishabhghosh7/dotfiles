-- -------------------------- OPTIONS -------------------------
vim.o.rnu = true -- Default to relative line numbering
vim.o.tabstop = 3
vim.o.shiftwidth = 3
vim.o.expandtab = true
vim.o.hlsearch = false -- Set highlight on search

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'a' -- Enable mouse mode

-- Save undo history in specified location
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Disable swapfiles
vim.o.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 300
vim.o.timeoutlen = 400

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set column line at 85 chars
vim.opt.cc = "85"

-- Don't wrap lines
vim.opt.wrap = false

-- Randomly pick a theme
--vim.keymap.set("n", "<leader>th", ColorMyPencils)

-- Set the cursor
vim.opt.guicursor = ""

-- Indent options
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Disable backups
vim.opt.backup = false

-- Red RNUs
-- vim.api.nvim_set_hl(0, 'LineNr', { fg = "LightGrey"})

vim.o.background="dark"
