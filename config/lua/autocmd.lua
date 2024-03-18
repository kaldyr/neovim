vim.api.nvim_create_autocmd ( { "BufRead", "BufNewFile" }, {
    pattern = { "*.txt", "*.md" },
    command = "setlocal spell",
})
