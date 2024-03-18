local status_ok, whichkey = pcall( require, 'which-key' )
if not status_ok then
    return
end

whichkey.setup()

vim.keymap.set('n', '<leader> ', ':WhichKey<CR>')
