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

  if vim.fn.exists('g:vscode') == 0 then
    use 'Glench/Vim-Jinja2-Syntax'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'chr4/nginx.vim'
    use 'chrisbra/Recover.vim'
    use {'dhruvasagar/vim-prosession', requires = 'tpope/vim-obsession'}
    use 'editorconfig/editorconfig-vim'
    use 'google/vim-jsonnet'
    use 'hrsh7th/cmp-nvim-lsp'
    use {'hrsh7th/nvim-cmp', requires = {'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp'}}
    use 'jamessan/vim-gnupg'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'neovim/nvim-lspconfig'
    use 'norcalli/nvim-colorizer.lua'
    use 'nvim-lua/plenary.nvim'
    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope-fzy-native.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'othree/javascript-libraries-syntax.vim'
    use 'othree/html5.vim'
    use 'petobens/poet-v'
    use 'plasticboy/vim-markdown'
    use {'radenling/vim-dispatch-neovim', requires = 'tpope/vim-dispatch'}
    use 'ray-x/go.nvim'
    use 'sainnhe/gruvbox-material'
    use {'saltstack/salt-vim', requires = 'Glench/Vim-Jinja2-Syntax'}
    use 'slim-template/vim-slim'
    use 'tmux-plugins/vim-tmux'
    use 'tpope/vim-bundler'
    use 'tpope/vim-commentary'
    use 'tpope/vim-dispatch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-obsession'
    use 'tpope/vim-rails'
    use 'tpope/vim-vinegar'
    use 'vim-test/vim-test'
    use 'windwp/nvim-autopairs'
  end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
