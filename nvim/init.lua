vim.o.clipboard = 'unnamedplus'
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.swapfile = false
vim.o.signcolumn = 'auto:4'
vim.g.mapleader = ' '

vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/echasnovski/mini.deps' },
	{ src = 'https://github.com/catppuccin/nvim' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = 'https://github.com/coffebar/neovim-project' },
	{ src = 'https://github.com/Shatur/neovim-session-manager' },
	{ src = 'https://github.com/stevearc/conform.nvim' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	{ src = 'https://github.com/ThePrimeagen/harpoon',                   version = 'harpoon2' },
	{ src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' }
}

local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	}
})

local config_group = vim.api.nvim_create_augroup("SessionGroup", {})
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "SessionLoadPost",
	group = config_group,
	callback = function()
		require("harpoon")
	end,
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>j", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<M-q>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<M-w>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<M-e>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<M-r>", function() harpoon:list():select(4) end)

require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.extra').setup()
require('mini.surround').setup()
require('mason').setup()
require('oil').setup()
require('nvim-web-devicons').setup()
require('lualine').setup()
require('neovim-project').setup({
	projects = {
		'~/Projects/*',
		'~/.config/*',
		'~/.local/share/dotfiles',
	},
	picker = {
		type = 'telescope',
	}
})
require('conform').setup({
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})
require('gitsigns').setup({})
require('telescope').setup {
	defaults = {
		file_ignore_patterns = { '^.git/' }
	}
}
require('telescope').load_extension('ui-select')

local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', function() telescope.find_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>F', function() telescope.find_files({ hidden = true, no_ignore = true }) end, {})
vim.keymap.set('n', '<leader>g', function() telescope.live_grep({ additional_args = { '--hidden' } }) end, {})
vim.keymap.set('n', '<leader>G', function() telescope.live_grep({ additional_args = { '--hidden', '--no-ignore' } }) end,
	{})
vim.keymap.set('n', '<leader>b', '<CMD>Gitsigns blame<CR>', {})
vim.keymap.set('n', '<leader>h', telescope.help_tags, {})
vim.keymap.set('n', '<leader>d', telescope.diagnostics, {})
vim.keymap.set('n', '<leader>w', telescope.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>i', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', {})
vim.keymap.set('n', '<leader>m', '<CMD>Mason<CR>', {})
vim.keymap.set('n', '<leader>p', '<CMD>NeovimProjectHistory<CR>', {})
vim.keymap.set('n', 'gd', telescope.lsp_definitions, {})
vim.keymap.set('n', 'gD', telescope.lsp_references, {})

vim.lsp.enable({ 'gopls', 'pyright', 'lua_ls' })
vim.cmd.colorscheme('catppuccin')
vim.diagnostic.config({ virtual_text = true })
