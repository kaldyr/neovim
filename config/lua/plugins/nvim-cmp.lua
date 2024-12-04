local status_ok, cmp = pcall( require, 'cmp' )
if not status_ok then return end

cmp.setup {

	completion = {
		completeopt = 'menu,menuone,noinsert',
	},

	mapping = cmp.mapping.preset.insert {
		['<C-j>']= cmp.mapping.select_next_item(),
		['<C-k>']= cmp.mapping.select_prev_item(),
		['<C-u>']= cmp.mapping.scroll_docs(-4),
		['<C-d>']= cmp.mapping.scroll_docs(4),
		['<C-Space>']= cmp.mapping.complete(),
		['<CR>']= cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' },
	},

}
