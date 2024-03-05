local status_ok, nvimtree = pcall( require, 'nvim-tree' )
if not status_ok then
  return
end

nvimtree.setup({

  filters = {
    custom = {
      '^.git$'
    }
  },

  on_attach = function(bufnr)

    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'L', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close'))
    vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse All'))
    vim.keymap.set('n', 'D', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', ']', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('CD'))

  end,

  sort_by = function(nodes)
    -- Natural sorting method putting numbers in correct order (1, 10, 100, 2) -> (1, 2, 10, 100)
    table.sort(nodes, function(left, right)

      if left.type ~= 'directory' and right.type == 'directory' then
        return false
      elseif left.type == 'directory' and right.type ~= 'directory' then
        return true
      end

      left = left.name:lower()
      right = right.name:lower()

      if left == right then
        return false
      end

      for i = 1, math.max(string.len(left), string.len(right)), 1 do
        local l = string.sub(left, i, -1)
        local r = string.sub(right, i, -1)

        if type(tonumber(string.sub(l, 1, 1))) == 'number' and type(tonumber(string.sub(r, 1, 1))) == 'number' then
          local l_number = tonumber(string.match(l, '^[0-9]+'))
          local r_number = tonumber(string.match(r, '^[0-9]+'))

          if l_number ~= r_number then
            return l_number < r_number
          end

        elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
          return l < r
        end

      end

    end)

  end

})

vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'File Explorer', silent = true })
