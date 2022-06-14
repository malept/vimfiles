local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }),
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
})

local lsp = require'lspconfig'
local lsp_on_attach = function(client, bufnum)
  local function buf_set_keymap(binding, lua_cmd)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnum, 'n', binding, string.format('<cmd>lua %s<CR>', lua_cmd), opts)
  end
  buf_set_keymap('gD', 'vim.lsp.buf.declaration()')
  buf_set_keymap('K', 'vim.lsp.buf.hover()')
  buf_set_keymap('<C-k>', 'vim.lsp.buf.signature_help()')
  -- Telescope based
  buf_set_keymap('gd', 'require("telescope.builtin").lsp_definitions()')
  buf_set_keymap('gi', 'require("telescope.builtin").lsp_implementations()')
  buf_set_keymap('gr', 'require("telescope.builtin").lsp_references()')
  -- vsnip
  require('plugins.vsnip').buf_config(bufnum)
  -- lsp-format
  require('lsp-format').on_attach(client)
end
-- gopls is not included here because go.nvim handles it, see lua/plugins/go.lua
local lang_servers = {'cssls', 'eslint', 'html', 'pyright', 'rust_analyzer', 'solargraph', 'tsserver', 'vimls'}
for _, ls in ipairs(lang_servers) do
  lsp[ls].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = lsp_on_attach
  }
end

lsp.jsonls.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = lsp_on_attach,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
}
