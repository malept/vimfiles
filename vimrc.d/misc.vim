" code style
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set number " line numbers
set smartindent
set formatoptions=tcroqn " see :help fo-table for option explanations

" modeline
set modeline

" search
set hlsearch

" omnicompletion
" From: http://www.vim.org/scripts/script.php?script_id=3172
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
  \ if &omnifunc == "" |
  \   setlocal omnifunc=syntaxcomplete#Complete |
  \ endif
endif

set completeopt+=longest

" ex command customization
set wildmode=longest,list,full

" theme
set background=dark
colorscheme darkblue

" language-specific

"" Ruby: see vimrc.d/ruby.vim

"" Python: jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#autocompletion_command = "<C-J>"

"" Underscore templates
let g:uscore_tpl_eval_start = '\[%'
let g:uscore_tpl_eval_end = '%\]'
let g:uscore_tpl_interpolate_start = '\[\['
let g:uscore_tpl_interpolate_end = '\]\]'

" riv.vim
let g:riv_rst2html_args = '--syntax-highlight=short'

" indent-guides
let g:indent_guides_enable_on_vim_startup = 1
