local plugin = require("plugin_util")

return {
	plugin.not_vscode_plugin({
		"mfussenegger/nvim-lint",
		dependencies = "L3MON4D3/LuaSnip",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			local vscode_settings = require("vscode_settings")
			local lint = require("lint")
			lint.linters_by_ft = {
				go = { "golangcilint" },
				lua = { "luacheck" },
				python = { "ruff" },
				sh = { "shellcheck" },
			}

			local vsc_settings = vscode_settings.load()
			if vsc_settings ~= nil then
				local golangcilint = lint.linters.golangcilint
				if
					vsc_settings["go.alternateTools"] ~= nil
					and vsc_settings["go.alternateTools"]["golangci-lint"] ~= nil
				then
					golangcilint.cmd = vscode_settings.expand(vsc_settings["go.alternateTools"]["golangci-lint"])
				end
				if vsc_settings["shellcheck.customArgs"] ~= nil then
					lint.linters.shellcheck.args = vsc_settings["shellcheck.customArgs"]
				end
			end

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	}),
}
