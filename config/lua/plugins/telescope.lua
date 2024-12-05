return {

	"telescope.nvim",
	dir = PluginsFromNix['telescope-nvim'],

	keys = {
		{ '<leader>f:', require('telescope.builtin').command_history, desc = 'Command History' },
		{ '<leader>fb', require('telescope.builtin').buffers, desc = 'Find Buffers' },
		{ '<leader>fc', require('telescope.builtin').commands, desc = 'Find Commands' },
		{ '<leader>fd', require('telescope.builtin').diagnostics, desc = 'Find Diagnostics' },
		{ '<leader>ff', require('telescope.builtin').find_files, desc = 'Find Files' },
		{ '<leader>fg', require('telescope.builtin').live_grep, desc = 'Find Grep' },
		{ '<leader>fh', require('telescope.builtin').help_tags, desc = 'Find Help' },
		{ '<leader>fH', require('telescope.builtin').highlights, desc = 'Find Highlights' },
		{ '<leader>fk', require('telescope.builtin').keymaps, desc = 'Find Keymaps' },
		{ '<leader>fm', require('telescope.builtin').marks, desc = 'Find Marks' },
		{ '<leader>fo', require('telescope.builtin').vim_options, desc = 'Find Options' },
		{ '<leader>fr', require('telescope.builtin').oldfiles, desc = 'Recent Files' },
		{ '<leader>fR', require('telescope.builtin').resume, desc = 'Resume' },
		{ '<leader>fG', require('telescope').extensions.git_file_history.git_file_history, desc = 'Git File History' },
	},

	opts = {
		extensions = {
			["ui-select"] = {
				require('telescope.themes').get_dropdown {}
			}
		},
	},

}
