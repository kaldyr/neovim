return {

	"nvim-treesitter",
	dir = PluginsFromNix['nvim-treesitter'],

	keys = {
		{ ';', require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move, mode = { 'n', 'x', 'o' } },
		{ ',', require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_opposite, mode = { 'n', 'x', 'o' } },
		{ 'f', require('nvim-treesitter.textobjects.repeatable_move').builtin_f, mode = { 'n', 'x', 'o' } },
		{ 'F', require('nvim-treesitter.textobjects.repeatable_move').builtin_F, mode = { 'n', 'x', 'o' } },
		{ 't', require('nvim-treesitter.textobjects.repeatable_move').builtin_t, mode = { 'n', 'x', 'o' } },
		{ 'T', require('nvim-treesitter.textobjects.repeatable_move').builtin_T, mode = { 'n', 'x', 'o' } },
	},

	opts = {

		auto_install = false,
		ensure_installed = {},
		ignore_install = {},
		highlight = { enable = true },
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
					[']f'] = { query = '@call.outer', desc = 'Next function call start' },
					[']m'] = { query = '@function.outer', desc = 'Next method/function def start' },
					[']c'] = { query = '@class.outer', desc = 'Next class start' },
					[']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
					[']l'] = { query = '@loop.outer', desc = 'Next loop start' },
					[']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
					[']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
				},
				goto_next_end = {
					[']F'] = { query = '@call.outer', desc = 'Next function call end' },
					[']M'] = { query = '@function.outer', desc = 'Next method/function def end' },
					[']C'] = { query = '@class.outer', desc = 'Next class end' },
					[']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
					[']L'] = { query = '@loop.outer', desc = 'Next loop end' },
				},
				goto_previous_start = {
					['[f'] = { query = '@call.outer', desc = 'Prev function call start' },
					['[m'] = { query = '@function.outer', desc = 'Prev method/function def start' },
					['[c'] = { query = '@class.outer', desc = 'Prev class start' },
					['[i'] = { query = '@conditional.outer', desc = 'Prev conditional start' },
					['[l'] = { query = '@loop.outer', desc = 'Prev loop start' },
					['[s'] = { query = '@scope', query_group = 'locals', desc = 'Prev scope' },
					['[z'] = { query = '@fold', query_group = 'folds', desc = 'Prev fold' },
				},
				goto_previous_end = {
					['[F'] = { query = '@call.outer', desc = 'Prev function call end' },
					['[M'] = { query = '@function.outer', desc = 'Prev method/function def end' },
					['[C'] = { query = '@class.outer', desc = 'Prev class end' },
					['[I'] = { query = '@conditional.outer', desc = 'Prev conditional end' },
					['[L'] = { query = '@loop.outer', desc = 'Prev loop end' },
				},
			},

			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
					['l='] = { query = '@assignment.lhs', desc = 'Select left part of assignment' },
					['r='] = { query = '@assignment.rhs', desc = 'Select right part of assignment' },
					['aa'] = { query = '@parameter.outer', desc = 'Select outer part of parameter/argument' },
					['ia'] = { query = '@parameter.inner', desc = 'Select inner part of parameter/argument' },
					['af'] = { query = '@call.outer', desc = 'Select outer part of method region' },
					['if'] = { query = '@call.inner', desc = 'Select inner part of method region' },
					['am'] = { query = '@function.outer', desc = 'Select outer part of function region' },
					['im'] = { query = '@function.inner', desc = 'Select inner part of function region' },
					['ac'] = { query = '@class.outer', desc = 'Select outer part of class region' },
					['ic'] = { query = '@class.inner', desc = 'Select inner part of class region' },
					['ai'] = { query = '@conditional.outer', desc = 'Select outer part of conditional' },
					['ii'] = { query = '@conditional.inner', desc = 'Select inner part of conditional' },
					['al'] = { query = '@loop.outer', desc = 'Select outer part of loop' },
					['il'] = { query = '@loop.inner', desc = 'Select outer part of loop' },
					['at'] = { query = '@comment.outer', desc = 'Select outer part of comment' },
				},
			},

			swap = {
				enable = true,
				swap_next = { ['<leader>cf'] = '@function.outer', },
				swap_previous = { ['<leader>cF'] = '@function.outer', },
			},

		},

	},

}
