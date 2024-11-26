local status_ok, flash = pcall( require, 'flash' )
if not status_ok then
    return
end

flash.setup({
    jump = {
        nohlsearch = true
    }
})

vim.keymap.set(
    { 'n', 'x', 'o' },
    '<leader>j',
    function()
        flash.jump()
    end,
    { desc = 'Flash Jump' }
)

vim.keymap.set(
    { 'n', 'x', 'o' },
    '<leader>J',
    function()
        flash.treesitter()
    end,
    { desc = 'Flash Treesitter' }
)
