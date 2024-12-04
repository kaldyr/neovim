return {

	PluginsFromNix['obsidian-nvim'],

	cond = function()
		return vim.fn.getcwd() == vim.fn.expand '~' .. '/Notes'
	end,

	opts = {

		completion = { nvim_cmp = true },
		finder = "telescope.nvim",

		mappings = {
			["gf"] = {
				action = function()
					return require('obsidian').util.gf_passthrough()
				end,
				opts = { buffer = true, expr = true, noremap = false },
			},
			["<cr>"] = {
				action = function()
					return require('obsidian').util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		ui = {
			enable = false,
			checkboxes = {
			[" "] = { hl_group = "ObsidianTodo" },
			["x"] = { hl_group = "ObsidianDone" },
			},
		},

		workspaces = {
			{ name = "Notes", path = "/home/matt/Notes" },
		},

	},

}
