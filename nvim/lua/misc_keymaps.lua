local misc_keymaps = {}

function misc_keymaps.setup()
  vim.keymap.set('n', '<C-p>', function()
    require('telescope.builtin').find_files()
  end, {silent = true,  noremap = true})
  vim.keymap.set('n', '<C-g>', function()
    require('telescope.builtin').live_grep()
  end, {silent = true,  noremap = true})
  vim.keymap.set('n', '<C-t>', ':tabnew<CR>', {silent = true,  noremap = true})
  vim.keymap.set('n', '<A-1>', ':tabmove -<CR>', {silent = true,  noremap = true})
  vim.keymap.set('n', '<A-3>', ':tabmove +<CR>', {silent = true,  noremap = true})
  vim.keymap.set('n', '<A-q>', 'gT', {silent = true, noremap = true})
  vim.keymap.set('n', '<A-e>', 'gt', {silent = true, noremap = true})
  vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
  vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', {noremap = true})
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', {noremap = true})
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {noremap = true})
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {noremap = true})
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', {noremap = true})

  vim.keymap.set('n', '<A-t>', ':FloatermNew<CR>', {noremap = true})
end

return misc_keymaps
