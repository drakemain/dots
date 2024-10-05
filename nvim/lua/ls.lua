-- specify desired language servers
local language_servers = {
  clangd = {},
  tsserver = {},
  rust_analyzer = {},
  lua_ls = {
    diagnostics = {globals = {'vim'}},
    workspace = {library = vim.api.nvim_get_runtime_file("", true)}
  },
}

-- Set up keybindings
function LspAttachCallback(attach_event)
  local map = function(key, callback, description)
    vim.keymap.set('n', key, callback, {
      buffer = attach_event.buf,
      desc = 'LS: ' .. description,
      noremap = true
    })
  end

  local telescope = require('telescope.builtin')

  map('<leader>jd', telescope.lsp_definitions, '[J]ump to [d]efinition')
  map('<leader>jr', telescope.lsp_references, '[J]ump to [r]eferences')
  map('<leader>ji', telescope.lsp_implementations, '[J]ump to [i]mplementations')
  map('<leader>gt', telescope.lsp_type_definitions, '[G]et to [t]ype')
  map('<leader>gs', telescope.lsp_document_symbols, '[G]et to [s]ymbols')
  map('<leader>gd', vim.diagnostic.open_float, '[G]et to [d]iagnostic')
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('<leader><space>', vim.lsp.buf.hover, 'Documentation overlay')

  -- highlight matching symbols on hover
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

  -- handle detach event
  vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('UserLspConfigOnDetach', { clear = true }),
    callback = function(detach_event)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = detach_event.buf }
    end,
  })
end

function setup_rust_tools()
  require('rust-tools').setup({})
end

local ls = {
  lspconfig = {
    dependencies = {
      {"williamboman/mason.nvim", config = true},
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {'j-hui/fidget.nvim', opts = {}},
      "simrat39/rust-tools.nvim",
    },

    config = function()
      --[[ vim.lsp.inlay_hint.enable(true) ]]
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfigOnAttach', {clear=true}),
        callback = LspAttachCallback
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
            local server = language_servers[server_name] or {}

            if server_name == 'rust_analyzer' then
              setup_rust_tools()
            end

            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end
        }
      })
    end
  },


  nvim_cmp = {
    dependencies = {
      -- {
      --   "L3MON4D3/LuaSnip",
      --   build = "make install_jsregexp"
      -- },
      -- "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer"
    },

    config = function()
      local cmp = require('cmp')
      -- local luasnip = require('luasnip')

      -- luasnip.config.setup({})
      cmp.setup({
        -- snippet = {
        --   expand = function(args)
        --     require('luasnip').lsp_expand(args.body)
        --   end,
        -- },
        mapping = {
          ['<C-j>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ['<C-k>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
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
          -- { name = 'luasnip' },
          { name = 'path' },
        },
        {
          { name = 'buffer' },
        })
      })
    end
  }
}

return ls
