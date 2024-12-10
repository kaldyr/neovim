return {

	'folke/which-key.nvim',
	dir = PluginsFromNix['which-key-nvim'],

	event = 'VeryLazy',

	keys = {
		{
			'<leader>?',
			function()
				require('which-key').show({ global = false })
			end,
			desc = 'Buffer Local Keymaps (which-key)',
		},
	},

	opts = {},

}
