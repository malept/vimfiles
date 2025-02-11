local plugin = require("plugin_util")

local pick_win_config = function()
  local height = math.floor(0.618 * vim.o.lines)
  local width = math.floor(0.618 * vim.o.columns)
  return {
    anchor = "NW",
    height = height,
    width = width,
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end

local setup = function()
  require("mini.align").setup()
  if plugin.no_vscode() then
    require("mini.comment").setup()
    -- mini.completion is very minimal, so using blink.cmp instead
    local extra = require("mini.extra")
    local misc = require("mini.misc")
    misc.setup()
    -- Zen mode
    vim.keymap.set("n", "<Leader>zm", misc.zoom, { silent = true })
    local pick = require("mini.pick")
    -- Centered on screen
    pick.setup({ window = { config = pick_win_config } })
    vim.keymap.set("n", "<C-p>", pick.builtin.files, { silent = true })
    vim.keymap.set("n", "<Leader>Gb", extra.pickers.git_branches, { silent = true })
    -- mini.sessions doesn't handle auto sessions very well
  end
  -- mini.pairs only works on single characters, so using nvim-autopairs instead
  -- mini.surround isn't vim-surround compatible, so using nvim-surround instead
  require("mini.trailspace").setup()
end

return {
  { "echasnovski/mini.nvim", config = setup },
}
