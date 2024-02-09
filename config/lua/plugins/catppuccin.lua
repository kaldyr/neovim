local status_ok, catppuccin = pcall( require, 'catppuccin' )
if not status_ok then
	vim.cmd [[colorscheme habamax]]
	return
end

local pluginIsPresent = function(plugin)
	status_ok, _ = pcall(require, plugin)
	return status_ok
end

catppuccin.setup({
  flavour = 'frappe',
  background = {
    light = 'latte',
    dark = 'frappe',
  },
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 0.15,
  },
  integrations = {
    fidget = pluginIsPresent('fidget'),
    flash = pluginIsPresent('flash'),
    gitsigns = pluginIsPresent('gitsigns'),
    illuminate = pluginIsPresent('illuminate'),
		indent_blankline = {
			enabled = pluginIsPresent('ibl'),
			scope_color = 'sapphire',
			colored_indent_levels = false, -- true,
		},
    native_lsp = {
      enabled = pluginIsPresent('lspconfig'),
    },
    noice = pluginIsPresent('noice'),
    notify = pluginIsPresent('notify'),
    nvimtree = pluginIsPresent('nvim-tree'),
    rainbow_delimiters = pluginIsPresent('rainbow-delimiters'),
    telescope = {
      enabled = pluginIsPresent('telescope'),
    },
    treesitter = pluginIsPresent('nvim-treesitter'),
    treesitter_context = pluginIsPresent('treesitter-context'),
    ufo = pluginIsPresent('ufo'),
    which_key = pluginIsPresent('which-key'),
  },
})

vim.cmd [[colorscheme catppuccin]]
