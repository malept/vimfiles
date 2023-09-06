local plugin = require('plugin_util')

local setup = function()
  local cmp = require('cmp')
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }),
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
  })

  local lsp = require('lspconfig')
  local lsp_set_keymaps = function(bufnum)
    local function buf_set_keymap(binding, lua_fn, desc)
      local opts = { buffer = bufnum, desc = desc }
      vim.keymap.set('n', binding, lua_fn, opts)
    end
    buf_set_keymap('gD', function() vim.lsp.buf.declaration() end, '[G]o to [Definition]')
    buf_set_keymap('K', function() vim.lsp.buf.hover() end, 'Hover documentation')
    buf_set_keymap('<C-k>', function() vim.lsp.buf.signature_help() end, 'Signature documentation')
    -- Telescope based
    buf_set_keymap('gd', function() require('telescope.builtin').lsp_definitions() end, 'Select definition')
    buf_set_keymap('gi', function() require('telescope.builtin').lsp_implementations() end, 'Select implementation')
    buf_set_keymap('gr', function() require('telescope.builtin').lsp_references() end, 'Select reference')
  end
  local lsp_on_attach = function(client, bufnum)
    lsp_set_keymaps(bufnum)
    -- lsp-format
    require('lsp-format').on_attach(client)
  end
  local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lsp_setup = {
    capabilities = lsp_capabilities,
    on_attach = lsp_on_attach
  }
  local lang_servers = {'cssls', 'eslint', 'html', 'solargraph', 'tsserver', 'vimls'}
  for _, ls in ipairs(lang_servers) do
    lsp[ls].setup(lsp_setup)
  end

  if vim.fn.executable('gopls') == 1 then
    lsp.gopls.setup(lsp_setup)
  end

  if vim.fn.executable('pylsp') == 1 then
    lsp.pylsp.setup(lsp_setup)
  elseif vim.fn.executable('pyright') == 1 then
    lsp.pyright.setup(lsp_setup)
  end

  lsp.jsonls.setup {
      capabilities = lsp_capabilities,
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
    version = nil, -- this plugin does not make releases
    branch = 'main',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'neovim/nvim-lspconfig',
      'simrat39/rust-tools.nvim',
    },
    config = setup,
  }),
  plugin.not_vscode_plugin({'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip').filetype_extend('ruby', {'rails'})
    end,
    dependencies = {
      'rafamadriz/friendly-snippets',
    }
  }),
  plugin.not_vscode_plugin({'neovim/nvim-lspconfig',
    dependencies = {
      'lukas-reineke/lsp-format.nvim',
      'b0o/schemastore.nvim',
    }
  }),
}
