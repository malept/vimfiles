-- Copy/paste shortcuts
for k in pairs({ "y", "Y", "p", "P" }) do
  vim.keymap.set("", string.format("<Leader>%s", k), string.format([["+%s]], k))
end
