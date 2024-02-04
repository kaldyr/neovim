-- Define the Leader Key
vim.keymap.set('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Normal Mode
-- escape removes highlights
vim.keymap.set('n', '<ESC>', ':noh<CR>', { silent = true })
-- switch between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
-- resize windows with arrow keys
vim.keymap.set('n', '<C-Left>', ':vertical resize -1<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +1<CR>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize +1<CR>', { silent = true })
vim.keymap.set('n', '<C-Up>', ':resize -1<CR>', { silent = true })
-- navigate buffers
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { silent = true })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { silent = true })
-- close buffers
vim.keymap.set('n', '<S-q>', ':bd<CR>', { silent = true })
-- move current line
vim.keymap.set('n', '<C-S-k>', ':move .-2<CR>==', { silent = true, noremap = true })
vim.keymap.set('n', '<C-S-j>', ':move .+1<CR>==', { silent = true, noremap = true })
-- Spellcheck
vim.keymap.set('n', '<leader>st', ':set invspell<CR>', { desc = 'Toggle Spellcheck', silent = true, noremap = true })
vim.keymap.set('n', '<leader>ss', 'z=', { desc = 'Suggest Spelling', silent = true, noremap = true })
-- Replace word under cursor
vim.keymap.set(
	'n',
	'<leader>rw',
	':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<left><left><left><left>',
	{
		desc = 'Replace [W]ord under cursor',
		silent = false
	}
)
-- Smart dd
vim.keymap.set('n', 'dd', function()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  end
  return 'dd'
end, { expr = true })

-- Visual Mode
-- stay in visual mode after indent
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })
-- move text
vim.keymap.set('v', '<C-S-j>', ":move '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', '<C-S-k>', ":move '<-2<CR>gv=gv", { silent = true, noremap = true })
-- Execute/Replay Macro over selection
vim.keymap.set('x', '.', ':norm .<CR>', { noremap = true})
vim.keymap.set('x', '@', ':norm @@<CR>', { noremap = true})
-- Replace selection
vim.keymap.set(
	'v',
	'<leader>rs',
	'"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>',
	{
		desc = 'Replace [S]election',
		silent = false
	}
)

-- Multiple modes
-- Send things to blackhole register
vim.keymap.set({'n', 'v'}, 'd', '\"_d', { silent = true, noremap = true })
vim.keymap.set({'n', 'v'}, 'D', 'd', { silent = true, noremap = true })
vim.keymap.set({'n', 'v'}, 'c', '\"_c', { silent = true, noremap = true })
vim.keymap.set({'n', 'v'}, 'x', '\"_x', { silent = true, noremap = true })
-- Fighting One-Eyed Kirby
vim.keymap.set(
	{'n', 'x'},
	'<leader>rk',
	':s/\\(.*\\)/\\1<left><left><left><left><left><left><left><left><left>',
	{
		desc = 'Fighting One-Eyed Kirby',
		silent = false
	}
)
