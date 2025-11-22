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

  vim.keymap.set('n', '<A-t>', ':FloatermToggle<CR>', {noremap = true})
  vim.keymap.set('t', '<A-t>', '<C-\\><C-n>:FloatermToggle<CR>', {noremap = true})

  -- Trouble keymaps
  vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', {noremap = true, desc = 'Diagnostics (Trouble)'})
  vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', {noremap = true, desc = 'Buffer Diagnostics (Trouble)'})
  vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', {noremap = true, desc = 'Symbols (Trouble)'})
  vim.keymap.set('n', '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', {noremap = true, desc = 'LSP Definitions / references / ... (Trouble)'})
  vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', {noremap = true, desc = 'Location List (Trouble)'})
  vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', {noremap = true, desc = 'Quickfix List (Trouble)'})

  -- DAP keymaps
  vim.keymap.set('n', '<F5>', function() require('dap').continue() end, {noremap = true, desc = 'Debug: Continue'})
  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, {noremap = true, desc = 'Debug: Step Over'})
  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, {noremap = true, desc = 'Debug: Step Into'})
  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, {noremap = true, desc = 'Debug: Step Out'})
  vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, {noremap = true, desc = 'Debug: Toggle Breakpoint'})
  vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {noremap = true, desc = 'Debug: Set Conditional Breakpoint'})
  vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, {noremap = true, desc = 'Debug: Open REPL'})
  vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, {noremap = true, desc = 'Debug: Run Last'})
  vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, {noremap = true, desc = 'Debug: Toggle UI'})
end

return misc_keymaps
