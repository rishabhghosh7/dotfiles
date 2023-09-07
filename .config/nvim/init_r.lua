-- What I want from NeoVim
-- Vim Set Options (Tabs etc)
-- Vim Native Keybinds
-- Plugin Manager
-- Tree Sitter (Syntax Highlighting)
-- Commenter (Plugin)
-- Bracket Completion
-- Fuzzy Finder (find file, find word)
-- LSP
-- Hrshit Completion Engine?
-- Mason LSP Config
-- Auto Code Format on Save
-- Maps
-- Fold Functions
-- Random Colorscheme Everytime
-- Scroll (Plugin)

vim.g.mapleader = " " -- set map leader before plugin setup

local lazy = {}
function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- you can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

print('Enjoy Rishabh!')
lazy.setup({
  {'nvim-treesitter/nvim-treesitter', config = true}, -- Tree Sitter
  {'numToStr/Comment.nvim', lazy = false}, -- Comment Engine
})

require("Comment").setup()
