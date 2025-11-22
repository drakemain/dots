local theme = {}

function theme.setup()
  -- Configure tokyonight before loading
  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_transparent = vim.g.neovide and true or false
  vim.g.tokyonight_transparent_sidebar = true

  vim.cmd.colorscheme("tokyonight-storm")
  vim.opt.background = "dark"
  vim.opt.termguicolors = true
end

return theme
