vim.api.nvim_create_autocmd ( 'VimEnter', {
    pattern = '*',
    callback = function()
        vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
    end,
})

vim.api.nvim_create_autocmd ( { 'BufRead', 'BufNewFile' }, {
    pattern = { '*.txt', '*.md' },
    command = 'setlocal spell',
})
