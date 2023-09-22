-- https://github.com/VonHeikemen/nvim-starter/tree/xx-mason
--

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
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	{'neovim/nvim-lspconfig'},             -- LSP configurations
	{                                      -- Installer for external tools
	'williamboman/mason.nvim',
	build = function()
		pcall(vim.cmd, 'MasonUpdate')
    end,},
    {'williamboman/mason-lspconfig.nvim'}, -- mason extension for lspconfig
    {'hrsh7th/nvim-cmp'},                  -- Autocomplete engine
    {'hrsh7th/cmp-nvim-lsp'},              -- Completion source for LSP
    {'L3MON4D3/LuaSnip'},                  -- Snippet engine


    -- Rishabh Plugins
    {'karb94/neoscroll.nvim'},             -- Smooth Scroll
    {'mbbill/undotree'},			         -- Undo Tree
    {'nvim-lualine/lualine.nvim'},         -- Status Line
    {'nvim-tree/nvim-tree.lua'},           -- File Tree
    {'itchyny/lightline.vim'},             -- Light Line


-- Telescope for fuzzy finding
{
	'nvim-telescope/telescope.nvim', tag = '0.1.1',
	dependencies = { 'nvim-lua/plenary.nvim' }
},

-- Treesitter for highlight
{'nvim-treesitter/nvim-treesitter',
config = function()
	pcall(vim.cmd, 'TSUpdate')
end,
	  }


  })

  vim.cmd.colorscheme('habamax')

  local cmp = require('cmp')
  local luasnip = require('luasnip')


  cmp.setup({
	  sources = {
		  {name = 'nvim_lsp'},
	  },
	  mapping = cmp.mapping.preset.insert({
		  ['<C-Space>'] = cmp.mapping.complete(),
		  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
		  ['<C-d>'] = cmp.mapping.scroll_docs(4),
	  }),
	  snippet = {
		  expand = function(args)
			  luasnip.lsp_expand(args.body)
		  end
	  },
  })

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

  local lspconfig = require('lspconfig')
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
  )

  require('mason').setup({})
  require('mason-lspconfig').setup({
	  ensure_installed = {
		  'gopls',
		  'bzl',
		  'lua_ls'

	  }
  })

  require('mason-lspconfig').setup_handlers({
	  function(server)
		  lspconfig[server].setup({})
	  end,
	  ['tsserver'] = function()
		  lspconfig.tsserver.setup({
			  settings = {
				  completions = {
					  completeFunctionCalls = true
				  }
			  }
		  })
	  end
  })


  -- My config starts here
  -- require('rish.remap')
  -- require('rish.set')
  require('rish')


  require('rish/plugin.neoscroll')
  require('rish/plugin.telescope')
  require('rish/plugin.undotree')
  require('rish/plugin.lightline')
  require('rish/plugin.nvim-tree')


  require'lspconfig'.pyright.setup{}





