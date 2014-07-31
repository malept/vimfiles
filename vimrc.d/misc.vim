" code style
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set number " line numbers
set smartindent
set formatoptions=tcroqn " see :help fo-table for option explanations

" directories
" From: https://bitbucket.org/sjl/dotfiles/src/e6f6389e598f/vim/vimrc#cl-198
set undodir=~/.local/share/vim/undo/
set backupdir=~/.local/share/vim/backup/
"" swap files
set directory=~/.local/share/vim/swap/

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

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
if findfile("colors/muzzl.vim", &rtp) == ""
  colorscheme darkblue
else
  colorscheme muzzl
endif

" language-specific

"" Ruby: see vimrc.d/ruby.vim

"" Python: jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#autocompletion_command = "<C-J>"

"" Sieve
autocmd BufRead,BufNewFile *.sieve setfiletype sieve

"" Underscore templates
let g:uscore_tpl_eval_start = '\[%'
let g:uscore_tpl_eval_end = '%\]'
let g:uscore_tpl_interpolate_start = '\[\['
let g:uscore_tpl_interpolate_end = '\]\]'

" riv.vim
let g:riv_rst2html_args = '--syntax-highlight=short'

" indent-guides
let g:indent_guides_enable_on_vim_startup = 1
