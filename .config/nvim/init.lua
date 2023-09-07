-- What I want from NeoVim
-- ( ) Vim Set Options (Tabs etc)
-- ( ) Vim Native Keybinds
-- (-) Plugin Manager
-- (-) Tree Sitter (Syntax Highlighting)
-- (-) Commenter (Plugin)
-- (-) Hrshit Completion Engine?
-- (*) LSP (have full section later on)
-- (-) Colorscheme randomizer
-- ( ) Fuzzy Finder (find file, find word)
-- ( ) Mason LSP Config
-- ( ) Plugin Maps
-- ( ) Fold Functions
-- ( ) Scroll (Plugin)
-- ( ) Debugger (Plugin)
-- ( ) Bracket Completion (Maybe not worth it?)
-- ( ) Auto Code Format on Save (INBUILT IN VIM =)
--

--
-- Notes
--    
--    Some of the autocomplete doesn't work
--
--    No autocomplete for vim globals
--

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

function lazy.setup_with_plugins(plugins)
   -- you can "comment out" the line below after lazy.nvim is installed
   lazy.install(lazy.path)

   vim.opt.rtp:prepend(lazy.path)
   require('lazy').setup(plugins, lazy.opts)
end


lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

print('Enjoy Rishabh!')
lazy.setup_with_plugins({
   -- Tree Sitter
   {'nvim-treesitter/nvim-treesitter', config = true}, 

   -- Comment Engine
   {'numToStr/Comment.nvim', lazy = false}, 

   -- Snippet engine ( + needed for LSP, Cmp )
   {'L3MON4D3/LuaSnip'},                  

   -- Autocomplete engine
   {'hrsh7th/nvim-cmp'},                  
   -- Completion source for LSP
   {'hrsh7th/cmp-nvim-lsp'},              


   -- Themes
   -- {'morhetz/gruvbox'},
   -- {'sainnhe/everforest'},
   -- {'shaunsingh/nord.nvim'},

   -- LSP Configs from Neovim
   {'neovim/nvim-lspconfig'},
})

-- ========================== PLUGIN SETUPS ==============================

function cmp_setup()
   local cmp = require('cmp')
   local luasnip = require('luasnip')

   cmp.setup({
      sources = {
         {name = 'nvim_lsp'},
         {name = 'luasnip'},
         -- {name = 'buffer'},
      },
      mapping = cmp.mapping.preset.insert({
         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
         ['<C-f>'] = cmp.mapping.scroll_docs(4),
         ['<C-Space>'] = cmp.mapping.complete(),
         ['<C-e>'] = cmp.mapping.abort(),

         -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
         ['<CR>'] = cmp.mapping.confirm({ select = true }), 
      }),

      snippet = {
         expand = function(args)
            luasnip.lsp_expand(args.body)
         end
      }
   })
end
cmp_setup()

-- LIFESAVER
local function comment_setup()
   require("Comment").setup()
end
comment_setup()



local function lua_lsp_setup()
   require'lspconfig'.lua_ls.setup {
      on_init = function(client)
         local path = client.workspace_folders[1].name
         if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
               Lua = {
                  runtime = {
                     -- Tell the language server which version of Lua you're using
                     -- (most likely LuaJIT in the case of Neovim)
                     version = 'LuaJIT'
                  },
                  -- Make the server aware of Neovim runtime files
                  workspace = {
                     checkThirdParty = false,
                     library = {
                        vim.env.VIMRUNTIME
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                     }
                     -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                     -- library = vim.api.nvim_get_runtime_file("", true)
                  },
                  diagnostics = {
                     -- Get the language server to recognize the `vim` global
                     globals = {'vim'},
                  },
               }
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
         end
         return true
      end
   }
end
lua_lsp_setup()

local night_pallette = {
   "habamax",
   "lunaperche",
   "gruvbox",
   -- "everforest"
}

function ColorMyPencils()
   local themeCount = #night_pallette

   math.randomseed(os.time())
   local i = math.random(1, themeCount) -- replace w len

   local theme = night_pallette[i]
   vim.cmd.colorscheme(theme)
end



-- ========================== SETTING CHANGES ==============================

vim.opt.rnu = true

vim.opt.tabstop = 3
vim.opt.expandtab = true
vim.opt.shiftwidth = 3

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.cc = "80"

vim.opt.wrap = false
