local status_ok, barbar = pcall( require, 'barbar' )
if not status_ok then
	return
end

barbar.setup({ auto_hide = 1; })

vim.api.nvim_set_keymap('n', '<C-p>', ':BufferPick<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':BufferPin<CR>', { silent = true, noremap = true })
-- Keyd used to get around the C-, C-. C-< C-> limitations of neovim
vim.api.nvim_set_keymap('n', '<Leader>bp', ':BufferPrevious<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>bn', ':BufferNext<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>BP', ':BufferMovePrevious<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>BN', ':BufferMoveNext<CR>', { silent = true, noremap = true })
