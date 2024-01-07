-- Copy/paste shortcuts
for k in pairs({ "y", "Y", "p", "P" }) do
	vim.keymap.set("", string.format("<Leader>%s", k), string.format([["+%s]], k))
end

-- WSL clipboard, see:
-- https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
if vim.fn.executable("win32yank.exe") == 1 then
	vim.opt.clipboard = "unnamedplus"
end
