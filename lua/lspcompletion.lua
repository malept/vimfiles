local cmp = require'cmp'
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  }
})

local lsp = require'lspconfig'
local lang_servers = {'cssls', 'gopls', 'html', 'jsonls', 'rust_analyzer', 'solargraph', 'tsserver', 'vimls'}
for _, ls in ipairs(lang_servers) do
  lsp[ls].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end
