return {

	"sort.nvim",
	dir = PluginsFromNix['sort-nvim'],

	keys = {
		{ '<leader>s', ':Sort<CR>', mode = {'n', 'x'}, desc = 'Sort', silent = true },
	},

	opts = {},

}
