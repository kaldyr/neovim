return {

	"which-key.nvim",
	dir = PluginsFromNix['which-key-nvim'],

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},

	opts = {},

}
