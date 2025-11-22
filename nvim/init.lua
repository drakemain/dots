-- Drake's Neovim Configuration
-- Organized structure for maintainability

-- Ensure config files are loaded from config dir
package.path = vim.fn.stdpath('config') .. '/lua/?.lua;' .. package.path

-- Load core configuration
require('core.options')      -- Vim options
require('core.autocmds')     -- Autocommands
require('core.keymaps')      -- Keymaps

-- Load Neovide-specific settings
require('neovide').setup()

-- Setup lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
  rocks = { enabled = false },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
