local status_ok, lspconfig = pcall( require, 'lspconfig' )
if not status_ok then
    return
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

vim.filetype.add({ extension = { templ = "templ" } }) -- a-h/templ Go

lspconfig.cssls.setup { }
lspconfig.gopls.setup { }
lspconfig.html.setup { filetypes = { "html", "templ" } }
lspconfig.htmx.setup { filetypes = { "html", "templ" } }
lspconfig.lua_ls.setup { }
lspconfig.marksman.setup { }
lspconfig.nil_ls.setup { }
lspconfig.nushell.setup { }
lspconfig.taplo.setup { }
lspconfig.templ.setup { }
lspconfig.yaml_language_server.setup { }

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
