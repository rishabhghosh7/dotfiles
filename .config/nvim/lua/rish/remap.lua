vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- quick peek / change buffer
-- vim.keymap.set("n", "<Leader>b", ":buffers<CR>:buffer<Space>")
vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>")

vim.keymap.set("i", "<C-5>", "<Esc>")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- :tnoremap <Esc> <C-\><C-n>

vim.keymap.set("n", "<leader>t", "<cmd>Telescope<CR>")

-- telescope-dap
vim.keymap.set('n', '<leader>dcc', '<CMD>Telescope dap commands<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>dcf', '<CMD>Telescope dap configurations<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>dl', '<CMD>Telescope dap list_breakpoints<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>dv', '<CMD>Telescope dap variables<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>df', '<CMD>Telescope dap frames<CR>', {noremap=true, silent=true})

-- dap
vim.keymap.set('n', '<leader>bp', '<CMD>DapToggleBreakpoint<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>ds', '<CMD>DapTerminate<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>dt', '<CMD>DapTerminate<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>db', '<CMD>DapContinue<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>du', '<CMD>lua require("dapui").toggle()<CR>', {noremap=true, silent=true})

-- quick tab in / out (useful for help pages)
vim.keymap.set('n', 't.', ':tabedit %<CR>')
vim.keymap.set('n', 'tc', ':tabclose<CR>')

-- theme night/day
vim.keymap.set('n', '<leader>thd', ':set background=light<CR>')
vim.keymap.set('n', '<leader>thn', ':set background=dark<CR>')
