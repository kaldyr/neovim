-- All Modes
vim.keymap.set('', '<Space>', '<Nop>', { silent = true })

-- Normal Mode
-- Escape removes highlights
vim.keymap.set('n', '<ESC>', ':noh<CR>', { silent = true })
-- Move current line
vim.keymap.set('n', '<', '<<', { silent = true, noremap = true })
vim.keymap.set('n', '>', '>>', { silent = true, noremap = true })
vim.keymap.set('n', '<Down>', ':move .+1<CR>==', { silent = true, noremap = true })
vim.keymap.set('n', '<Up>', ':move .-2<CR>==', { silent = true, noremap = true })
-- Move character under cursor
vim.keymap.set('n', '<Left>', '"mxh"mP', { silent = true })
vim.keymap.set('n', '<Right>', '"mx"mp', { silent = true })
-- Window management
vim.keymap.set('n', '<C-w>n', ':new<CR>', { desc = 'Split down', silent = true })
vim.keymap.set('n', '<C-w>v', ':vnew<CR>', { desc = 'Split to right', silent = true })
-- Movement
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- Replace word under cursor
vim.keymap.set(
	'n',
	'<leader>r',
	':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<left><left><left><left>',
	{ desc = 'Replace [W]ord under cursor', silent = false }
)
-- Smart dd - if the line is empty don't override registers
vim.keymap.set(
	'n',
	'dd',
	function()
		if vim.api.nvim_get_current_line():match('^%s*$') then
			return '"_dd'
		end
		return 'dd'
	end,
	{ expr = true }
)

-- Visual Mode
-- Stay in visual mode after indent
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })
-- Move text
vim.keymap.set('v', '<Down>', ":move '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', '<Up>', ":move '<-2<CR>gv=gv", { silent = true, noremap = true })
-- Execute/Replay Macro over selection
vim.keymap.set('x', '.', ':norm .<CR>', { silent = true, noremap = true })
vim.keymap.set('x', '@', ':norm @@<CR>', { silent = true, noremap = true })
-- Replace selection
vim.keymap.set(
	'v',
	'<leader>r',
	'"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>',
	{ desc = 'Replace [S]election', silent = false }
)
