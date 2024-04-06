local status_ok, fterm = pcall( require, 'FTerm' )
if not status_ok then
    return
end

fterm.setup()

vim.keymap.set('n', '<A-`>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-`>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
