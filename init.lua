if vim.fn.exists('g:vscode') == 0 then
  local this_file = vim.fn.resolve(vim.fn.expand('<sfile>:p'))
  local base_path = string.match(this_file, '^(.-)[^/\\]*$')

  vim.opt.runtimepath:append(base_path)
  package.path = ';' .. base_path .. 'lua/' .. package.path

  require('load_packer')
  require('clipboard')
  require('reformatter')
  require('options')
  require('terminal')

  vim.api.nvim_exec('runtime! vimrc.d/digraphs.vim', false)
end
