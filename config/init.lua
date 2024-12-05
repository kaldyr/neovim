-- Base Neovim Config
require 'options'
require 'keymaps'
require 'autocmd'

PluginsFromNix = {}
-- Extract the runtime path into a key value table of plugins installed through nix.
-- You can reference the directory a plugin is installed into by:
--   PluginsFromNix['PluginName']
-- Where PluginName is from the flake.nix input section with the following format:
--   plugin_PluginName = { url = "github:owner/repo"; flake = false; };
-- This is used to have Lazy.nvim configure and load plugins without managing them.
local runtimePaths = vim.api.nvim_list_runtime_paths()
local matchInPath = "myNeovimPackages/start/"
local ignoreMatch = "vimplugin-treesitter-grammar"
local i = 1;
while ( i <= #runtimePaths ) do
	local startPos = string.find( runtimePaths[i], matchInPath )
	if startPos ~= nil then
		local plugName = string.sub( runtimePaths[i], startPos + string.len(matchInPath) )
		if string.sub( plugName, 1, string.len(ignoreMatch)) ~= ignoreMatch then
			PluginsFromNix[plugName] = runtimePaths[i]
		end
	end
	i = i + 1
end

-- Get Lazy configured and started
require('lazy').setup({
	spec = {
		{ import = 'plugins' }
	}
})
