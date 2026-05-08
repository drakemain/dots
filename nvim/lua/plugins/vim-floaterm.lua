local function floaterm_toggle()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_option_value('filetype', { buf = buf }) == 'floaterm' then
      vim.cmd('FloatermToggle')
      return
    end
  end
  vim.cmd('FloatermNew')
end

return {
  "voldikss/vim-floaterm",
  cmd = { "FloatermNew", "FloatermToggle" },
  keys = {
    { "<A-t>", floaterm_toggle, mode = "n", desc = "Toggle Terminal" },
    { "<A-t>", "<C-\\><C-n>:FloatermToggle<CR>", mode = "t", desc = "Toggle Terminal" },
  },
}
