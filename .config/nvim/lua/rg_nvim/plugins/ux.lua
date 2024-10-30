return {
   -- "Shatur/neovim-ayu",
   'sainnhe/everforest',
   dependencies = {
      -- More Themes
      "Shatur/neovim-ayu",
      { 'morhetz/gruvbox' },
      { 'rose-pine/neovim', name = 'rose-pine' },
      { "catppuccin/nvim",  name = "catppuccin" },

      -- Smooth Scroll
      "cskeeters/vim-smooth-scroll",

      -- Commenter
      {
         "numToStr/Comment.nvim",
         config = function() require("Comment").setup() end
      },

      -- Command Line
      "folke/noice.nvim",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
   },
   config = function()
      vim.cmd.colorscheme("everforest")

      require("noice").setup()
   end
}
