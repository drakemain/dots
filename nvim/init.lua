-- ensure config files are loaded from config dir
package.path = vim.fn.stdpath('config') .. '/lua/?.lua;' .. package.path

-- Initialization
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showcmd = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'auto'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 1000
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.bo.syntax = 'on'
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.have_nerd_font = true
vim.opt.list = true
vim.opt.listchars = {
  trail = '~',
  tab = '»·',
  extends = '>',
  precedes = '<',
  nbsp = '␣'
}

-- Incremental (insert), relative (normal, visual) line numbering
vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = "numbertoggle",
  pattern = "*",
  callback = function() vim.wo.relativenumber = true end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = "numbertoggle",
  pattern = "*",
  callback = function() vim.wo.relativenumber = false end,
})

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ls_config = require('ls')
require("lazy").setup({
  {"folke/tokyonight.nvim"},
  {"sainnhe/everforest"},
  --[[ {"voldikss/vim-floaterm"}, ]]
  {"tpope/vim-sleuth"},
  {"lewis6991/gitsigns.nvim"},
  {"nvim-lualine/lualine.nvim"},
  {"nvim-tree/nvim-web-devicons"},
  {"nvim-lua/plenary.nvim"},
  {"akinsho/git-conflict.nvim", config = true},
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function() print("Hello from Telescope Config!") end
  },
  {"flazz/vim-colorschemes"},
  --{"kyazdani42/nvim-web-devicons"},
  {"nvim-tree/nvim-tree.lua"},
  {
    "numToStr/Comment.nvim",
    --[[ config =  ]]
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = ls_config.lspconfig.dependencies,
    config = ls_config.lspconfig.config,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = ls_config.nvim_cmp.dependencies,
    event = "InsertEnter",
    config = ls_config.nvim_cmp.config
  },
})

-- plugin setup
require('nvim-tree').setup()
require('gitsigns').setup({})
require('telescope').setup({})
require('Comment').setup({
  padding = true,
  sticky = true,
  toggler = {
    line = '<leader>cl',
    block = '<leader>cc',
  }
})

-- local setup
require('neovide').setup()
require('theme').setup()
require('statusline').setup()
require('misc_keymaps').setup()
