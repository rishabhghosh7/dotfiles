-- What I want from NeoVim
-- Vim Options
-- Vim Native Keybinds
-- 0. Colorscheme
-- 1. Scroll (Plugin)
-- 2. Plugin Manager
-- 2a. Fuzzy Finder (find file, find word)
-- 3. LSP
-- 3a. Hrshit Completion Engine?
-- 3b. Mason LSP Config
-- 4. Commenter (Plugin)
-- 5. Auto Indenting 
-- 6. Maps


vim.g.mapleader = " "

-- Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
