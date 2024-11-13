-- Stuff to set whenever first entering neovim
vim.api.nvim_create_autocmd ( 'VimEnter', {
    pattern = '*',
    callback = function()
        -- If neovim is passed a folder instead of a file, set the working directory to the folder
        local pwd = vim.fn.expand('%:p:h')
        vim.api.nvim_set_current_dir(pwd)
        -- Turn on list characters, can be toggled by :set list!
        vim.cmd [[ set list ]]
    end,
})

-- For .txt or .md files, enable spell check by default
vim.api.nvim_create_autocmd ( { 'BufRead', 'BufNewFile' }, {
    pattern = { '*.txt', '*.md' },
    command = 'setlocal spell',
})
