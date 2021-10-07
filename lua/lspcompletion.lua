local lsp = require'lspconfig'
local lang_servers = {'cssls', 'gopls', 'html', 'jsonls', 'rust_analyzer', 'solargraph', 'tsserver', 'vimls'}
for _, ls in ipairs(lang_servers) do
  lsp[ls].setup {
  }
end
