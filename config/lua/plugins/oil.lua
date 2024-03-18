local status_ok, oil = pcall( require, 'oil' )
if not status_ok then
    return
end

oil.setup({

    columns = {
        "icon",
        "permissions",
    },

    constrain_cursor = "editable",
    default_file_explorer = true,

    keymaps = {
        ["<CR>"] = "actions.select",
        ["<S-H>"] = "actions.parent",
        ["<S-L>"] = "actions.select",
        ["<C-v"] = "actions.select_vsplit",
        ["g?"] = "actions.show_help",
        ["g."] = "actions.toggle_hidden",
        ["gr"] = "actions.refresh",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["q"] = "actions.close",
        ["`"] = "actions.cd",
    },

    preview = {
        border = "rounded",
        update_on_cursor_moved = true,
    },

    progress = {
        border = "rounded",
    },

    use_default_keymaps = false,

})

vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'File Explorer', silent = true })
