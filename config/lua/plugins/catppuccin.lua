return {

	"catppuccin.nvim",
	dir = PluginsFromNix['catppuccin-nvim'],
	lazy = false,
	priority = 1000,

	init = function()
		vim.cmd [[colorscheme catppuccin]]
	end,

	opts = {

		flavour = 'frappe',

		background = {
			light = 'latte',
			dark = 'frappe',
		},

		dim_inactive = {
			enabled = true,
			shade = 'dark',
			percentage = 0.35,
		},

		integrations = {
			barbar = true,
			cmp = true,
			flash = true,
			gitsigns = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			mini = {
				enabled = true,
			},
			noice = true,
			render_markdown = true,
			telescope = {
				enabled = true,
			},
			treesitter = true,
			treesitter_context = true,
			which_key = true,
		},

		term_colors = true,

	},

}
