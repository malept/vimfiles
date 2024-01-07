local plugin = require("plugin_util")

return {
  plugin.not_vscode_plugin({
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
  }),
}
