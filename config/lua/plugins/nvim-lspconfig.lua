return {

	PluginsFromNix['nvim-lspconfig'],

	config = function()
		vim.filetype.add({ extension = { templ = "templ" } }) -- a-h/templ Go

		require('lspconfig').cssls.setup { }
		require('lspconfig').gopls.setup { }
		require('lspconfig').html.setup { filetypes = { "html", "templ" } }
		require('lspconfig').htmx.setup { filetypes = { "html", "templ" } }
		require('lspconfig').lua_ls.setup { }
		require('lspconfig').marksman.setup { }
		require('lspconfig').nil_ls.setup { }
		require('lspconfig').nushell.setup { }
		require('lspconfig').taplo.setup { }
		require('lspconfig').templ.setup { }
		require('lspconfig').yamlls.setup { }

		vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, { desc = 'Go to previous diagnostic message' })
		vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, { desc = 'Go to next diagnostic message' })

		vim.g.markdown_fenced_languages = {
			'css',
			'fish',
			'html',
			'go',
			'javascript',
			'json',
			'lua',
			'nix',
			'python',
			'sql',
			'vim',
		}
	end

}
