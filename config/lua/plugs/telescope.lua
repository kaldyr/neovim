require('telescope').setup {
  extensions = {
    ["ui-select"] = {
      require('telescope.themes').get_dropdown {}
    }
  },
}
require('telescope').load_extension('frecency')
require('telescope').load_extension('ui-select')

vim.keymap.set('n', '<leader>f:', require('telescope.builtin').command_history, { desc = 'Command History' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, { desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find Diagnostics' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Find Grep' })
vim.keymap.set('n', '<leader>fGc', require('telescope.builtin').git_commits, { desc = 'Find Git Commits' })
vim.keymap.set('n', '<leader>fGf', require('telescope.builtin').git_files, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>fGs', require('telescope.builtin').git_status, { desc = 'Find Git Status' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fH', require('telescope.builtin').highlights, { desc = 'Find Highlights' })
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = 'Find Keymaps' })
vim.keymap.set('n', '<leader>fm', require('telescope.builtin').marks, { desc = 'Find Marks' })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').vim_options, { desc = 'Find Options' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Recent Files' })
vim.keymap.set('n', '<leader>fR', require('telescope.builtin').resume, { desc = 'Resume' })
vim.keymap.set('n', '<leader>fs', ':Telescope symbols<CR>', { desc = 'Find Symbols', silent = true })
