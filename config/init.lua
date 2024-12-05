-- Base Neovim Config
require 'options'
require 'keymaps'
require 'autocmd'

-- Get Lazy configured and setup plugins
require('lazy').setup({
	spec = {
		{ import = 'plugins' }
	}
})
