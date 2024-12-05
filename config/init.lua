-- Base Neovim Config
require 'options'
require 'keymaps'
require 'autocmd'

listPlugins = function()
	for key, value in pairs(PluginsFromNix) do
		print( key .. '  |  ' .. value .. '\n' )
	end
end

-- Get Lazy configured and setup plugins
require('lazy').setup({
	spec = {
		{ import = 'plugins' }
	}
})
