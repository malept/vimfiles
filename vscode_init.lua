local this_file = vim.fn.resolve(vim.fn.expand('<sfile>:p'))
local base_path = string.match(this_file, '^(.-)[^/\\]*$')

vim.opt.runtimepath:append(base_path)
package.path = ';' .. base_path .. 'lua/' .. package.path

require('vscode.packer')
require('clipboard')
require('reformatter')
require('vscode')

vim.api.nvim_exec('runtime! vimrc.d/digraphs.vim', false)
