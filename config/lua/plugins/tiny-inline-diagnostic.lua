return {
	"tiny-inline-diagnostic.nvim",
	dir = PluginsFromNix['tiny-inline-diagnostic-nvim'],
	event = 'VeryLazy',
	priority = 1000,
	init = {
		vim.diagnostic.config({ virtual_text = false })
	},
	opts = {}
}
