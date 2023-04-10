return {
  {'dstein64/vim-startuptime', cmd = 'StartupTime'},
  'godlygeek/tabular',
  {'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function() require('nvim-surround').setup() end
  },
  {'preservim/vim-wordy', event = 'VeryLazy'},
  'takac/vim-hardtime',
  {'tpope/vim-projectionist', event = 'VeryLazy'},
}
