-- Neovim Config
require 'options'
require 'keymaps'
require 'autocmd'

-- LSP Configuration
require('plugins.nvim-lspconfig')

-- Treesitter
require('plugins.treesitter')

-- Plugins
require('mini.ai').setup()
require('mini.bracketed').setup()
require('mini.clue').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.doc').setup()
require('mini.extra').setup()
require('mini.fuzzy').setup()
require('mini.git').setup()
require('mini.hipatterns').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()
require('mini.jump').setup()
require('mini.jump2d').setup()
require('mini.move').setup()
require('mini.notify').setup()
require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.splitjoin').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.git').setup()
