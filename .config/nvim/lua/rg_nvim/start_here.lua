-- Rishabh Ghosh, October 6 2024
-- Lazy (Plugins)
require("rg_nvim.lazy")
require("rg_nvim.settings")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local lsp_group = augroup('LspGroup', {})
local my_group = augroup('RgGroup', {})
autocmd('LspAttach', {
   group = lsp_group,
   callback = function()
      local bufmap = function(mode, lhs, rhs)
         vim.keymap.set(mode, lhs, rhs, { buffer = true })
      end

      bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
      bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
      bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
      bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
      bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
      bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
      bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
      bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
      bufmap({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
      bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
      bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
      bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

      bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
      bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

      -- if using Neovim v0.8 uncomment this
      -- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
   end

   -- Prime's keymaps
   -- callback = function(e)
   --     local opts = { buffer = e.buf }
   --     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
   --     vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
   --     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
   --     vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
   --     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
   --     vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
   --     vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
   --     vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
   --     vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
   --     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
   --     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
   -- end
})
function AutoDarkColors()
   local hour = os.date("*t").hour
   if hour >= 18 or hour < 7 then
      vim.opt.background = "dark"
   else
      vim.opt.background = "light"
   end
end

AutoDarkColors()

-- LSP Format on Buffer Write
autocmd("LspAttach", {
   group = lsp_group,
   callback = function(args)
      autocmd("BufWritePre", {
         buffer = args.buf,
         callback = function()
            vim.lsp.buf.format { async = false, id = args.data.client_id }
         end,
      })
   end
})

-- Save and Load folds
autocmd({ "BufWinLeave" }, {
   group = my_group,
   pattern = { "*.*" },
   desc = "save view (folds), when closing file",
   command = "mkview",
})
autocmd({ "BufWinEnter" }, {
   group = my_group,
   pattern = { "*.*" },
   desc = "load view (folds), when opening file",
   command = "silent! loadview"
})
