-- Stuff to set whenever first entering neovim
vim.api.nvim_create_autocmd ( 'VimEnter', {
    pattern = '*',
    callback = function()

        -- If neovim is passed a folder instead of a file, set the working directory to the folder
        local pwd = vim.fn.expand('%:p:h')
        vim.api.nvim_set_current_dir(pwd)

        -- Turn on list characters, can be toggled by :set list!
        vim.cmd [[ set list ]]

        -- Set neovim's working directory root to the folder the opened file is in.
        vim.api.nvim_set_current_dir( vim.fn.expand('%:p:h') )

        -- If neovim opened a folder instead of a file, remove netrw and open telescope find_files
        if vim.fn.expand('%:p:h') == string.sub( vim.fn.expand('%p'), 0, -1 ) then
            vim.api.nvim_buf_delete( 0, { force = true } )
            local status_ok, telescope = pcall( require, 'telescope.builtin' )
            if status_ok then
                telescope.find_files()
            end
        end

    end,
})

-- For .txt or .md files, enable spell check by default
vim.api.nvim_create_autocmd ( { 'BufRead', 'BufNewFile' }, {
    pattern = { '*.txt', '*.md' },
    command = 'setlocal spell',
})
