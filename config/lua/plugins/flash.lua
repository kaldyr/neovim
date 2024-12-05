return {

	"flash.nvim",
	dir = PluginsFromNix['flash-nvim'],

	keys = {
		{ 'S', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' }
	},

	opts = {},

}
