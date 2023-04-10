M = {}

M.ensure_installed = function ()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

local no_vscode = function()
  return vim.fn.exists('g:vscode') == 0
end
local poetry_exists = function()
  return (no_vscode() and vim.fn.executable 'poetry' == 1)
end
local older_than_nvim09 = function()
  return (no_vscode() and vim.fn.has('nvim-0.9') == 0)
end

local not_vscode_plugin = function(plugin)
  if type(plugin) == 'string' then
    return {plugin, cond = no_vscode}
  elseif type(plugin) == 'table' then
    plugin.cond = no_vscode
    return plugin
  end
end

M.setup = function ()
  require('lazy').setup({
    -- Editor-agnostic
    {'dstein64/vim-startuptime', cmd = 'StartupTime'},
    {'echasnovski/mini.nvim',
      config = function() require('plugins.mini') end
    },
    'godlygeek/tabular',
    {'kylechui/nvim-surround',
      event = 'VeryLazy',
      config = function() require('nvim-surround').setup() end
    },
    {'preservim/vim-wordy', event = 'VeryLazy'},
    'takac/vim-hardtime',
    {'tpope/vim-projectionist', event = 'VeryLazy'},

    -- Non-vscode
    not_vscode_plugin('Glench/Vim-Jinja2-Syntax'),
    not_vscode_plugin({'JoosepAlviste/nvim-ts-context-commentstring',
      dependencies = 'nvim-treesitter/nvim-treesitter',
      config = function() require('plugins.treesitter') end
    }),
    not_vscode_plugin('b0o/schemastore.nvim'),
    not_vscode_plugin('chr4/nginx.vim'),
    not_vscode_plugin({'chrisbra/Recover.vim', lazy = false}),
    not_vscode_plugin({'dhruvasagar/vim-prosession',
      lazy = false,
      priority = 900,
      dependencies = 'tpope/vim-obsession',
    }),
    {'editorconfig/editorconfig-vim', cond = older_than_nvim09},
    not_vscode_plugin('google/vim-jsonnet'),
    not_vscode_plugin({'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-vsnip',
        'neovim/nvim-lspconfig',
        'simrat39/rust-tools.nvim',
      },
      config = function() require('plugins.lspcompletion') end
    }),
    not_vscode_plugin('jamessan/vim-gnupg'),
    not_vscode_plugin({'lukas-reineke/indent-blankline.nvim',
      event = { "BufReadPost", "BufNewFile" },
      config = function() require('plugins.indent_blankline') end
    }),
    not_vscode_plugin({'lukas-reineke/lsp-format.nvim',
      config = function() require('lsp-format').setup {} end
    }),
    not_vscode_plugin({'mfussenegger/nvim-dap',
      config = function() require('plugins.dap') end
    }),
    not_vscode_plugin({'nvim-neotest/neotest',
      event = 'VeryLazy',
      dependencies = {
        'antoinemadec/FixCursorHold.nvim',
        'haydenmeade/neotest-jest',
        'nvim-lua/plenary.nvim',
        'nvim-neotest/neotest-go',
        'nvim-neotest/neotest-vim-test',
        'nvim-treesitter/nvim-treesitter',
        'olimorris/neotest-rspec',
        'rouge8/neotest-rust',
      },
      config = function() require('plugins.neotest') end
    }),
    not_vscode_plugin({'nvim-neotest/neotest-vim-test', dependencies = 'vim-test/vim-test'}),
    not_vscode_plugin({'neovim/nvim-lspconfig',
      dependencies = {
        'lukas-reineke/lsp-format.nvim',
        'b0o/schemastore.nvim',
      }
    }),
    not_vscode_plugin({'norcalli/nvim-colorizer.lua',
      config = function() require('plugins.colorizer') end
    }),
    not_vscode_plugin({'nvim-telescope/telescope.nvim',
      event = 'VeryLazy',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
      },
      config = function() require('plugins.telescope') end
    }),
    not_vscode_plugin({'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'}),
    not_vscode_plugin('othree/javascript-libraries-syntax.vim'),
    not_vscode_plugin({'othree/html5.vim', ft = 'html'}),
    {'petobens/poet-v', cond = poetry_exists},
    not_vscode_plugin('plasticboy/vim-markdown'),
    not_vscode_plugin({'radenling/vim-dispatch-neovim', dependencies = 'tpope/vim-dispatch'}),
    not_vscode_plugin('rafamadriz/friendly-snippets'),
    not_vscode_plugin({'ray-x/go.nvim',
      ft = 'go',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'ray-x/guihua.lua',
      },
      config = function() require('plugins.go') end,
    }),
    not_vscode_plugin({'sainnhe/gruvbox-material',
      -- colorscheme should be available immediately when starting nvim
      lazy = false,
      priority = 1000,
      config = function()
        vim.api.nvim_set_var('gruvbox_material_background', 'hard')
        vim.api.nvim_set_var('gruvbox_material_enable_italic', 1)
        vim.api.nvim_set_var('gruvbox_material_palette', 'original')
        vim.api.nvim_exec([[ colorscheme gruvbox-material ]], false)
      end,
    }),
    not_vscode_plugin({'saltstack/salt-vim', dependencies = 'Glench/Vim-Jinja2-Syntax'}),
    not_vscode_plugin({'simrat39/rust-tools.nvim',
      ft = 'rust',
      dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-lua/plenary.nvim',
        'mfussenegger/nvim-dap',
      },
    }),
    not_vscode_plugin('slim-template/vim-slim'),
    not_vscode_plugin('tmux-plugins/vim-tmux'),
    not_vscode_plugin('tpope/vim-bundler'),
    not_vscode_plugin('tpope/vim-commentary'),
    not_vscode_plugin('tpope/vim-fugitive'),
    not_vscode_plugin('tpope/vim-obsession'),
    not_vscode_plugin('tpope/vim-rails'),
    not_vscode_plugin('tpope/vim-vinegar'),
    not_vscode_plugin({'vim-test/vim-test',
      config = function() require('plugins.vim-test') end
    }),
    not_vscode_plugin({'windwp/nvim-autopairs',
      event = 'VeryLazy',
      dependencies = 'hrsh7th/nvim-cmp',
      config = function() require('plugins.autopairs') end
    }),
  }, {
    defaults = {
      -- Use versioned plugins when possible
      version = '*',
    }
  })
end

return M
