return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = function(_, bufnr)
          require('core.lsp_keymaps').attach(bufnr)
        end,
        settings = {
          ["rust-analyzer"] = {
            files = { excludeDirs = { "target", ".git" } },
            cargo = { buildScripts = { enable = true } },
          },
        },
      },
    }
  end,
}
