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
if has("termguicolors")
  set termguicolors
  let g:gruvbox_italic = 1
  let g:gruvbox_contrast_dark = 'hard'
  colorscheme gruvbox
elseif findfile("colors/muzzl.vim", &rtp) == ""
  colorscheme darkblue
else
  colorscheme muzzl
endif

" From: https://bitbucket.org/sjl/dotfiles/src/e6f6389/vim/vimrc#cl-233
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Redraw via keyboard shortcut
map <Leader>r :redraw!<CR>

" Shortcut to copy/paste from OS registers
map <Leader>y "+y
map <Leader>Y "+Y
map <Leader>p "+p
map <Leader>P "+P

if !has('gui_running')
  set title
endif

" language-specific

"" CoffeeScript
augroup coffeescript
  autocmd!
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"" HTML
if executable('xmllint')
  map <Leader>h !xmllint --format --html -<CR>
endif

"" JavaScript
augroup javascript
  autocmd!
  autocmd FileType javascript,json setl tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"" Python: jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#autocompletion_command = "<C-J>"

"" Ruby: see vimrc.d/ruby.vim

"" Rust: see vimrc.d/rust.vim

"" SCSS
augroup scss
  autocmd!
  autocmd BufNewFile,BufReadPost *.scss setl tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"" JSON

" Used in visual mode - from http://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
map <Leader>j !python -m json.tool<CR>

"" Markdown/RsT/plaintext
augroup text
  autocmd!
  autocmd BufNewFile,BufReadPost *.md,*.rst,*.txt setl spell colorcolumn=100 textwidth=100 linebreak
augroup END

"" VimScript

augroup vimscript
  autocmd!
  autocmd BufNewFile,BufReadPost *.vim setl tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"" XML
if executable('xmllint')
  map <Leader>x !xmllint --format -<CR>
endif

"" YAML
augroup yaml
  autocmd!
  autocmd BufNewFile,BufReadPost *.yml setl tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"" SQL

let g:sql_type_default = 'postgresql'

"" Shell

let g:is_bash = 1

""" .env-*
autocmd BufRead,BufNewFile .env-* setfiletype sh

"" Sieve
autocmd BufRead,BufNewFile *.sieve setfiletype sieve

"" Underscore templates
let g:uscore_tpl_eval_start = '\[%'
let g:uscore_tpl_eval_end = '%\]'
let g:uscore_tpl_interpolate_start = '\[\['
let g:uscore_tpl_interpolate_end = '\]\]'
let g:uscore_tpl_escape_start = '\[%-'
let g:uscore_tpl_escape_end = '%\]'

" riv.vim
let g:riv_rst2html_args = '--syntax-highlight=short'

" indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ack.vim
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
