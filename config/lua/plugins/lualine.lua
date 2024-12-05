return {

	"lualine.nvim",
	dir = PluginsFromNix['lualine-nvim'],

	opts = {

		options = {
			show_filename_only = false,
			theme = 'catppuccin',
		},

		sections = {
			lualine_c = {
				{ 'filename', path = 1 },
			},
		},

	},

}
