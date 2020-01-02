runtime ../vim/bundle/vim-plug/plug.vim

let s:bundledir = expand("<sfile>:p:h:h") . '/vim/bundle/'

call plug#begin()

function! s:plugify(name, ...)
  let s:pluginpath = s:bundledir . a:name
  if len(a:000) > 0
    call plug#(s:pluginpath, a:000[0])
  else
    call plug#(s:pluginpath)
  endif
endfunction

call s:plugify('ack.vim')
call s:plugify('csv.vim', { 'for': 'csv' })
call s:plugify('gruvbox')
call s:plugify('gtk-vim-syntax')
call s:plugify('hardmode')
call s:plugify('html5.vim')
call s:plugify('javascript-libraries-syntax.vim')
call s:plugify('muzzl.vim')
call s:plugify('neoformat')
call s:plugify('neomake')
call s:plugify('nginx.vim')
call s:plugify('phpfolding.vim', { 'for': 'php' })
call s:plugify('Recover.vim')
call s:plugify('riv.vim')
call s:plugify('rust.vim')
call s:plugify('salt-vim')
call s:plugify('tabular')
call s:plugify('tmux.vim')
call s:plugify('typescript-vim')
call s:plugify('underscore-templates.vim')
call s:plugify('vim-bundler')
call s:plugify('vim-coffee-script')
call s:plugify('vim-commentary')
call s:plugify('vim-css3-syntax')
call s:plugify('vim-css-color')
call s:plugify('vim-dispatch')
call s:plugify('vim-endwise')
call s:plugify('vim-fugitive')
call s:plugify('vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' })
call s:plugify('vim-gnupg')
call s:plugify('vim-haml')
call s:plugify('vim-indent-guides')
call s:plugify('vim-javascript')
call s:plugify('Vim-Jinja2-Syntax')
call s:plugify('vim-json')
call s:plugify('vim-jsx-typescript')
call s:plugify('vim-markdown')
call s:plugify('vim-obsession')
call s:plugify('vim-projectionist')
call s:plugify('vim-rails')
call s:plugify('vim-repeat')
call s:plugify('vim-ruby')
call s:plugify('vim-ruby-refactoring', { 'for': 'ruby' })
call s:plugify('vim-surround')
call s:plugify('vim-test')
call s:plugify('vim-toml')
call s:plugify('vim-trailing-whitespace')
call s:plugify('vim-vala')
call s:plugify('vim-vinegar')
call s:plugify('vim-virtualenv')
call s:plugify('vim-wordy')

if executable('dasht')
  call s:plugify('vim-dasht')
endif

if executable('rvm')
  call s:plugify('vim-rvm')
endif

if has('nvim')
  call s:plugify('deoplete.nvim', { 'do': ':UpdateRemotePlugins' })
  call s:plugify('deoplete-jedi')
  call s:plugify('LanguageClient-neovim', { 'do': 'bash install.sh' })
  call s:plugify('vim-dispatch-neovim')

  if executable('fzy')
    call s:plugify('neovim-fuzzy')
  endif
else
  call s:plugify('jedi-vim')
  call s:plugify('vim-sensible')
end

call plug#end()

unlet s:bundledir
