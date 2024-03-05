local status_ok, treesitter = pcall( require, 'nvim-treesitter.configs' )
if not status_ok then
  return
end

treesitter.setup {

  auto_install = false,
  ensure_installed = {},
  ignore_install = {},
  highlight = { enable = true },
  indent = { enable = true },
  sync_install = false,
  modules = {},

  autotag = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
  },

  textobjects = {

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = { query = '@call.outer', desc = 'Next function call start' },
        [']m'] = { query = '@function.outer', desc = 'Next method/function def start' },
        [']c'] = { query = '@class.outer', desc = 'Next class start' },
        [']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
        [']l'] = { query = '@loop.outer', desc = 'Next loop start' },
        [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
        [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
      },
      goto_next_end = {
        [']F'] = { query = '@call.outer', desc = 'Next function call end' },
        [']M'] = { query = '@function.outer', desc = 'Next method/function def end' },
        [']C'] = { query = '@class.outer', desc = 'Next class end' },
        [']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
        [']L'] = { query = '@loop.outer', desc = 'Next loop end' },
      },
      goto_previous_start = {
        ['[f'] = { query = '@call.outer', desc = 'Prev function call start' },
        ['[m'] = { query = '@function.outer', desc = 'Prev method/function def start' },
        ['[c'] = { query = '@class.outer', desc = 'Prev class start' },
        ['[i'] = { query = '@conditional.outer', desc = 'Prev conditional start' },
        ['[l'] = { query = '@loop.outer', desc = 'Prev loop start' },
        ['[s'] = { query = '@scope', query_group = 'locals', desc = 'Prev scope' },
        ['[z'] = { query = '@fold', query_group = 'folds', desc = 'Prev fold' },
      },
      goto_previous_end = {
        ['[F'] = { query = '@call.outer', desc = 'Prev function call end' },
        ['[M'] = { query = '@function.outer', desc = 'Prev method/function def end' },
        ['[C'] = { query = '@class.outer', desc = 'Prev class end' },
        ['[I'] = { query = '@conditional.outer', desc = 'Prev conditional end' },
        ['[L'] = { query = '@loop.outer', desc = 'Prev loop end' },
      },
    },

    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['a='] = '@assignment.outer',
        ['l='] = '@assignment.lhs',
        ['r='] = '@assignment.rhs',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@call.outer',
        ['if'] = '@call.inner',
        ['am'] = '@function.outer',
        ['im'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['at'] = '@comment.outer',
      },
    },

    swap = {
      enable = true,
      swap_next = { ['<leader>cf'] = '@function.outer', },
      swap_previous = { ['<leader>cF'] = '@function.outer', },
    },

  },

}

local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
