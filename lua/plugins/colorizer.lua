local plugin = require("plugin_util")

return {
  plugin.not_vscode_plugin({
    "NVChad/nvim-colorizer.lua",
    cond = function()
      return jit ~= nil
    end,
    main = "colorizer",
    config = true,
  }),
}
