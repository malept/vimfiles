local plugin = require("plugin_util")

return {
  plugin.not_vscode_plugin("Glench/Vim-Jinja2-Syntax"),
  plugin.not_vscode_plugin("b0o/schemastore.nvim"),
  plugin.not_vscode_plugin("chr4/nginx.vim"),
  plugin.not_vscode_plugin({ "chrisbra/Recover.vim", lazy = false }),
  plugin.not_vscode_plugin({
    "dhruvasagar/vim-prosession",
    lazy = false,
    priority = 900,
    dependencies = "tpope/vim-obsession",
  }),
  { "editorconfig/editorconfig-vim", cond = plugin.older_than_nvim09 },
  plugin.not_vscode_plugin("google/vim-jsonnet"),
  plugin.not_vscode_plugin("jamessan/vim-gnupg"),
  plugin.not_vscode_plugin("tadmccorkle/markdown.nvim"),
  plugin.not_vscode_plugin({ "radenling/vim-dispatch-neovim", dependencies = "tpope/vim-dispatch" }),
  plugin.not_vscode_plugin({
    "sainnhe/gruvbox-material",
    -- colorscheme should be available immediately when starting nvim
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_palette = "original"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  }),
  plugin.not_vscode_plugin({ "saltstack/salt-vim", dependencies = "Glench/Vim-Jinja2-Syntax" }),
  plugin.not_vscode_plugin({
    "mrcjkb/rustaceanvim",
    version = "^5", -- recommended by plugin
    lazy = false, -- This plugin is already lazy per docs
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  }),
  plugin.not_vscode_plugin("slim-template/vim-slim"),
  plugin.not_vscode_plugin("tmux-plugins/vim-tmux"),
  plugin.not_vscode_plugin("tpope/vim-bundler"),
  plugin.not_vscode_plugin("tpope/vim-fugitive"),
  plugin.not_vscode_plugin("tpope/vim-rails"),
  plugin.not_vscode_plugin("tpope/vim-vinegar"),
}
