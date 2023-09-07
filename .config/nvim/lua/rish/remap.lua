vim.g.mapleader = " "

-- File Explorer
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeOpen)

-- Remaps I got from MPaulson aka Primegean
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")


-- Change dir to current buffer (Thanks Reddit)
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>")

-- Quick Redo
vim.keymap.set("n", "U", "<C-r>")

-- Quick Write, Force-Write and Exit
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q!<CR>")
vim.keymap.set("n", "<leader>z", ":wq!<CR>")
vim.keymap.set("n", "<leader>qq", ":qa!<CR>")
