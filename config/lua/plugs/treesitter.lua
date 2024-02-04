require('nvim-treesitter.configs').setup {

	auto_install = false,
	ensure_installed = {},
	ignore_install = {},
	highlight = { enable = true },
	indent = { enable = true },
  sync_install = false,
	modules = {},

  autotag = {
    enable = true,
  },

	incremental_selection = {
		enable = true,
	},

	textobjects = {

		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},

		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['a='] = '@assignment.outer',
				['l='] = '@assignment.lhs',
				['r='] = '@assignment.rhs',
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
				['ai'] = '@conditional.outer',
				['ii'] = '@conditional.inner',
				['al'] = '@loop.outer',
				['il'] = '@loop.inner',
				['at'] = '@comment.outer',
			},
		},

		swap = {
			enable = true,
			swap_next = { ['<leader>a'] = '@parameter.inner', },
			swap_previous = { ['<leader>A'] = '@parameter.inner', },
		},

	},

}
