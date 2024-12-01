local status_ok, obsidian = pcall( require, 'obsidian' )
if not status_ok then
	return
end

local notesPath = "/home/matt/Notes"

local status_ok, errstr, _ = os.rename(notesPath, notesPath)
if status_ok == nil then
	print( errstr )
	return
end

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
		enable = true,
		checkboxes = {
		[" "] = { hl_group = "ObsidianTodo" },
		["x"] = { hl_group = "ObsidianDone" },
		},
	},

	workspaces = {
		{ name = "Notes", path = notesPath },
	},

})
