" code style
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set number " line numbers
set smartindent
set formatoptions=tcroqn " see :help fo-table for option explanations

" directories
" From: https://bitbucket.org/sjl/dotfiles/src/e6f6389e598f/vim/vimrc#cl-198
set undodir=~/.local/share/vim/undo/
set backupdir=~/.local/share/vim/backup/
"" swap files
set directory=~/.local/share/vim/swap/

"" session dir for vim-prosession
let g:prosession_dir = '~/.local/share/vim/session/'

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
if !exists("g:vscode")
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

" WSL clipboard, see:
" https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
if executable('win32yank.exe')
  set clipboard=unnamedplus
endif

if !has('gui_running')
  set title
endif

" character indicators
set list
set listchars=tab:»\ ,nbsp:⎵

" language-specific

"" CoffeeScript
augroup coffeescript
  autocmd!
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
augroup END

"" HTML
if executable('xmllint')
  map <Leader>h !xmllint --format --html -<CR>
endif

"" JavaScript/JSON/TypeScript
augroup javascript
  autocmd!
  autocmd BufWritePre *.js,*.ts undojoin | Neoformat
augroup END

"" Python: jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#autocompletion_command = "<C-J>"

"" Ruby: see vimrc.d/ruby.vim

"" Rust: see vimrc.d/rust.vim

"" JSON

augroup python
  autocmd!
  autocmd BufNewFile,BufReadPost *.py setl tabstop=4 softtabstop=4 shiftwidth=4
augroup END
" Used in visual mode - from http://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
map <Leader>j !python -m json.tool<CR>

"" Markdown/RsT/plaintext
augroup text
  autocmd!
  autocmd BufNewFile,BufReadPost *.md,*.rst,*.txt setl spell colorcolumn=100 textwidth=100 linebreak
augroup END

"" XML
if executable('xmllint')
  map <Leader>x !xmllint --format -<CR>
endif

"" SQL

let g:sql_type_default = 'postgresql'

"" Shell

let g:is_bash = 1

" Make current file executable
map <Leader>X !chmod +x %<CR>

""" .env-*
autocmd BufRead,BufNewFile .env-*,.env.* setfiletype sh

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

if !has('nvim-0.5')
  " Neomake
  "" Based on the Neomake README
  function! NeomakeOnBattery()
    if has('macunix')
      return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
    elseif has('unix')
      let ac_file = '/sys/class/power_supply/AC/online'
      return filereadable(ac_file) && readfile(ac_file) == ['0']
    endif

    return 0
  endfunction

  if NeomakeOnBattery()
    call neomake#configure#automake('w')
  else
    call neomake#configure#automake('nw', 1000)
  endif

  if executable($PWD . "/node_modules/.bin/eslint")
    let g:neomake_javascript_eslint_exe = $PWD . "/node_modules/.bin/eslint"
  endif
  if executable($PWD . "/node_modules/.bin/standard")
    let g:neomake_javascript_standard_exe = $PWD . "/node_modules/.bin/standard"
  endif
  if executable($PWD . "/node_modules/.bin/tsc")
    let g:neomake_typescript_tsc_exe = $PWD . "/node_modules/.bin/tsc"
  endif
  if executable($PWD . "/node_modules/.bin/tslint")
    let g:neomake_typescript_tslint_exe = $PWD . "/node_modules/.bin/tslint"
  endif
endif

" Neoformat

if executable($PWD . "/node_modules/.bin/prettier")
  let g:neoformat_javascript_localprettier = {
    \ 'exe': $PWD . "/node_modules/.bin/prettier",
    \ 'args': ['--stdin', '--stdin-filepath', '"%:p"'],
    \ 'stdin': 1,
  \ }
  let g:neoformat_enabled_javascript = ['localprettier']

  let g:neoformat_typescript_localprettier = {
    \ 'exe': $PWD . "/node_modules/.bin/prettier",
    \ 'args': ['--stdin', '--stdin-filepath', '"%:p"', '--parser', 'typescript'],
    \ 'stdin': 1
  \ }
  let g:neoformat_enabled_typescript = ['localprettier']
endif

"" shfmt
if executable($PWD . "/scripts/shfmt.sh")
  let g:neoformat_shell_localshfmt = {
    \ 'exe': $PWD . "/scripts/shfmt.sh",
    \ 'args': [],
    \ 'stdin': 1
  \ }
  let g:neoformat_enabled_sh = ['localshfmt']
else
  let g:shfmt_opt = "-i 2"
endif

" Skim
if executable('sk')
  nnoremap <C-p> :Files<CR>
endif
