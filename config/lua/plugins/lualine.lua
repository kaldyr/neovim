local status_ok, lualine = pcall( require, 'lualine' )
if not status_ok then
	return
end

local colorscheme = function(desired, fallback)
	status_ok, _ = pcall( require, desired )
	if status_ok then
		return desired
	end
	return fallback
end

lualine.setup({

	options = {
		disabled_filetypes = { 'NvimTree' },
		theme = colorscheme('catppuccin', 'habamax'),
	}

})
