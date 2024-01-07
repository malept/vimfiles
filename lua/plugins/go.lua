local plugin = require("plugin_util")

local setup = function()
	require("go").setup({
		goimport = "gopls", -- if set to 'gopls' will use golsp format
		gofmt = "gopls", -- if set to gopls will use golsp format
		lsp_cfg = false, -- let lspcompletion.lua handle LSP
	})
	-- Import on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").goimport()
		end,
		group = vim.api.nvim_create_augroup("GoImport", {}),
	})
end

return {
	plugin.not_vscode_plugin({
		"ray-x/go.nvim",
		-- last release was 2022-08-09
		version = nil,
		branch = "master",
		cond = function()
			return vim.fn.executable("gopls") == 1
		end,
		event = "CmdlineEnter",
		ft = { "go", "gomod" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"ray-x/guihua.lua",
		},
		config = setup,
	}),
	plugin.not_vscode_plugin({
		"ray-x/guihua.lua",
		-- This plugin has no releases
		version = nil,
		branch = "master",
	}),
}
