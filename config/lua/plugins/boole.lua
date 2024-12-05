return {

	"boole.nvim",
	dir = PluginsFromNix['boole-nvim'],

	opts = {

		allow_caps_additions = {
			{ 'true', 'false' },
			{ 'yes', 'no' },
		},

		mappings = {
			increment = '<C-a>',
			decrement = '<C-x>',
		},

	},

}
