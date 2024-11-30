local status_ok, treesitter = pcall( require, 'nvim-treesitter.configs' )
if not status_ok then
	return
end

treesitter.setup {

    auto_install = false,
    ensure_installed = {},
    ignore_install = {},
    highlight = { enable = true },
    sync_install = false,
    modules = {},

    autotag = {
		enable = true,
    },

    incremental_selection = {
		enable = true,
    },

}
