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
local lang_servers = {'cssls', 'eslint', 'gopls', 'html', 'jsonls', 'pyright', 'rust_analyzer', 'solargraph', 'tsserver', 'vimls'}
for _, ls in ipairs(lang_servers) do
  lsp[ls].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnum)
      local function buf_set_keymap(binding, cmd)
        local opts = { noremap=true, silent=true }
        vim.api.nvim_buf_set_keymap(bufnum, 'n', binding, cmd, opts)
      end
      buf_set_keymap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      buf_set_keymap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      buf_set_keymap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
      -- Telescope based
      buf_set_keymap('gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>')
      buf_set_keymap('gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>')
      buf_set_keymap('gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>')
    end
  }
end

vim.api.nvim_exec([[ autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500) ]], false)
