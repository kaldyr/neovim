require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').config.setup {}

require('cmp').setup {

	completion = {
		completeopt = 'menu,menuone,noinsert',
	},

	mapping = require('cmp').mapping.preset.insert {
		['<C-j>']= require('cmp').mapping.select_next_item(),
		['<C-k>']= require('cmp').mapping.select_prev_item(),
		['<C-u>']= require('cmp').mapping.scroll_docs(-4),
		['<C-d>']= require('cmp').mapping.scroll_docs(4),
		['<C-Space>']= require('cmp').mapping.complete(),
		['<CR>']= require('cmp').mapping.confirm({
			behavior = require('cmp').ConfirmBehavior.Replace,
			select = true
		}),
		['<Tab>'] = require('cmp').mapping(function(fallback)
			if require('cmp').visible() then
				require('cmp').select_next_item()
			elseif require('luasnip').expand_or_locally_jumpable() then
				require('luasnip').expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = require('cmp').mapping(function(fallback)
			if require('cmp').visible() then
				require('cmp').select_prev_item()
			elseif require('luasnip').locally_jumpable(-1) then
				require('luasnip').jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},

	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'luasnip' },
	},

}
