-- code style
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true -- line numbers
vim.opt.smartindent = true
vim.opt.formatoptions = 'tcroqn' -- see :help fo-table for option explanations

vim.opt.modeline = true
vim.opt.hlsearch = true

-- omnicompletion
vim.api.nvim_exec([[ autocmd Filetype * setlocal omnifunc=v:lua.vim.lsp.omnifunc ]], false)

-- # Directories
-- From: https://bitbucket.org/sjl/dotfiles/src/e6f6389e598f/vim/vimrc#cl-198
vim.opt.undodir = vim.fn.expand('~/.local/share/vim/undo/')
vim.opt.backupdir = vim.fn.expand('~/.local/share/vim/backup/')
-- ## Swap files
vim.opt.directory = vim.fn.expand('~/.local/share/vim/swap/')

-- ## Session directory for vim-prosession
vim.g.prosession_dir = vim.fn.expand('~/.local/share/vim/session/')

-- ## Make the folders automatically if they don't already exist.
local dirs = {
  vim.opt.undodir:get()[1],
  vim.opt.backupdir:get()[1],
  vim.opt.directory:get()[1],
  vim.api.nvim_get_var('prosession_dir')
}
for _, dir in ipairs(dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- Recommended by nvim-cmp
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- # EX command customization
vim.opt.wildmode = { 'longest', 'list', 'full' }

-- Theme
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Redraw via keyboard shortcut
vim.keymap.set('', '<Leader>r', [[ :redraw!<CR> ]])

vim.opt.title = true

-- Console mouse support
vim.opt.mouse = 'a'

-- From vim-sensible (left out of neovim defaults, see
-- https://github.com/neovim/neovim/issues/2676)
vim.opt.ruler = true
-- Use <C-L> to clear the highlighting of :set hlsearch.
vim.api.nvim_exec([[
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
  endif
]], false)

-- Character indicators
vim.opt.list = true
vim.opt.listchars = { tab = '» ', nbsp = '⎵' }

-- .env* files
vim.api.nvim_exec([[ autocmd BufRead,BufNewFile .env-*,.env.* setfiletype sh ]], false)

-- editorconfig
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }

-- Python
vim.api.nvim_exec([[
augroup python
  autocmd!
  autocmd BufNewFile,BufReadPost *.py setl tabstop=4 softtabstop=4 shiftwidth=4
augroup END
]], false)
vim.g.poetv_executables = {'poetry'}

-- SQL
vim.g.sql_type_default = 'postgresql'

-- Shell
vim.g.is_bash = 1

-- Make current file executable
vim.keymap.set('', '<Leader>X', [[ !chmod +x %<CR> ]])

-- Ensure that locally installed dictionaries work
vim.opt.runtimepath:append('~/.local/share/nvim/site')

-- inccommand AKA live substitution
vim.opt.inccommand = 'split'

-- neovim-remote
if vim.fn.executable('nvr') == 1 then
  vim.env.EDITOR = 'nvr -cc split --remote-wait'
else
  vim.env.EDITOR = 'nvim'
end

-- python-neovim
local function setup_pynvim(python_bin, venv_dir)
  if vim.fn.isdirectory(venv_dir) == 1 then
    vim.g[string.format('%s_host_prog', python_bin)] = string.format('%s/bin/%s', venv_dir, python_bin)
  end
end
setup_pynvim('python', vim.fn.expand('~/.local/share/virtualenv/neovim'))
setup_pynvim('python3', vim.fn.expand('~/.local/share/virtualenv/neovim3'))
