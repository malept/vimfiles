local plugin = require("plugin_util")

local setup = function()
  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "lazydev" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }),
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
  })

  local lsp = require("lspconfig")
  local lsp_set_keymaps = function(bufnum)
    local function buf_set_keymap(binding, lua_fn, desc)
      local opts = { buffer = bufnum, desc = desc }
      vim.keymap.set("n", binding, lua_fn, opts)
    end
    buf_set_keymap("gD", vim.lsp.buf.declaration, "[G]o to [Definition]")
    buf_set_keymap("K", vim.lsp.buf.hover, "Hover documentation")
    buf_set_keymap("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")
    -- Telescope based
    local tsbuiltin = require("telescope.builtin")
    buf_set_keymap("gd", tsbuiltin.lsp_definitions, "Select definition")
    buf_set_keymap("gi", tsbuiltin.lsp_implementations, "Select implementation")
    buf_set_keymap("gr", tsbuiltin.lsp_references, "Select reference")
  end
  local lsp_on_attach = function(_, bufnum)
    lsp_set_keymaps(bufnum)
  end
  local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lsp_setup = {
    capabilities = lsp_capabilities,
    on_attach = lsp_on_attach,
  }
  local lang_servers = { "cssls", "eslint", "html", "solargraph", "tsserver", "vimls" }
  for _, ls in ipairs(lang_servers) do
    lsp[ls].setup(lsp_setup)
  end

  if vim.fn.executable("gopls") == 1 then
    lsp.gopls.setup(lsp_setup)
  end

  if vim.fn.executable("lua-language-server") == 1 then
    lsp.lua_ls.setup(lsp_setup)
  end

  if vim.fn.executable("pylsp") == 1 then
    lsp.pylsp.setup(lsp_setup)
  elseif vim.fn.executable("pyright") == 1 then
    lsp.pyright.setup(lsp_setup)
  end

  lsp.jsonls.setup({
    capabilities = lsp_capabilities,
    on_attach = lsp_on_attach,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
  require("rust-tools").setup({
    server = {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = lsp_on_attach,
    },
  })
end

return {
  plugin.not_vscode_plugin({
    "folke/lazydev.nvim",
    ft = "lua",
  }),
  plugin.not_vscode_plugin({
    "hrsh7th/nvim-cmp",
    version = nil, -- this plugin does not make releases
    branch = "main",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "neovim/nvim-lspconfig",
      "simrat39/rust-tools.nvim",
    },
    config = setup,
  }),
  plugin.not_vscode_plugin({
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      local vscode = require("luasnip.loaders.from_vscode")
      vscode.lazy_load()
      -- luacheck: no max line length
      -- From: https://github.com/rstacruz/vimfiles/blob/b27eb86c44f2e16d50ed436974f5641565b60680/plugins/luasnip_codesnippets_loader/lua/luasnip_codesnippets_loader.lua#L4-L11
      local snippet_paths =
        vim.split(vim.fn.glob(vim.fn.getcwd() .. "/.vscode/*.code-snippets"), "\n", { trimempty = true })
      for _, snippet_path in ipairs(snippet_paths) do
        vscode.load_standalone({ path = snippet_path })
      end
      require("luasnip").filetype_extend("ruby", { "rails" })
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  }),
  plugin.not_vscode_plugin({ "neovim/nvim-lspconfig", dependencies = {
    "b0o/schemastore.nvim",
  } }),
}
