-- LSP and Completion Plugins
return {
  -- Mason for installing LSP servers and tools
  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require('mason-tool-installer').setup({
        -- Only install lua-language-server via Mason
        -- clangd and stylua are installed system-wide
        ensure_installed = { 'lua-language-server' }
      })
    end,
  },

  -- Fidget for LSP progress notifications
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

  -- Native LSP configuration (Neovim 0.11+)
  {
    "hrsh7th/cmp-nvim-lsp",
    config = function()
      -- Get capabilities from nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Global LSP configuration for all servers
      vim.lsp.config('*', {
        capabilities = capabilities,
        root_markers = { '.git' },
      })

      -- Clangd configuration (uses system-installed clangd)
      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--background-index' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
        root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git' },
      })

      -- Lua language server configuration
      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', '.git' },
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          }
        }
      })

      -- Enable the language servers
      vim.lsp.enable({ 'clangd', 'lua_ls' })

      -- LSP attach callback
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfigOnAttach', { clear = true }),
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
          -- Only clear if the group exists
          local ok = pcall(vim.api.nvim_get_autocmds, { group = 'kickstart-lsp-highlight', buffer = detach_event.buf })
          if ok then
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = detach_event.buf }
          end
        end,
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
