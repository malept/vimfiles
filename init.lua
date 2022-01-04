local this_file = vim.fn.resolve(vim.fn.expand('<sfile>:p'))
local base_path = string.match(this_file, '^(.-)[^/\\]*$')

vim.opt.runtimepath:append(base_path)
package.path = ';' .. base_path .. 'lua/' .. package.path

using_vscode = vim.fn.exists('g:vscode') == 1

require('001-packer')
require('clipboard')
require('reformatter')
if using_vscode then
  require('vscode')
else
  require('options')
  require('terminal')
end

vim.api.nvim_exec('runtime! vimrc.d/digraphs.vim', false)
