local status_ok, colorizer = pcall( require, 'colorizer' )
if not status_ok then
    return
end

colorizer.setup {
    filetypes = { "*" },
    user_default_options = {
        AARRGGBB = true,
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        hsl_fn = true,
        names = false,
        rgb_fn = true,
    }
}
