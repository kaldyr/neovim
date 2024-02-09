local status_ok, ibl = pcall( require, 'ibl' )
if not status_ok then
	return
end

local hooks = require('ibl.hooks')
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#e78284' })
	vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#ef9f76' })
	vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#e5c890' })
	vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#a6d189' })
	vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#81c8be' })
	vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#8caaee' })
	vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#ca9ee6' })
end)

ibl.setup {

	indent = {
		char = { '', '┊', '┆', '¦', '|', '¦', '┆', '┊', '' },
		-- highlight = {
		-- 	'RainbowRed',
		-- 	'RainbowOrange',
		-- 	'RainbowYellow',
		-- 	'RainbowGreen',
		-- 	'RainbowCyan',
		-- 	'RainbowBlue',
		-- 	'RainbowViolet',
		-- }

	}

}
