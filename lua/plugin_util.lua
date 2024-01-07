local M = {}

M.ensure_lazy_installed = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

M.no_vscode = function()
	return vim.g.vscode == nil
end
M.poetry_exists = function()
	return (M.no_vscode() and vim.fn.executable("poetry") == 1)
end
M.older_than_nvim09 = function()
	return (M.no_vscode() and vim.fn.has("nvim-0.9") == 0)
end

M.not_vscode_plugin = function(plugin)
	if type(plugin) == "string" then
		return { plugin, cond = M.no_vscode }
	elseif type(plugin) == "table" then
		plugin.cond = M.no_vscode
		return plugin
	end
end

return M
