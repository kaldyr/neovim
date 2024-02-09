local status_ok, sort = pcall( require, 'sort' )
if not status_ok then
	vim.keymap.set(
		{'n', 'x'},
		'<leader>s',
		':sort',
		{ desc = 'sort', silent = true }
	)
	return
end

sort.setup()

vim.keymap.set(
	{'n', 'x'},
	'<leader>s',
	':Sort',
	{ desc = 'Sort', silent = true }
)
