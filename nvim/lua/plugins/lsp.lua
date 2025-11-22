-- LSP and Completion Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {"williamboman/mason.nvim", config = true},
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup({
            notification = {
              window = {
                avoid = { 'NvimTree' }
              }
            }
          })
        end
      },
    },
    config = function()
      -- Language servers
      local language_servers = {
        clangd = {},
        lua_ls = {
          diagnostics = {globals = {'vim'}},
          workspace = {library = vim.api.nvim_get_runtime_file("", true)}
        },
      }

      -- LSP attach callback
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfigOnAttach', {clear=true}),
        callback = function(attach_event)
          _G.setup_lsp_keymaps(attach_event.buf)

          -- Highlight matching symbols on hover
          local client = vim.lsp.get_client_by_id(attach_event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = attach_event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = attach_event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Handle detach event
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('UserLspConfigOnDetach', { clear = true }),
        callback = function(detach_event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = detach_event.buf }
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local ensure_installed = vim.tbl_keys(language_servers or {})
      vim.list_extend(ensure_installed, {'stylua'})

      require('mason').setup()
      require('mason-tool-installer').setup({
        ensure_installed = ensure_installed
      })
      require('mason-lspconfig').setup({
        automatic_installation = true,
        handlers = {
          function(server_name)
            -- Skip rust_analyzer - it's handled by rustaceanvim
            if server_name == "rust_analyzer" then
              return
            end

            local server = language_servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end
        }
      })
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      -- Configure rust-analyzer via rustaceanvim
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- Call the global LSP keymaps setup
            _G.setup_lsp_keymaps(bufnr)
          end,
          settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = { "target", ".git" },
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
            },
          },
        },
      }
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer"
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-j>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ['<C-k>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          ['<C-y>'] = function(fallback)
            if cmp.visible() then
              cmp.confirm({select = true})
            else
              fallback()
            end
          end
        },
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
        {
          { name = 'buffer' },
        })
      })
    end,
  },
}
