vim.o.clipboard = 'unnamedplus'
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.number = true

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/echasnovski/mini.deps' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/mason-org/mason.nvim' },
}

require('mini.completion').setup({})
require('mini.pairs').setup({})
require('mason').setup({})

vim.lsp.enable({'gopls', 'pyright'})
vim.cmd.colorscheme('catppuccin')
