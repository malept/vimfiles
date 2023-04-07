local this_file = vim.fn.resolve(vim.fn.expand('<sfile>:p'))
local base_path = string.match(this_file, '^(.-)[^/\\]*$')

vim.opt.runtimepath:append(base_path)
package.path = ';' .. base_path .. 'lua/' .. package.path

if vim.fn.exists('g:vscode') == 1 then
  require('vscode')
else
  require('options')
  require('terminal')
end
require('load_lazy')
require('clipboard')
require('reformatter')

vim.api.nvim_exec('runtime! vimrc.d/digraphs.vim', false)
