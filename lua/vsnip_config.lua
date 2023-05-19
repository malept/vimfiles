local M = {}

local buf_ismap = function(bufnum, binding, cmd)
  vim.keymap.set({ 'i', 's' }, binding, cmd, { remap = true, expr = true, buffer = bufnum, replace_keycodes = false })
end

M.buf_config = function(bufnum)
  -- Jump forward or backward
  buf_ismap(bufnum, '<Tab>',   [[ vsnip#jumpable(1)  ? "\<Plug>(vsnip-jump-next)" : "\<Tab>" ]])
  buf_ismap(bufnum, '<S-Tab>', [[ vsnip#jumpable(-1) ? "\<Plug>(vsnip-jump-prev)" : "\<Tab>" ]])
end

return M
