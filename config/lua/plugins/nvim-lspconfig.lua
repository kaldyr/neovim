local status_ok, lspconfig = pcall( require, 'lspconfig' )
if not status_ok then return end


vim.filetype.add({ extension = { templ = "templ" } }) -- a-h/templ Go

lspconfig.cssls.setup { on_attach = on_attach }
lspconfig.gopls.setup { on_attach = on_attach }
lspconfig.html.setup { filetypes = { "html", "templ" }, on_attach = on_attach }
lspconfig.htmx.setup { filetypes = { "html", "templ" }, on_attach = on_attach }
lspconfig.lua_ls.setup { on_attach = on_attach }
lspconfig.marksman.setup { on_attach = on_attach }
lspconfig.nil_ls.setup { on_attach = on_attach }
lspconfig.nushell.setup { on_attach = on_attach }
lspconfig.taplo.setup { on_attach = on_attach }
lspconfig.templ.setup { on_attach = on_attach }
lspconfig.yamlls.setup { on_attach = on_attach }

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
