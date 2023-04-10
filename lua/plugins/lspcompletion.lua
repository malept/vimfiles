local plugin = require('plugin_util')

local setup = function()
  local cmp = require('cmp')
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
    require('vsnip_config').buf_config(bufnum)
    -- lsp-format
    require('lsp-format').on_attach(client)
  end
  local lsp_setup = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = lsp_on_attach
  }
  -- gopls is not included here because go.nvim handles it, see lua/plugins/go.lua
  local lang_servers = {'cssls', 'eslint', 'html', 'solargraph', 'tsserver', 'vimls'}
  for _, ls in ipairs(lang_servers) do
    lsp[ls].setup(lsp_setup)
  end

  if vim.fn.executable('pylsp') == 1 then
    lsp.pylsp.setup(lsp_setup)
  elseif vim.fn.executable('pyright') == 1 then
    lsp.pyright.setup(lsp_setup)
  end

  lsp.jsonls.setup {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = lsp_on_attach,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
  }
  require('rust-tools').setup({
    server = {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = lsp_on_attach
    }
  })
end

return {
  plugin.not_vscode_plugin({'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',
      'neovim/nvim-lspconfig',
      'simrat39/rust-tools.nvim',
    },
    config = setup,
  }),
  plugin.not_vscode_plugin({'neovim/nvim-lspconfig',
    dependencies = {
      'lukas-reineke/lsp-format.nvim',
      'b0o/schemastore.nvim',
    }
  }),
}
