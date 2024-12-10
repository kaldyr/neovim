-- Cleanup space for leader key usage
vim.keymap.set('', '<Space>', '<Nop>', { silent = true })

-- Escape removes highlights
vim.keymap.set('n', '<ESC>', '<Cmd>noh<CR>', { silent = true })

-- Line Movement
vim.keymap.set('n', '<', '<<', { silent = true, noremap = true })
vim.keymap.set('n', '>', '>>', { silent = true, noremap = true })
vim.keymap.set('n', '<Down>', '<Cmd>move .+1<CR>==', { silent = true, noremap = true })
vim.keymap.set('n', '<Up>', '<Cmd>move .-2<CR>==', { silent = true, noremap = true })
vim.keymap.set('v', '<Down>', ":move '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', '<Up>', ":move '<-2<CR>gv=gv", { silent = true, noremap = true })

-- Character movement
vim.keymap.set('n', '<Left>', '"mxh"mP', { silent = true })
vim.keymap.set('n', '<Right>', '"mx"mp', { silent = true })

-- Window management
vim.keymap.set('n', '<C-w>n', '<Cmd>new<CR>', { desc = 'Split down', silent = true })
vim.keymap.set('n', '<C-w>v', '<Cmd>vnew<CR>', { desc = 'Split to right', silent = true })
vim.keymap.set('n', '<C-q>', '<Cmd>bd<CR>', { desc = 'Close Buffer', silent = true })

-- Screen Movement
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Stay in visual mode after indent
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })

-- Execute/Replay Macro over selection
vim.keymap.set('x', '.', '<Cmd>norm .<CR>', { silent = true, noremap = true })
vim.keymap.set('x', '@', '<Cmd>norm @@<CR>', { silent = true, noremap = true })

-- Replace word under cursor
vim.keymap.set(
	'n',
	'<leader>r',
	':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<left><left><left><left>',
	{ desc = 'Replace [W]ord under cursor', silent = false }
)

-- Replace selection
vim.keymap.set(
	'v',
	'<leader>r',
	'"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>',
	{ desc = 'Replace [S]election', silent = false }
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
