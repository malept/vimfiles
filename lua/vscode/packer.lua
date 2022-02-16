local packer_plugin = require('plugins.packer')

packer_plugin.ensure_installed()

local packer = require('packer')
local util = require('packer.util')

local site_root = util.join_paths(vim.fn.stdpath('data'), 'vscode', 'site')
vim.opt.packpath:append(site_root)

packer.init({
    package_root = util.join_paths(site_root, 'pack'),
    compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'vscode_packer_compiled.lua'),
})

return packer.startup({
  function(use)
    packer_plugin.common(use)

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  {
    package_root = util.join_paths(vim.fn.stdpath('data'), 'vscode', 'site', 'pack'),
    compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'vscode_packer_compiled.lua'),
  }
})
