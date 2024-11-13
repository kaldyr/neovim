local status_ok, telescope = pcall( require, 'telescope' )
if not status_ok then
    return
end

status_ok, _ = pcall( telescope.load_extension, 'fzf' )
if not status_ok then
    return
end

status_ok, _ = pcall( telescope.load_extension, 'ui-select' )
if not status_ok then
    return
end

telescope.setup {
    extensions = {
        ["ui-select"] = {
            require('telescope.themes').get_dropdown {}
        }
    },
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f:', builtin.command_history, { desc = 'Command History' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Grep' })
vim.keymap.set('n', '<leader>fGc', builtin.git_commits, { desc = 'Find Git Commits' })
vim.keymap.set('n', '<leader>fGf', builtin.git_files, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>fGs', builtin.git_status, { desc = 'Find Git Status' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fH', builtin.highlights, { desc = 'Find Highlights' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Find Marks' })
vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = 'Find Options' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })
vim.keymap.set('n', '<leader>fR', builtin.resume, { desc = 'Resume' })
