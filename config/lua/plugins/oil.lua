local status_ok, oil = pcall( require, 'oil' )
if not status_ok then
  return
end

oil.setup({

  columns = {
    "icon",
    "permissions",
  },

  default_file_explorer = true,

  keymaps = {
    ["<CR>"] = "actions.select",
    ["<S-H>"] = "actions.parent",
    ["<S-L>"] = "actions.select",
    ["g?"] = "actions.show_help",
    ["g."] = "actions.toggle_hidden",
    ["gr"] = "actions.refresh",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["q"] = "actions.close",
  },

  use_default_keymaps = false,

})

vim.keymap.set('n', '<leader>e', '<cmd>Oil --float<CR>', { desc = 'File Explorer', silent = true })
