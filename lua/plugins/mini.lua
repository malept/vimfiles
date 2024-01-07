local plugin = require("plugin_util")

local setup = function()
	require("mini.align").setup()
	if plugin.no_vscode() then
		require("mini.comment").setup()
	end
	-- mini.completion is very minimal, so using nvim-cmp instead
	-- mini.pairs only works on single characters, so using nvim-autopairs instead
	-- mini.sessions doesn't handle auto sessions very well
	-- mini.surround isn't vim-surround compatible, so using nvim-surround instead
	require("mini.trailspace").setup()
end

return {
	{ "echasnovski/mini.nvim", config = setup },
}
