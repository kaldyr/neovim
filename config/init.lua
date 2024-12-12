-- Clear the diagnostic warnings, this table is generated by flake.nix.
PluginsFromNix = PluginsFromNix or {}

require 'options'
require 'keymap'
require 'autocmd'

require('lazy').setup({
	performance = {
		rtp = {
			reset = false,
			disabled_plugins = {
				'gzip',
				'matchit',
				'netrw',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				-- 'tutor',
				'zipPlugin'
			},
		},
	},
	spec = { import = 'plugins' }
})
