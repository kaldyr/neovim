local status_ok, flash = pcall( require, 'flash' )
if not status_ok then
	return
end

flash.setup()

vim.keymap.set(
	{ 'n', 'x', 'o' },
	's',
	function()
		flash.jump()
	end,
	{ desc = 'Flash Jump' }
)
