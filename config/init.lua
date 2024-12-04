-- Neovim Config
require 'options'
require 'keymaps'
require 'autocmd'

local runtimePaths = vim.api.nvim_list_runtime_paths()
Plugins = {}
local i = 1;
local ignoreMatch = "vimplugin-treesitter-grammar"
while ( i <= #runtimePaths ) do
	local startPos = string.find( runtimePaths[i], "myNeovimPackages/start/" )
	if startPos ~= nil then
		local plugName = string.sub( runtimePaths[i], startPos + 23 )
		if string.sub( plugName, 1, string.len(ignoreMatch)) ~= ignoreMatch then
			Plugins[plugName] = runtimePaths[i]
		end
	end
	i = i + 1
end
print(Plugins["boole-nvim"])

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
