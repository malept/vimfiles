-- Use completion-nvim if built with Lua 5.2+
local on_attach = function()
  require'completion'.on_attach()
end

local lsp = require'lspconfig'
local lang_servers = {'cssls', 'gopls', 'html', 'jsonls', 'rust_analyzer', 'solargraph', 'tsserver', 'vimls'}
for _, ls in ipairs(lang_servers) do
  lsp[ls].setup {
    on_attach = on_attach,
  }
end
