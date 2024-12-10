return {

	'folke/flash.nvim',
	dir = PluginsFromNix['flash-nvim'],

	event = 'VeryLazy',

	keys = {
		{ 'S', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' }
	},

	opts = {},

}
