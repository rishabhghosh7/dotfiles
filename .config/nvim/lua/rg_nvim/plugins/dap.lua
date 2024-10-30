return {
   'mfussenegger/nvim-dap',
   dependencies = {
      'leoluz/nvim-dap-go',
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
   },
   config = function()
      require("dapui").setup()
      require('dap-go').setup()

      vim.keymap.set('n', '<leader>dt', require("dapui").toggle, {noremap=true})
      vim.keymap.set('n', '<leader>dr', "lua require('dapui').open({reset = true})", {noremap=true})
      vim.keymap.set('n', '<leader>db', ":DapToggleBreakpoint<CR>", {noremap=true})
      vim.keymap.set('n', '<leader>dc', ":DapContinue<CR>", {noremap=true})
   end
}
