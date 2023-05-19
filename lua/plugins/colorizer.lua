local plugin = require('plugin_util')

local setup = function()
  if jit ~= nil then
    require'colorizer'.setup()
  end
end

return {
  plugin.not_vscode_plugin({'norcalli/nvim-colorizer.lua', config = setup}),
}
