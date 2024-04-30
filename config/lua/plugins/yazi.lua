local status_ok, yazi = pcall( require, 'yazi' )
if not status_ok then
    return
end

yazi.setup()

vim.keymap.set(
    'n',
    '<leader>y',
    function()
        yazi.yazi(nil, vim.fn.getcwd())
    end,
    { desc = 'Toggle Yazi' }
)
