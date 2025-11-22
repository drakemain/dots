-- Neovim Options
local opt = vim.opt
local g = vim.g
local wo = vim.wo
local bo = vim.bo

-- General
opt.compatible = false
opt.termguicolors = true
opt.encoding = "utf-8"
g.have_nerd_font = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = 'split'

-- UI
opt.number = true
wo.relativenumber = true
opt.showcmd = true
opt.showmode = false
opt.cursorline = true
opt.scrolloff = 10
opt.signcolumn = 'auto'
opt.laststatus = 2
opt.list = true
opt.listchars = {
  trail = '~',
  tab = '»·',
  extends = '>',
  precedes = '<',
  nbsp = '␣'
}

-- Behavior
opt.backspace = 'indent,eol,start'
opt.clipboard = 'unnamedplus'
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 1000
bo.syntax = 'on'
