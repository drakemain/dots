local theme = {}

function theme.setup()
  vim.cmd.colorscheme("tokyonight")
  vim.opt.background = "dark"
  vim.opt.termguicolors = true
end

return theme
