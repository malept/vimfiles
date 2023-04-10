local plugin = require('plugin_util')

local setup = function()
  vim.api.nvim_set_var('test#strategy', 'neovim')
end

return {
  plugin.not_vscode_plugin({'vim-test/vim-test', config = setup}),
}
