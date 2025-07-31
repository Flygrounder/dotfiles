vim.o.clipboard = 'unnamedplus'
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.swapfile = false
vim.g.mapleader = ' '

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/echasnovski/mini.deps' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
}

require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.extra').setup()
require('mini.surround').setup()
require('mason').setup()
require('oil').setup()
require('nvim-web-devicons').setup()
require('lualine').setup()

local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', telescope.find_files, {})
vim.keymap.set('n', '<leader>F', function() telescope.find_files({ no_ignore = true }) end, {})
vim.keymap.set('n', '<leader>g', telescope.live_grep, {})
vim.keymap.set('n', '<leader>h', telescope.help_tags, {})
vim.keymap.set('n', '<leader>d', telescope.diagnostics, {})
vim.keymap.set('n', '<leader>i', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', {})
vim.keymap.set('n', '<leader>m', '<CMD>Mason<CR>', {})
vim.keymap.set('n', 'gd', telescope.lsp_definitions, {})
vim.keymap.set('n', 'gD', telescope.lsp_references, {})

vim.lsp.enable({ 'gopls', 'pyright' })
vim.cmd.colorscheme('catppuccin')
vim.diagnostic.config({ virtual_text = true })
