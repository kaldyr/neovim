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
require 'plugins/lualine'
require 'plugins/noice'
require 'plugins/nvim-cmp'
require 'plugins/nvim-lspconfig'
require 'plugins/obsidian'
require('render-markdown').setup({ file_types = {'markdown'} })
require 'plugins/sort'
require 'plugins/telescope'
require('tiny-inline-diagnostic').setup()
require 'plugins/treesitter'
require 'plugins/which-key'

-- Mini Plugins
require('mini.cursorword').setup()
require('mini.hipatterns').setup({
	highlighters = {
		hex_color = require('mini.hipatterns').gen_highlighter.hex_color()
	}
})
require('mini.pairs').setup()
require('mini.splitjoin').setup()
