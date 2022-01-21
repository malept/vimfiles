local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('installing packer...', install_path)
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

package.path = package.path .. ';' .. install_path .. '/lua/?.lua'

return require('packer').startup(function(use)
  local use_without_vscode = function(params)
    -- if vim.fn.exists('g:vscode') == 0 then
    --   use(params)
    -- end
    local not_running_vscode = "vim.fn.exists('g:vscode') == 0"
    if type(params) == 'string' then
      use { params, cond = not_running_vscode }
    else
      params["cond"] = not_running_vscode
      use(params)
    end
  end
  use 'wbthomason/packer.nvim'
  use 'dstein64/vim-startuptime'

  use 'godlygeek/tabular'
  use 'ntpeters/vim-better-whitespace'
  use 'preservim/vim-wordy'
  use 'takac/vim-hardtime'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  use_without_vscode 'Glench/Vim-Jinja2-Syntax'
  use_without_vscode {'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'nvim-treesitter',
    config = function() require('plugins.treesitter') end
  }
  use_without_vscode 'chr4/nginx.vim'
  use_without_vscode 'chrisbra/Recover.vim'
  use_without_vscode {'dhruvasagar/vim-prosession', requires = 'tpope/vim-obsession'}
  use_without_vscode 'editorconfig/editorconfig-vim'
  use_without_vscode 'google/vim-jsonnet'
  use_without_vscode 'hrsh7th/cmp-nvim-lsp'
  use_without_vscode {'hrsh7th/cmp-vsnip',
    after = {
      'nvim-cmp',
      'vim-vsnip',
    }
  }
  use_without_vscode {'hrsh7th/nvim-cmp',
    after = {
      'nvim-lspconfig',
      'cmp-nvim-lsp',
    },
    config = function() require('plugins.lspcompletion') end
  }
  use_without_vscode 'hrsh7th/vim-vsnip'
  use_without_vscode 'jamessan/vim-gnupg'
  use_without_vscode {'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins.indent_blankline') end
  }
  use_without_vscode 'mfussenegger/nvim-dap'
  use_without_vscode 'neovim/nvim-lspconfig'
  use_without_vscode {'norcalli/nvim-colorizer.lua',
    config = function() require('plugins.colorizer') end
  }
  use_without_vscode {'nvim-telescope/telescope.nvim',
    after = 'telescope-fzy-native.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('plugins.telescope') end
  }
  use_without_vscode 'nvim-telescope/telescope-fzy-native.nvim'
  use_without_vscode {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use_without_vscode 'othree/javascript-libraries-syntax.vim'
  use_without_vscode 'othree/html5.vim'
  use_without_vscode 'petobens/poet-v'
  use_without_vscode 'plasticboy/vim-markdown'
  use_without_vscode {'radenling/vim-dispatch-neovim', requires = 'tpope/vim-dispatch'}
  use_without_vscode 'rafamadriz/friendly-snippets'
  use_without_vscode {'ray-x/go.nvim',
    after = 'nvim-treesitter',
    requires = 'ray-x/guihua.lua',
    config = function() require('plugins.go') end,
  }
  use_without_vscode {'sainnhe/gruvbox-material',
  config = function()
    vim.api.nvim_set_var('gruvbox_material_background', 'hard')
    vim.api.nvim_set_var('gruvbox_material_enable_italic', 1)
    vim.api.nvim_set_var('gruvbox_material_palette', 'original')
    vim.api.nvim_exec([[ colorscheme gruvbox-material ]], false)
  end,
  }
  use_without_vscode {'saltstack/salt-vim', requires = 'Glench/Vim-Jinja2-Syntax'}
  use_without_vscode {'simrat39/rust-tools.nvim',
    after = 'nvim-lspconfig',
    requires = {
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap'
    },
    config = function() require('rust-tools').setup({}) end
  }
  use_without_vscode 'slim-template/vim-slim'
  use_without_vscode 'tmux-plugins/vim-tmux'
  use_without_vscode 'tpope/vim-bundler'
  use_without_vscode 'tpope/vim-commentary'
  use_without_vscode 'tpope/vim-dispatch'
  use_without_vscode 'tpope/vim-fugitive'
  use_without_vscode 'tpope/vim-obsession'
  use_without_vscode 'tpope/vim-rails'
  use_without_vscode 'tpope/vim-vinegar'
  use_without_vscode {'vim-test/vim-test',
    config = function() require('plugins.vim-test') end
  }
  use_without_vscode {'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function() require('plugins.autopairs') end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
