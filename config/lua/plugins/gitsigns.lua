local status_ok, gitsigns = pcall( require, 'gitsigns' )
if not status_ok then return end

gitsigns.setup({

	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '⨫' },
	},

	on_attach = function(bufnr)
		-- Navigation
		vim.keymap.set(
			{ 'n', 'v' },
			']h',
			function()
				vim.schedule(function()
					gitsigns.next_hunk()
				end)
				return '<Ignore>'
			end,
			{ expr = true, desc = 'Jump to next hunk', buffer = bufnr }
		)

		vim.keymap.set(
			{ 'n', 'v' },
			'[h',
			function()
				vim.schedule(function()
					gitsigns.prev_hunk()
				end)
				return '<Ignore>'
			end,
			{ expr = true, desc = 'Jump to previous hunk', buffer = bufnr }
		)

		-- Actions
		-- visual mode
		vim.keymap.set(
			'v',
			'<leader>Gs',
			function()
				gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
			end,
			{ desc = 'stage git hunk', buffer = bufnr }
		)
		vim.keymap.set(
			'v',
			'<leader>Gr',
			function()
				gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
			end,
			{ desc = 'reset git hunk', buffer = bufnr }
		)
		-- normal mode
		vim.keymap.set('n', '<leader>Gs', gitsigns.stage_hunk, { desc = 'git stage hunk', buffer = bufnr })
		vim.keymap.set('n', '<leader>Gr', gitsigns.reset_hunk, { desc = 'git reset hunk', buffer = bufnr })
		vim.keymap.set('n', '<leader>GS', gitsigns.stage_buffer, { desc = 'git Stage buffer', buffer = bufnr })
		vim.keymap.set('n', '<leader>Gu', gitsigns.undo_stage_hunk, { desc = 'undo stage hunk', buffer = bufnr })
		vim.keymap.set('n', '<leader>GR', gitsigns.reset_buffer, { desc = 'git Reset buffer', buffer = bufnr })
		vim.keymap.set('n', '<leader>Gp', gitsigns.preview_hunk, { desc = 'preview git hunk', buffer = bufnr })
		vim.keymap.set(
			'n',
			'<leader>Gb',
			function()
				gitsigns.blame_line { full = false }
			end,
			{ desc = 'git blame line', buffer = bufnr }
		)
		vim.keymap.set('n', '<leader>Gd', gitsigns.diffthis, { desc = 'git diff against index', buffer = bufnr })
		vim.keymap.set(
			'n',
			'<leader>Gc',
			function()
				gitsigns.diffthis '~'
			end,
			{ desc = 'git diff against last commit', buffer = bufnr }
		)

		-- Toggles
		vim.keymap.set('n', '<leader>Gb', gitsigns.toggle_current_line_blame, { desc = 'toggle git blame line', buffer = bufnr })
		vim.keymap.set('n', '<leader>GD', gitsigns.toggle_deleted, { desc = 'toggle git show deleted', buffer = bufnr })

		-- Text object
		vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk', buffer = bufnr })

	end,

})
