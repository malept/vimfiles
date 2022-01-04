local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('installing packer...', install_path)
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

package.path = package.path .. ';' .. install_path .. '/lua/?.lua'

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'dstein64/vim-startuptime'

  use 'godlygeek/tabular'
  use 'ntpeters/vim-better-whitespace'
  use 'preservim/vim-wordy'
  use 'takac/vim-hardtime'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  if not using_vscode then
    use 'Glench/Vim-Jinja2-Syntax'
    use {'JoosepAlviste/nvim-ts-context-commentstring',
      after = 'nvim-treesitter',
      config = function() require('plugins.treesitter') end
    }
    use 'chr4/nginx.vim'
    use 'chrisbra/Recover.vim'
    use {'dhruvasagar/vim-prosession', requires = 'tpope/vim-obsession'}
    use 'editorconfig/editorconfig-vim'
    use 'google/vim-jsonnet'
    use 'hrsh7th/cmp-nvim-lsp'
    use {'hrsh7th/nvim-cmp',
      after = {
        'nvim-lspconfig',
        'cmp-nvim-lsp'
      },
      config = function() require('plugins.lspcompletion') end
    }
    use 'jamessan/vim-gnupg'
    use {'lukas-reineke/indent-blankline.nvim',
      config = function() require('plugins.indent_blankline') end
    }
    use 'mfussenegger/nvim-dap'
    use 'neovim/nvim-lspconfig'
    use {'norcalli/nvim-colorizer.lua',
      config = function() require('plugins.colorizer') end
    }
    use {'nvim-telescope/telescope.nvim',
      after = 'telescope-fzy-native.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function() require('plugins.telescope') end
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'othree/javascript-libraries-syntax.vim'
    use 'othree/html5.vim'
    use 'petobens/poet-v'
    use 'plasticboy/vim-markdown'
    use {'radenling/vim-dispatch-neovim', requires = 'tpope/vim-dispatch'}
    use {'ray-x/go.nvim',
      after = 'nvim-treesitter',
      config = function() require('plugins.go') end
    }
    use 'sainnhe/gruvbox-material'
    use {'saltstack/salt-vim', requires = 'Glench/Vim-Jinja2-Syntax'}
    use {'simrat39/rust-tools.nvim',
      after = 'nvim-lspconfig',
      requires = {
        'nvim-lua/plenary.nvim',
        'mfussenegger/nvim-dap'
      },
      config = function() require('rust-tools').setup({}) end
    }
    use 'slim-template/vim-slim'
    use 'tmux-plugins/vim-tmux'
    use 'tpope/vim-bundler'
    use 'tpope/vim-commentary'
    use 'tpope/vim-dispatch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-obsession'
    use 'tpope/vim-rails'
    use 'tpope/vim-vinegar'
    use {'vim-test/vim-test',
      config = function() require('plugins.vim-test') end
    }
    use {'windwp/nvim-autopairs',
      after = 'nvim-cmp',
      config = function() require('plugins.autopairs') end
    }
  end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
