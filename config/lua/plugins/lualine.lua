return {

	'nvim-lualine/lualine.nvim',
	dir = PluginsFromNix['lualine-nvim'],

	opts = {

		options = {
			show_filename_only = false,
			theme = 'catppuccin',
			component_separators = '',
			section_separators = { left = '', right = '' }
		},

		sections = {
			lualine_a = {
				{ 'mode', separator = { left = '' }, right_padding = 2 }
			},
			lualine_b = { 'branch', 'diff' },
			lualine_c = {
				{ 'filename', path = 1 },
			},
			lualine_x = {},
			lualine_y = { 'filetype' },
			lualine_z = {
				{ 'location', separator = { right = '' }, left_padding = 2 },
			}
		},

	},

}
