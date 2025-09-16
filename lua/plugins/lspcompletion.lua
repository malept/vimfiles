local plugin = require("plugin_util")

return {
  plugin.not_vscode_plugin({
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      debug = true,
    },
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
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        on_attach = function(_, bufnum)
          local function buf_set_keymap(binding, lua_fn, desc)
            vim.keymap.set("n", binding, lua_fn, { buffer = bufnum, desc = desc })
          end
          buf_set_keymap("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
          -- Picker
          local function lsp_picker(scope)
            return function()
              require("mini.extra").pickers.lsp({ scope = scope })
            end
          end
          buf_set_keymap("grr", lsp_picker("references"), "[g]o to [r]eferences")
        end,
      })
      local lang_servers = { "cssls", "eslint", "html", "ts_ls", "vimls" }
      for _, ls in ipairs(lang_servers) do
        vim.lsp.config(ls, {})
        vim.lsp.enable(ls)
      end

      if vim.fn.executable("gopls") == 1 then
        vim.lsp.config("gopls", {})
        vim.lsp.enable("gopls")
      end

      if vim.fn.executable("lua-language-server") == 1 then
        vim.lsp.config("lua_ls", {})
        vim.lsp.enable("lua_ls")
      end

      if vim.fn.executable("jinja-lsp") == 1 then
        vim.lsp.config("jinja_lsp", {})
        vim.lsp.enable("jinja_lsp")
      end

      if vim.fn.executable("pylsp") == 1 then
        vim.lsp.config("pylsp", {})
        vim.lsp.enable("pylsp")
      end

      if vim.fn.executable("taplo") == 1 then
        vim.lsp.config("taplo", {})
        vim.lsp.enable("taplo")
      end

      if vim.fn.executable("yaml-language-server") == 1 then
        vim.lsp.config("yamlls", {
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
        vim.lsp.enable("yamlls")
      end

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
      vim.lsp.enable("jsonls")

      vim.lsp.config("rust-analyzer", {})
    end,
  }),
}
