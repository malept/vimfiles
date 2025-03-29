local plugin = require("plugin_util")

return {
  plugin.not_vscode_plugin({
    "folke/lazydev.nvim",
    ft = "lua",
  }),
  plugin.not_vscode_plugin({
    "Saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- use a release tag to download pre-built binaries
    version = "v1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "mrcjkb/rustaceanvim",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "enter" },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      -- completion = {
      --   menu = {
      --     auto_show = function(ctx)
      --       return ctx.mode ~= "cmdline" and not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
      --     end,
      --   },
      -- },
    },
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
  plugin.not_vscode_plugin({
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
      "Saghen/blink.cmp",
    },
    config = function()
      local lsp = require("lspconfig")
      local lsp_set_keymaps = function(bufnum)
        local function buf_set_keymap(binding, lua_fn, desc)
          local opts = { buffer = bufnum, desc = desc }
          vim.keymap.set("n", binding, lua_fn, opts)
        end
        buf_set_keymap("gD", vim.lsp.buf.declaration, "[G]o to [Definition]")
        buf_set_keymap("K", vim.lsp.buf.hover, "Hover documentation")
        buf_set_keymap("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")
        -- Picker
        local miniextra = require("mini.extra")
        local function lsp_picker(scope)
          return function()
            miniextra.pickers.lsp({ scope = scope })
          end
        end
        buf_set_keymap("gd", lsp_picker("definition"))
        buf_set_keymap("gi", lsp_picker("implementation"))
        buf_set_keymap("gr", lsp_picker("references"))
      end
      local lsp_on_attach = function(_, bufnum)
        lsp_set_keymaps(bufnum)
      end
      local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
      local lsp_setup = {
        capabilities = lsp_capabilities,
        on_attach = lsp_on_attach,
      }
      local lang_servers = { "cssls", "eslint", "html", "solargraph", "ts_ls", "vimls" }
      for _, ls in ipairs(lang_servers) do
        lsp[ls].setup(lsp_setup)
      end

      if vim.fn.executable("gopls") == 1 then
        lsp.gopls.setup(lsp_setup)
      end

      if vim.fn.executable("lua-language-server") == 1 then
        lsp.lua_ls.setup(lsp_setup)
      end

      if vim.fn.executable("jinja-lsp") == 1 then
        lsp.jinja_lsp.setup(lsp_setup)
      end

      if vim.fn.executable("pylsp") == 1 then
        lsp.pylsp.setup(lsp_setup)
      elseif vim.fn.executable("pyright") == 1 then
        lsp.pyright.setup(lsp_setup)
      end

      if vim.fn.executable("taplo") == 1 then
        lsp.taplo.setup(lsp_setup)
      end

      if vim.fn.executable("yaml-language-server") == 1 then
        lsp.yamlls.setup({
          capabilities = lsp_capabilities,
          on_attach = lsp_on_attach,
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- schemastore.nvim and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        })
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
      vim.g.rustaceanvim = {
        server = lsp_setup,
      }
    end,
  }),
}
