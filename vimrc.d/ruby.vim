augroup ruby
  autocmd!
  autocmd FileType ruby,eruby setl tabstop=2 softtabstop=2 shiftwidth=2
augroup END

let g:ruby_debugger_fast_sender = 1
let g:ruby_ident_access_modifier_style = 'indent'
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_use_bundler = 1
let g:rubycomplete_rails = 1
let g:rubycomplexity_medium_limit = 35
let g:rubycomplexity_high_limit = 70

let test#ruby#minitest#executable = 'RAILS_ENV=test bundle exec rake'
