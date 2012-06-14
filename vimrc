" Pathogen!
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
Helptags

" code style
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set number " line numbers
set smartindent

" highlighting
syntax on
filetype plugin indent on
set hlsearch

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" theme
set background=dark
colorscheme darkblue
