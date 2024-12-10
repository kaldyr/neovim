return {

	'nvim-treesitter/nvim-treesitter',
	dir = PluginsFromNix['nvim-treesitter'],
	main = 'nvim-treesitter.configs',

	dependencies = {
		{ 'nvim-treesitter-context', dir = PluginsFromNix['nvim-treesitter-context'], opts = {line_numbers = false} },
		{ 'nvim-treesitter-textobjects', dir = PluginsFromNix['nvim-treesitter-textobjects'] },
	},

	opts = {
		auto_install = false,
		parser_install_dir = PluginsFromNix['parsers'],
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<C-space>',
				node_incremental = '<C-space>',
				scope_incremental = false,
				node_decremental = '<BS>',
			},
		},
		textobjects = {
			move = {
				enable = true,
				goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
				goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
				goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
				goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
			},
		},
	},

}
