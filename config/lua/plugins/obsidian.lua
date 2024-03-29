local status_ok, obsidian = pcall( require, 'obsidian' )
if not status_ok then
    return
end

obsidian.setup {

    workspaces = {
        { name = "Notes", path = "~/Notes" },
    },

    mappings = {
        ["gf"] = {
            action = function()
            return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>x"] = {
            action = function()
            return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        ["gl"] = {
            action = function()
            return "<cmd>ObsidianFollowLink<CR>"
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
    },

}
