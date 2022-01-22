local packer_plugin = require('plugins.packer')

packer_plugin.ensure_installed()

return require('packer').startup(function(use)
  packer_plugin.common(use)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
