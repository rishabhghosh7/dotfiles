return {
	-- "Shatur/neovim-ayu",
   'sainnhe/everforest',
	dependencies = { 
      -- More Themes
      "Shatur/neovim-ayu",
      {'morhetz/gruvbox'},
      {'rose-pine/neovim', name = 'rose-pine'},
      { "catppuccin/nvim", name = "catppuccin"},

      -- Smooth Scroll
      "cskeeters/vim-smooth-scroll",

      -- Commenter
      { 
         "numToStr/Comment.nvim",
         config = function()
            require("Comment").setup()
         end
      },
   },
	config = function()
		vim.cmd.colorscheme("everforest")
	end
}
