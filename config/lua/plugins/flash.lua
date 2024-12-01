local status_ok, flash = pcall( require, 'flash' )
if not status_ok then
	return
end

flash.setup()

vim.keymap.set(
	{ 'n', 'x', 'o' },
	'S',
	function()
		flash.jump()
	end,
	{ desc = 'Flash Jump' }
)
