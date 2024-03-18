local status_ok, _ = pcall( require, 'lazygit' )
if not status_ok then
    return
end

vim.keymap.set('n', '<leader>gl', '<cmd>LazyGit<CR>', { desc = 'Toggle LazyGit' })
