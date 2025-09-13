vim.o.clipboard = 'unnamedplus'
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.swapfile = false
vim.g.mapleader = ' '

vim.pack.add {
	{ src = 'https://github.com/nvim-mini/mini.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/catppuccin/nvim' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/ThePrimeagen/harpoon',                   version = 'harpoon2' },
	{ src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
}

local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	}
})
require('catppuccin').setup({
	highlight_overrides = {
		mocha = function(mocha)
			return {
				LineNr = { fg = mocha.subtext1 }
			}
		end,
	},
})
require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.files').setup()
require('mini.extra').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.icons').setup()
require('mason').setup()
require("mason-lspconfig").setup()
require('telescope').setup {
	defaults = {
		file_ignore_patterns = { '/.git/', '^.git/' },
		path_display = { "smart" },
	}
}
require('telescope').load_extension('ui-select')

local telescope = require('telescope.builtin')

vim.keymap.set("n", "<leader>k", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>j", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<M-q>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<M-w>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<M-e>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<M-r>", function() harpoon:list():select(4) end)
vim.keymap.set('n', '<leader>f', function() telescope.find_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>F', function() telescope.find_files({ hidden = true, no_ignore = true }) end, {})
vim.keymap.set('n', '<leader>g', function() telescope.live_grep({ additional_args = { '--hidden' } }) end, {})
vim.keymap.set('n', '<leader>G', function() telescope.live_grep({ additional_args = { '--hidden', '--no-ignore' } }) end,
	{})
vim.keymap.set('n', '<leader>h', telescope.help_tags, {})
vim.keymap.set('n', '<leader>d', telescope.diagnostics, {})
vim.keymap.set('n', '<leader>w', telescope.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>u', telescope.buffers, {})
vim.keymap.set('n', '<leader>o', require('mini.files').open, {})
vim.keymap.set('n', '<leader>m', '<CMD>Mason<CR>', {})
vim.keymap.set('n', '<leader>i', vim.lsp.buf.format, {})
vim.keymap.set('n', 'gd', telescope.lsp_definitions, {})
vim.keymap.set('n', 'gD', telescope.lsp_references, {})
vim.keymap.set('n', '<M-d>', vim.diagnostic.open_float, {})
vim.keymap.set('n', '<M-f>', function()
	local path = vim.fn.expand('%:.')
	vim.fn.setreg('+', path)
	print(path)
end, {})

vim.cmd.colorscheme('catppuccin-mocha')
