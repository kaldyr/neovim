local status_ok, lualine = pcall( require, 'lualine' )
if not status_ok then
    return
end

local colorscheme = function(desired, fallback)
    status_ok, _ = pcall( require, desired )
    if status_ok then
        return desired
    end
    return fallback
end

lualine.setup({

    options = {
        show_filename_only = false,
        theme = colorscheme('catppuccin', 'habamax'),
    },

    sections = {
        lualine_c = {
            { 'filename', path = 1 },
        },
    },

})
