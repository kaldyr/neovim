return {

	'hrsh7th/nvim-cmp',
	dir = PluginsFromNix['nvim-cmp'],

	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp', dir = PluginsFromNix['cmp-nvim-lsp'], lazy = true },
		{ 'hrsh7th/cmp-path', dir = PluginsFromNix['cmp-path'], lazy = true },
	},

	lazy = false,

	config = function()
		require('cmp').setup({
			completion = {
				completeopt = 'menu,menuone,noinsert',
			},
			mapping = require('cmp').mapping.preset.insert {
				['<C-j>'] = require('cmp').mapping.select_next_item(),
				['<C-k>'] = require('cmp').mapping.select_prev_item(),
				['<C-u>'] = require('cmp').mapping.scroll_docs(-4),
				['<C-d>'] = require('cmp').mapping.scroll_docs(4),
				['<C-Space>'] = require('cmp').mapping.complete(),
				['<CR>'] = require('cmp').mapping.confirm({
					behavior = require('cmp').ConfirmBehavior.Replace,
					select = true
				}),
				['<Tab>'] = require('cmp').mapping(function(fallback)
					if require('cmp').visible() then
						require('cmp').select_next_item()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = require('cmp').mapping(function(fallback)
					if require('cmp').visible() then
						require('cmp').select_prev_item()
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'path' },
			},
		})
	end,

}
