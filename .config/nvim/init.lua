-- What I want from NeoVim
-- (-) Vim Set Options (Tabs etc)
-- ( ) Vim Native Keybinds
-- (-) Plugin Manager
-- (-) Tree Sitter (Syntax Highlighting)
-- (-) Commenter (Plugin)
-- (-) Hrshit Completion Engine?
-- (*) LSP (have full section later on)
-- (-) Colorscheme randomizer
-- (-) Bracket Completion (Maybe not worth it?)
-- ( ) Fuzzy Finder (find file, find word)
-- ( ) Mason LSP Config
-- ( ) Plugin Maps
-- ( ) Fold Functions
-- ( ) Scroll (Plugin)
-- ( ) Debugger (Plugin)
-- ( ) Auto Code Format on Save (INBUILT IN VIM =)
--

--
-- Notes
--    
--
--

--
-- TODO 
--    
--    Put plugin setups in after/ dir
--
--    Define mappings for LSP
--    - Windows
--
--    Add fuzzy finding / dir traversal support
--
--    Get a functional python environment (LSP)
--    - Basic Lang (X)
--    - Jupyter Env (@TODO : magma in mind)
--
--    Get a functional go environment (LSP)
--    - Basic Lang (X)
--    - Protobuf support
--
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

-- ================== SETUP PLUGINS ======================

local pluginStore = {
   -- Smooth Scroll
   {'karb94/neoscroll.nvim'},

   -- Tree Sitter
   {'nvim-treesitter/nvim-treesitter', config = true},

   -- Comment Engine (LIFESAVER)
   {'numToStr/Comment.nvim', lazy = false},
   -- AC brackets -> save me that 1 extra keystroke
   {'jiangmiao/auto-pairs'},

   -- Snippet engine ( + needed for LSP, Cmp )
   {'L3MON4D3/LuaSnip'},

   -- Autocomplete engine
   {'hrsh7th/nvim-cmp'},
   -- Completion sources for LSP
   {'hrsh7th/cmp-nvim-lsp'},
   {'hrsh7th/cmp-buffer'},
   {'hrsh7th/cmp-path'},
   {'hrsh7th/cmp-cmdline'},
   {'saadparwaiz1/cmp_luasnip'},

   -- Mason (Really good)
   {
      'williamboman/mason.nvim',
      build = function()
	 pcall(vim.cmd, 'MasonUpdate')
      end,
   },
   {'williamboman/mason-lspconfig.nvim'}, -- mason extension for lspconfig

   -- Themes
   {'morhetz/gruvbox'},
   {'sainnhe/everforest'},
   {'shaunsingh/nord.nvim'},
   {'rose-pine/neovim', name = 'rose-pine'},
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

   -- LSP Configs from Neovim
   {'neovim/nvim-lspconfig'},

   -- Helpful pending keybinds display
   {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
	 vim.o.timeout = true
	 vim.o.timeoutlen = 300
      end,
   },

   -- Detect tabstop and shiftwidth automatically
   {'tpope/vim-sleuth'},
   {
      -- Adds git related signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      opts = {
	 -- See `:help gitsigns.txt`
	 signs = {
	    add = { text = '+' },
	    change = { text = '~' },
	    delete = { text = '_' },
	    topdelete = { text = '‾' },
	    changedelete = { text = '~' },
	 },
	 on_attach = function(bufnr)
	    vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

	    -- don't override the built-in and fugitive keymaps
	    local gs = package.loaded.gitsigns
	    vim.keymap.set({ 'n', 'v' }, ']c', function()
	       if vim.wo.diff then
		  return ']c'
	       end
	       vim.schedule(function()
		  gs.next_hunk()
	       end)
	       return '<Ignore>'
	    end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
	    vim.keymap.set({ 'n', 'v' }, '[c', function()
	       if vim.wo.diff then
		  return '[c'
	       end
	       vim.schedule(function()
		  gs.prev_hunk()
	       end)
	       return '<Ignore>'
	    end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
	 end,
      },
   },
}
local night_pallette = {
   -- General Classic
   -- "gruvbox",

   "rose-pine",

   -- Extreme Night Mode
   "habamax",

   -- Black BG, comment highlight
   -- "lunaperche",

   -- Pleasant Gruvbox Cousin
   "everforest",

   -- Classic Bleu De Chanel theme
   -- "nord",

   -- Neo VSCode colors
   "catppuccin",
}

function ColorMyPencils()
   math.randomseed(os.time())
   local themeCount = #night_pallette
   local i = math.random(1, themeCount)

   local theme = night_pallette[i]
   vim.cmd.colorscheme(theme)
end

lazy.setup_with_plugins({
   pluginStore
})

-- ========================== PLUGIN SETUPS ==============================

local function cmp_setup()
   local cmp = require('cmp')
   local luasnip = require('luasnip')

   cmp.setup({
      sources = {
	 {name = 'nvim_lsp'},
	 {name = 'luasnip'},
	 {name = 'buffer'},
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
      },


      window = {
	 completion = cmp.config.window.bordered(),
	 -- documentation = cmp.config.window.bordered(),
      },
   })
end
cmp_setup()


-- Kept a fancy cmp just for fun

-- local function cmp_setup_2()
--    -- Set up nvim-cmp.
--    local cmp = require'cmp'
--
--    cmp.setup({
--       snippet = {
--          -- REQUIRED - you must specify a snippet engine
--          expand = function(args)
--             -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--             -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--             -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--          end,
--       },
--       window = {
--          -- completion = cmp.config.window.bordered(),
--          -- documentation = cmp.config.window.bordered(),
--       },
--       mapping = cmp.mapping.preset.insert({
--          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--          ['<C-f>'] = cmp.mapping.scroll_docs(4),
--          ['<C-Space>'] = cmp.mapping.complete(),
--          ['<C-e>'] = cmp.mapping.abort(),
--          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--       }),
--       sources = cmp.config.sources({
--          { name = 'nvim_lsp' },
--          { name = 'vsnip' }, -- For vsnip users.
--          { name = 'luasnip' }, -- For luasnip users.
--          -- { name = 'ultisnips' }, -- For ultisnips users.
--          -- { name = 'snippy' }, -- For snippy users.
--       }, {
--          { name = 'buffer' },
--       })
--    })
--
--    -- Set configuration for specific filetype.
--    cmp.setup.filetype('gitcommit', {
--       sources = cmp.config.sources({
--          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--       }, {
--          { name = 'buffer' },
--       })
--    })
--
--    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--    cmp.setup.cmdline({ '/', '?' }, {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = {
--          { name = 'buffer' }
--       }
--    })
--
--    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--    cmp.setup.cmdline(':', {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--          { name = 'path' }
--       }, {
--          { name = 'cmdline' }
--       })
--    })
--
--    -- Set up lspconfig.
--    local capabilities = require('cmp_nvim_lsp').default_capabilities()
--    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--    require('lspconfig')['lua_ls'].setup {
--       capabilities = capabilities
--    }
-- end
-- cmp_setup_2()

local function comment_setup()
   require("Comment").setup()
end
comment_setup()

local function neoscroll_setup()
   require('neoscroll').setup()
end
neoscroll_setup()

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

local function mason_setup()
   require('mason').setup({})
   require('mason-lspconfig').setup({
      ensure_installed = {
	 'gopls',
	 'lua_ls',
      }
   })
end
mason_setup()

local function go_lsp_setup()
   require'lspconfig'.gopls.setup{}
end
go_lsp_setup()

local function python_lsp_setup()
   require'lspconfig'.pyright.setup{}
end
python_lsp_setup()


local function lsp_remaps_setup()

   local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})
   vim.api.nvim_create_autocmd('LspAttach', {
      group = lsp_cmds,
      desc = 'LSP actions',
      callback = function()
	 local bufmap = function(mode, lhs, rhs)
	    vim.keymap.set(mode, lhs, rhs, {buffer = true})
	 end

	 bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
	 bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
	 bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
	 bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
	 bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
	 bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
	 bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	 bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
	 bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
	 bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
	 bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
	 bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

	 bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
	 bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

	 -- if using Neovim v0.8 uncomment this
	 -- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
      end
   })

end
lsp_remaps_setup()

-- rose pine setup
local function rose_pine_setup()
   require('rose-pine').setup({ -- copied directly from theme's GH
   --- @usage 'auto'|'main'|'moon'|'dawn'
   variant = 'moon',
   --- @usage 'main'|'moon'|'dawn'
   dark_variant = 'moon',
   bold_vert_split = false,
   dim_nc_background = false,
   disable_background = false,
   disable_float_background = false,
   disable_italics = false,

   --- @usage string hex value or named color from rosepinetheme.com/palette
   groups = {
      background = 'base',
      background_nc = '_experimental_nc',
      panel = 'surface',
      panel_nc = 'base',
      border = 'highlight_med',
      comment = 'muted',
      link = 'iris',
      punctuation = 'subtle',

      error = 'love',
      hint = 'iris',
      info = 'foam',
      warn = 'gold',

      headings = {
	 h1 = 'iris',
	 h2 = 'foam',
	 h3 = 'rose',
	 h4 = 'gold',
	 h5 = 'pine',
	 h6 = 'foam',
      }
      -- or set all headings at once
      -- headings = 'subtle'
   },

   -- Change specific vim highlight groups
   -- https://github.com/rose-pine/neovim/wiki/Recipes
   highlight_groups = {
      ColorColumn = { bg = 'rose' },

      -- Blend colours against the "base" background
      CursorLine = { bg = 'foam', blend = 10 },
      StatusLine = { fg = 'love', bg = 'love', blend = 10 },

      -- By default each group adds to the existing config.
      -- If you only want to set what is written in this config exactly,
      -- you can set the inherit option:
      Search = { bg = 'gold', inherit = false },
   }
})
end
rose_pine_setup()

local function catppuccin_setup()
   local catppuccin = require("catppuccin")

   catppuccin.setup({
      integrations = {
	 ts_rainbow = true,
      },
      color_overrides = {
	 mocha = {
	    text = "#F4CDE9",
	    subtext1 = "#DEBAD4",
	    subtext0 = "#C8A6BE",
	    overlay2 = "#B293A8",
	    overlay1 = "#9C7F92",
	    overlay0 = "#866C7D",
	    surface2 = "#705867",
	    surface1 = "#5A4551",
	    surface0 = "#44313B",

	    base = "#352939",
	    mantle = "#211924",
	    crust = "#1a1016",
	 },
      },
   })
end
catppuccin_setup()

-- ========================== SETTING CHANGES ==============================

vim.cmd(':colorscheme gruvbox')

-- Default to relative line numbering
vim.opt.rnu = true

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 300
vim.o.timeoutlen = 400

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set column line at 85 chars
vim.opt.cc = "85"

-- Don't wrap lines
vim.opt.wrap = false

-- Randomly pick a theme
vim.keymap.set("n", "<leader>th", ColorMyPencils)

-- [[ Setting Keymaps ]]

-- quick change buffers
vim.keymap.set("n", "<Leader>b", ":buffers<CR>:buffer<Space>")
vim.keymap.set("n", "<C-b>", ":buffers<CR>")

-- replace word and repeat '.' (case insensitive)
vim.keymap.set("n", "c*", "*``cgn")
-- vim.keymap.set("n", "c#", "/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
   callback = function()
      vim.highlight.on_yank()
   end,
   group = highlight_group,
   pattern = '*',
})
