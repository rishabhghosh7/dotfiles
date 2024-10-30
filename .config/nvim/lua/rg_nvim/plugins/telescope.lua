return {
   'nvim-telescope/telescope.nvim',
   tag = '0.1.8',
   dependencies = { "nvim-tree/nvim-web-devicons", 'nvim-lua/plenary.nvim' },
   config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope buffers' })
   end
}
