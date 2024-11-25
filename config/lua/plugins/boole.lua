local status_ok, boole = pcall( require, 'boole' )
if not status_ok then
    return
end

boole.setup({

    mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
    },

    allow_caps_additions = {
        { 'enable', 'disable' },
        { 'true', 'false' },
        { 'yes', 'no' },
        { 'on', 'off' },
        { 'before', 'after' },
    }

})
