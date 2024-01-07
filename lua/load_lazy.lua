local plugin = require("plugin_util")
plugin.ensure_lazy_installed()
require("lazy").setup("plugins", {
	defaults = {
		-- Use versioned plugins when possible
		version = "*",
	},
})
