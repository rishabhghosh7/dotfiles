return {
   "neovim/nvim-lspconfig",

   dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
   },

   config = function()
      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
         "force",
         {},
         vim.lsp.protocol.make_client_capabilities(),
         cmp_lsp.default_capabilities()
      )

      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      cmp.setup({
         mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
         }),
         sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
         })
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
         ensure_installed = {
            "lua_ls",
            "gopls",
         },
         handlers = {
            function(server_name) -- default handler (optional)
               require("lspconfig")[server_name].setup {
                  capabilities = capabilities
               }
            end,

            ["lua_ls"] = function()
               local lspconfig = require("lspconfig")
               lspconfig.lua_ls.setup {
                  capabilities = capabilities,
                  settings = {
                     Lua = {
                        runtime = { version = "Lua 5.1" },
                        diagnostics = {
                           globals = { "vim", "it", "describe", "before_each", "after_each" },
                        }
                     }
                  }
               }
            end
         }
      })


   end
}



