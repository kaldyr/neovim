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
      if root_dir:find('/home/matt/.config/nixos/', 1, true) == 1 then
        library.enabled = true
        library.plugins = true
      end
    end,
  })
end

local on_attach = function(_, bufnr)

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
  nmap('gr', vim.lsp.buf.references, 'Goto References')
  nmap('gT', vim.lsp.buf.type_definition, 'Goto Type Definition')
  nmap('<leader>ch', vim.lsp.buf.hover, 'Hover Documenation')
  nmap('<leader>cs', vim.lsp.buf.signature_help, 'Signature Documenation')
  nmap('<leader>ca', vim.buf.code_action, 'Code Action')
  nmap('<leader>cr', vim.buf.rename, 'Code Rename')
  nmap('<leader>ds', vim.buf.document_symbols, 'Document Symbols')
  nmap('<leader>wa', vim.buf.add_workspace, 'Workspace Add Folder')
  nmap('<leader>wl', vim.buf.list_workspace, 'Workspace List Folders')
  nmap('<leader>wr', vim.buf.remove_workspace, 'Workspace Remove Folder')
  nmap('<leader>ws', vim.buf.workspace_symbols, 'Workspace Symbols')

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lspconfig.cssls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.emmet_ls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.gopls.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.html.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.htmx.setup { on_attach = on_attach, capabilities = capabilities }
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
