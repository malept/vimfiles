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
set formatoptions=tcroqn " see :help fo-table for option explanations

" highlighting
syntax on
filetype plugin indent on
set hlsearch

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" matching
runtime macros/matchit.vim

" theme
set background=dark
colorscheme darkblue
