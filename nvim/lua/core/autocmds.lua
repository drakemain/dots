-- Autocommands

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
