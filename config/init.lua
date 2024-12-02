-- Neovim Config
require 'autocmd'
require 'options'
require 'keymaps'

-- Colorscheme
require 'plugins/catppuccin'

-- Plugins
require 'plugins/barbar'
require 'plugins/boole'
require 'plugins/flash'
require 'plugins/gitsigns'
require('image').setup()
require 'plugins/lualine'
-- require('neorg').setup()
require 'plugins/noice'
require 'plugins/nvim-cmp'
require 'plugins/nvim-lspconfig'
require 'plugins/obsidian'
require('render-markdown').setup({ file_types = {'markdown'} })
require 'plugins/sort'
require 'plugins/telescope'
require 'plugins/treesitter'
require 'plugins/which-key'

-- Mini Plugins
require('mini.ai').setup()
require('mini.comment').setup({ options = { ignore_blank_line = true } })
require('mini.cursorword').setup()
require('mini.hipatterns').setup() -- TODO: Configure
require('mini.indentscope').setup({ symbol = "▏" })
require('mini.jump').setup()
require('mini.pairs').setup()
require('mini.splitjoin').setup()
require('mini.surround').setup()
