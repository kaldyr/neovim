return {

	PluginsFromNix['barbar-nvim'],

	init = function()
		vim.g.barbar_auto_setup = false
	end,

	keys = {
		{ '<C-p>', ':BufferPick<CR>', noremap = true, silent = true },
		{ '<C-n>', ':BufferPin<CR>', noremap = true, silent = true },
		-- Keyd used to get around the C-, C-. C-< C-> limitations of neovim
		{ '<Leader>bp', ':BufferPrevious<CR>', noremap = true, silent = true },
		{ '<Leader>bn', ':BufferNext<CR>', noremap = true, silent = true },
		{ '<Leader>BP', ':BufferMovePrevious<CR>', noremap = true, silent = true },
		{ '<Leader>BN', ':BufferMoveNext<CR>', noremap = true, silent = true },
	},

	opts = {
		auto_hide = 1
	},

}
