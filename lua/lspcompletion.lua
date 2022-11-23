local cmp = require'cmp'
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
})

local lsp = require'lspconfig'
local lang_servers = {'cssls', 'eslint', 'gopls', 'html', 'jsonls', 'rust_analyzer', 'solargraph', 'tsserver', 'vimls'}
for _, ls in ipairs(lang_servers) do
  lsp[ls].setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }
end
