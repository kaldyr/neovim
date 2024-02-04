require('flash').setup({
  jump = {
    nohlsearch = true
  }
})

vim.keymap.set(
  { 'n', 'x', 'o' },
  's',
  function()
    require('flash').jump()
  end,
  { desc = 'Flash Jump' }
)

vim.keymap.set(
  { 'n', 'x', 'o' },
  'S',
  function()
    require('flash').treesitter()
  end,
  { desc = 'Flash Treesitter' }
)
