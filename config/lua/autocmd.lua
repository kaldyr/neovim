vim.api.nvim_create_autocmd ( 'VimEnter', {
    pattern = '*',
    callback = function()
        local pwd = vim.fn.expand('%:p:h')
        if string.sub(pwd,1,6) == 'oil://' then
            pwd = string.sub( pwd, 7 )
        end
        vim.api.nvim_set_current_dir(pwd)
    end,
})

vim.api.nvim_create_autocmd ( { 'BufRead', 'BufNewFile' }, {
    pattern = { '*.txt', '*.md' },
    command = 'setlocal spell',
})
