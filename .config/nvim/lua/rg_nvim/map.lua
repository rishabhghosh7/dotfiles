-- [[ Setting Keymaps ]]

-- Navigation
vim.keymap.set("n", "<leader>f", vim.cmd.Ex) -- netrw
vim.keymap.set("n", "<Leader>b", ":buffers<CR>:buffer<Space>") -- quick peek buffers

-- Change dir to current buffer's (Thanks Reddit)
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>")
