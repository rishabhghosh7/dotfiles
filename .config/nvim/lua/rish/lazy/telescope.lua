return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
      "smartpde/telescope-recent-files"
	},

	config = function()
		require('telescope').setup({})
      require("telescope").load_extension("recent_files")

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<C-p>fg', builtin.git_files, {})
		vim.keymap.set('n', '<leader>pws', function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set('n', '<leader>pWs', function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

      vim.keymap.set("n", "<Leader>rf",
         [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
         {noremap = true, silent = true})
	end
}

