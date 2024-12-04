return {

	PluginsFromNix['sort-nvim'],

	keys = {
		{ '<leader>s', ':Sort<CR>', mode = {'n', 'x'}, desc = 'Sort', silent = true },
	},

	opts = {},

}
