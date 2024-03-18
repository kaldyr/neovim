local status_ok, _ = pcall( require, 'yazi' )
if not status_ok then
    return
end

vim.keymap.set('n', '<leader>y', '<cmd>Yazi<CR>', { desc = 'Toggle Yazi' })
