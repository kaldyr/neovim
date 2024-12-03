local status_ok, lspconfig = pcall( require, 'lspconfig' )
if not status_ok then return end

local status_ok, neodev = pcall( require, 'neodev' )
if status_ok then
	neodev.setup({
	override = function(root_dir, library)
		if root_dir:find('~/Projects/neovim/', 1, true) == 1 then
			library.enabled = true
			library.plugins = true
		end
	end,
	})
end

local on_attach = function(_, bufnr)
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { buffer = bufnr, desc = 'Goto Definition' })
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, { buffer = bufnr, desc = 'Goto Declaration' })
	vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, { buffer = bufnr, desc = 'Goto Implementation' })
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, { buffer = bufnr, desc = 'Goto References' })
	vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, { buffer = bufnr, desc = 'Goto Type Definition' })
	vim.keymap.set('n', 'leader>ch', function() vim.lsp.buf.hover() end, { buffer = bufnr, desc = 'Hover Documenation' })
	vim.keymap.set('n', 'leader>cs', function() vim.lsp.buf.signature_help() end, { buffer = bufnr, desc = 'Signature Documenation' })
	vim.keymap.set('n', 'leader>ca', function() vim.buf.code_action() end, { buffer = bufnr, desc = 'Code Action' })
	vim.keymap.set('n', 'leader>cr', function() vim.buf.rename() end, { buffer = bufnr, desc = 'Code Rename' })
	vim.keymap.set('n', 'leader>ds', function() vim.buf.document_symbols() end, { buffer = bufnr, desc = 'Document Symbols' })
	vim.keymap.set('n', 'leader>wa', function() vim.buf.add_workspace() end, { buffer = bufnr, desc = 'Workspace Add Folder' })
	vim.keymap.set('n', 'leader>wl', function() vim.buf.list_workspace() end, { buffer = bufnr, desc = 'Workspace List Folders' })
	vim.keymap.set('n', 'leader>wr', function() vim.buf.remove_workspace() end, { buffer = bufnr, desc = 'Workspace Remove Folder' })
	vim.keymap.set('n', 'leader>ws', function() vim.buf.workspace_symbols() end, { buffer = bufnr, desc = 'Workspace Symbols' })
end

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
vim.keymap.set('n', '<leader>cd', function() vim.diagnostic.open_float() end, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>cl', function() vim.diagnostic.setloclist() end, { desc = 'Open diagnostics list' })

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
