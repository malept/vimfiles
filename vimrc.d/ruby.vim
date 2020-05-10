let g:ruby_debugger_fast_sender = 1
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_assignment_style = 'variable'
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_use_bundler = 1
let g:rubycomplete_rails = 1

let test#ruby#minitest#executable = 'RAILS_ENV=test bundle exec rake'
