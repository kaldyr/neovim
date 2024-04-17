local status_ok, lspconfig = pcall( require, 'lspconfig' )
if not status_ok then
    return
end

local status_ok, fidget = pcall( require, 'fidget' )
if status_ok then
    fidget.setup {}
end

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
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,  { buffer = bufnr, desc = 'Goto Definition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Goto Implementation' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Goto References' })
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Goto Type Definition' })
    vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documenation' })
    vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documenation' })
    vim.keymap.set('n', '<leader>ca', vim.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
    vim.keymap.set('n', '<leader>cr', vim.buf.rename, { buffer = bufnr, desc = 'Code Rename' })
    vim.keymap.set('n', '<leader>ds', vim.buf.document_symbols, { buffer = bufnr, desc = 'Document Symbols' })
    vim.keymap.set('n', '<leader>wa', vim.buf.add_workspace, { buffer = bufnr, desc = 'Workspace Add Folder' })
    vim.keymap.set('n', '<leader>wl', vim.buf.list_workspace, { buffer = bufnr, desc = 'Workspace List Folders' })
    vim.keymap.set('n', '<leader>wr', vim.buf.remove_workspace, { buffer = bufnr, desc = 'Workspace Remove Folder' })
    vim.keymap.set('n', '<leader>ws', vim.buf.workspace_symbols, { buffer = bufnr, desc = 'Workspace Symbols' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.filetype.add({ extension = { templ = "templ" } }) -- a-h/templ Go

lspconfig.cssls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "html", "templ" },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            },
        },
    }
})
lspconfig.gopls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.html.setup { on_attach = on_attach, capabilities = capabilities , filetypes = { "html", "templ" } }
lspconfig.htmx.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "html", "templ" } }
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}
lspconfig.marksman.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.nil_ls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.templ.setup { on_attach = on_attach, capabilities = capabilities }

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>cl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.g.markdown_fenced_languages = {
    'css',
    'fish',
    'html',
    'go',
    'javascript',
    'lua',
    'nix',
    'python',
    'sql',
    'vim',
}
