vim.api.nvim_create_autocmd ( 'VimEnter', {
    pattern = '*',
    callback = function()
        local pwd = vim.fn.expand('%:p:h')
        vim.api.nvim_set_current_dir(pwd)
    end,
})

vim.api.nvim_create_autocmd ( { 'BufRead', 'BufNewFile' }, {
    pattern = { '*.txt', '*.md' },
    command = 'setlocal spell',
})
