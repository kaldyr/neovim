return {

	PluginsFromNix['gitsigns-nvim'],
	event = { 'BufReadPre', 'BufNewFile' },

	opts = {

		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '⨫' },
		},

		preview_config = {
			border = 'single',
		},

		on_attach = function(bufnr)
			vim.keymap.set('n', '[g', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Jump to previous hunk' })
			vim.keymap.set('n', ']g', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Jump to next hunk' })
			vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
			vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
			vim.keymap.set('n', '<leader>gS', require('gitsigns').stage_buffer, { buffer = bufnr, desc = 'Stage entire buffer' })
			vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
			vim.keymap.set('n', '<leader>gR', require('gitsigns').reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })
			vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
			vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line, { buffer = bufnr, desc = 'Show blame information' })
			vim.keymap.set('n', '<leader>gD', require('gitsigns').diffthis, { buffer = bufnr, desc = 'Diff buffer' })
			vim.keymap.set('n', '<leader>gT', require('gitsigns').toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle current blame' })
			vim.keymap.set('n', '<leader>gd', require('gitsigns').toggle_deleted, { buffer = bufnr, desc = 'Toggle deleted' })
		end,

	},

}
