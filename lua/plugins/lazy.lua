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

M.setup = function ()
  require('lazy').setup({
    -- Editor-agnostic
    'dstein64/vim-startuptime',
    {'echasnovski/mini.nvim',
      branch = 'stable',
      config = function() require('plugins.mini') end
    },
    'godlygeek/tabular',
    {'kylechui/nvim-surround',
      tag = "*",
      config = function() require('nvim-surround').setup() end
    },
    'preservim/vim-wordy',
    'takac/vim-hardtime',
    'tpope/vim-projectionist',

    -- Non-vscode
    {'Glench/Vim-Jinja2-Syntax', cond = no_vscode},
    {'JoosepAlviste/nvim-ts-context-commentstring',
      cond = no_vscode,
      dependencies = 'nvim-treesitter/nvim-treesitter',
      config = function() require('plugins.treesitter') end
    },
    {'b0o/schemastore.nvim', cond = no_vscode},
    {'chr4/nginx.vim', cond = no_vscode},
    {'chrisbra/Recover.vim', cond = no_vscode},
    {'dhruvasagar/vim-prosession',
      cond = no_vscode,
      dependencies = 'tpope/vim-obsession'
    },
    {'editorconfig/editorconfig-vim', cond = no_vscode},
    {'google/vim-jsonnet', cond = no_vscode},
    {'hrsh7th/nvim-cmp',
    cond = no_vscode,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'neovim/nvim-lspconfig',
      'simrat39/rust-tools.nvim',
    },
    config = function() require('plugins.lspcompletion') end
      },
      {'hrsh7th/vim-vsnip', cond = no_vscode},
      {'hrsh7th/cmp-nvim-lsp', cond = no_vscode},
      {'hrsh7th/cmp-vsnip',
      cond = no_vscode,
      dependencies = 'hrsh7th/nvim-cmp'
    },
    {'jamessan/vim-gnupg', cond = no_vscode},
    {'lukas-reineke/indent-blankline.nvim',
    cond = no_vscode,
    config = function() require('plugins.indent_blankline') end
      },
      {'lukas-reineke/lsp-format.nvim',
      cond = no_vscode,
      config = function() require('lsp-format').setup {} end
    },
    {'mfussenegger/nvim-dap',
    cond = no_vscode,
    config = function() require('plugins.dap') end
      },
      {'nvim-neotest/neotest',
      cond = no_vscode,
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
    },
    {'nvim-neotest/neotest-vim-test',
    cond = no_vscode,
    requires = 'vim-test/vim-test'
      },
      {'neovim/nvim-lspconfig',
      cond = no_vscode,
      dependencies = {
        'lukas-reineke/lsp-format.nvim',
        'b0o/schemastore.nvim',
      }
    },
    {'norcalli/nvim-colorizer.lua',
    cond = no_vscode,
    config = function() require('plugins.colorizer') end
      },
      {'nvim-telescope/telescope.nvim',
      cond = no_vscode,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'telescope-fzy-native.nvim',
      },
      config = function() require('plugins.telescope') end
    },
    {'nvim-telescope/telescope-fzy-native.nvim', cond = no_vscode},
    {'nvim-treesitter/nvim-treesitter',
    cond = no_vscode,
    build = ':TSUpdate',
      },
      {'othree/javascript-libraries-syntax.vim', cond = no_vscode},
      {'othree/html5.vim', cond = no_vscode},
      {'petobens/poet-v', cond = poetry_exists},
      {'plasticboy/vim-markdown', cond = no_vscode},
      {'radenling/vim-dispatch-neovim',
      cond = no_vscode,
      requires = 'tpope/vim-dispatch',
    },
    {'rafamadriz/friendly-snippets', cond = no_vscode},
    {'ray-x/go.nvim',
    cond = no_vscode,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'ray-x/guihua.lua',
    },
    config = function() require('plugins.go') end,
      },
      {'sainnhe/gruvbox-material',
      cond = no_vscode,
      config = function()
        vim.api.nvim_set_var('gruvbox_material_background', 'hard')
        vim.api.nvim_set_var('gruvbox_material_enable_italic', 1)
        vim.api.nvim_set_var('gruvbox_material_palette', 'original')
        vim.api.nvim_exec([[ colorscheme gruvbox-material ]], false)
      end,
    },
    {'saltstack/salt-vim',
    cond = no_vscode,
    dependencies = 'Glench/Vim-Jinja2-Syntax',
      },
      {'simrat39/rust-tools.nvim',
      cond = no_vscode,
      dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-lua/plenary.nvim',
        'mfussenegger/nvim-dap',
      },
    },
    {'slim-template/vim-slim', cond = no_vscode},
    {'tmux-plugins/vim-tmux', cond = no_vscode},
    {'tpope/vim-bundler', cond = no_vscode},
    {'tpope/vim-commentary', cond = no_vscode},
    {'tpope/vim-dispatch', cond = no_vscode},
    {'tpope/vim-fugitive', cond = no_vscode},
    {'tpope/vim-obsession', cond = no_vscode},
    {'tpope/vim-rails', cond = no_vscode},
    {'tpope/vim-vinegar', cond = no_vscode},
    {'vim-test/vim-test',
    cond = no_vscode,
    config = function() require('plugins.vim-test') end
      },
      {'windwp/nvim-autopairs',
      cond = no_vscode,
      dependencies = 'hrsh7th/nvim-cmp',
      config = function() require('plugins.autopairs') end
    },
  })
end

return M
