-- Configuration specific to https://github.com/vscode-neovim/vscode-neovim

-- vim-commentary/mini.comment emulation
vim.keymap.set({ "x", "n", "o" }, "gc", "<Plug>VSCodeCommentary")
vim.keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine")
