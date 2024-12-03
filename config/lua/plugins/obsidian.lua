local status_ok, obsidian = pcall( require, 'obsidian' )
if not status_ok then return end

local notesPath = "/home/matt/Notes"

status_ok, _, _ = os.rename(notesPath, notesPath)
if not status_ok then return end

obsidian.setup({

	completion = { nvim_cmp = true },
	finder = "telescope.nvim",

	mappings = {
		["gf"] = {
			action = function()
				return obsidian.util.gf_passthrough()
			end,
			opts = { buffer = true, expr = true, noremap = false },
		},
		["<cr>"] = {
			action = function()
				return obsidian.util.smart_action()
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
		{ name = "Notes", path = notesPath },
	},

})
