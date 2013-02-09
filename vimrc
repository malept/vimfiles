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

" search
set hlsearch

" omnicompletion
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest

" ex command customization
set wildmode=longest,list,full

" theme
set background=dark
colorscheme darkblue

" language-specific
let g:ruby_debugger_fast_sender = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplexity_medium_limit = 35
let g:rubycomplexity_high_limit = 70

" slime
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.cache/slime_paste"
