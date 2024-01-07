local plugin = require("plugin_util")

local setup = function()
  require("dap.ext.vscode").load_launchjs()
end

return {
  plugin.not_vscode_plugin({ "mfussenegger/nvim-dap", config = setup }),
}
