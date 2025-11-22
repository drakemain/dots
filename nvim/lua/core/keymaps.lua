-- Keymaps
local map = vim.keymap.set

-- General
map('n', '<Esc>', '<cmd>nohlsearch<CR>', {noremap = true})

-- Navigation
map('n', '<C-t>', ':tabnew<CR>', {silent = true, noremap = true})
map('n', '<A-1>', ':tabmove -<CR>', {silent = true, noremap = true})
map('n', '<A-3>', ':tabmove +<CR>', {silent = true, noremap = true})
map('n', '<A-q>', 'gT', {silent = true, noremap = true})
map('n', '<A-e>', 'gt', {silent = true, noremap = true})

-- File/Buffer Management
map('n', '<C-p>', function() require('telescope.builtin').find_files() end, {silent = true, noremap = true, desc = 'Find Files'})
map('n', '<C-g>', function() require('telescope.builtin').live_grep() end, {silent = true, noremap = true, desc = 'Live Grep'})
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, desc = 'Toggle File Tree'})

-- Terminal
local function floaterm_toggle()
  -- Check if any floaterm buffers exist
  local floaterm_exists = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, 'filetype') == 'floaterm' then
      floaterm_exists = true
      break
    end
  end

  if floaterm_exists then
    vim.cmd('FloatermToggle')
  else
    vim.cmd('FloatermNew')
  end
end

map('n', '<A-t>', floaterm_toggle, {noremap = true, desc = 'Toggle Terminal'})
map('t', '<A-t>', '<C-\\><C-n>:FloatermToggle<CR>', {noremap = true, desc = 'Toggle Terminal'})

-- Diagnostics
map('n', '<leader>e', vim.diagnostic.open_float, {noremap = true, desc = 'Open Diagnostic Float'})
map('n', '<leader>q', vim.diagnostic.setloclist, {noremap = true, desc = 'Set Location List'})

-- Git
map('n', '<leader>gd', ':Gvdiffsplit<CR>', {noremap = true, desc = 'Git Diff Split'})

-- Trouble
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', {noremap = true, desc = 'Diagnostics (Trouble)'})
map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', {noremap = true, desc = 'Buffer Diagnostics (Trouble)'})
map('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', {noremap = true, desc = 'Symbols (Trouble)'})
map('n', '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', {noremap = true, desc = 'LSP Definitions / references / ... (Trouble)'})
map('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', {noremap = true, desc = 'Location List (Trouble)'})
map('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', {noremap = true, desc = 'Quickfix List (Trouble)'})

-- DAP (Debugging)
map('n', '<F5>', function() require('dap').continue() end, {noremap = true, desc = 'Debug: Continue'})
map('n', '<F10>', function() require('dap').step_over() end, {noremap = true, desc = 'Debug: Step Over'})
map('n', '<F11>', function() require('dap').step_into() end, {noremap = true, desc = 'Debug: Step Into'})
map('n', '<F12>', function() require('dap').step_out() end, {noremap = true, desc = 'Debug: Step Out'})
map('n', '<leader>db', function() require('dap').toggle_breakpoint() end, {noremap = true, desc = 'Debug: Toggle Breakpoint'})
map('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {noremap = true, desc = 'Debug: Set Conditional Breakpoint'})
map('n', '<leader>dr', function() require('dap').repl.open() end, {noremap = true, desc = 'Debug: Open REPL'})
map('n', '<leader>dl', function() require('dap').run_last() end, {noremap = true, desc = 'Debug: Run Last'})
map('n', '<leader>du', function() require('dapui').toggle() end, {noremap = true, desc = 'Debug: Toggle UI'})

-- LSP Keymaps (set in autocmd)
function _G.setup_lsp_keymaps(bufnr)
  local telescope = require('telescope.builtin')
  local opts = {buffer = bufnr, noremap = true}

  map('n', '<leader>jd', telescope.lsp_definitions, vim.tbl_extend('force', opts, {desc = 'LSP: [J]ump to [d]efinition'}))
  map('n', '<leader>jr', telescope.lsp_references, vim.tbl_extend('force', opts, {desc = 'LSP: [J]ump to [r]eferences'}))
  map('n', '<leader>ji', telescope.lsp_implementations, vim.tbl_extend('force', opts, {desc = 'LSP: [J]ump to [i]mplementations'}))
  map('n', '<leader>gt', telescope.lsp_type_definitions, vim.tbl_extend('force', opts, {desc = 'LSP: [G]et to [t]ype'}))
  map('n', '<leader>gs', telescope.lsp_document_symbols, vim.tbl_extend('force', opts, {desc = 'LSP: [G]et to [s]ymbols'}))
  map('n', '<leader>ld', vim.diagnostic.open_float, vim.tbl_extend('force', opts, {desc = 'LSP: [L]SP [d]iagnostic'}))
  map('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, {desc = 'LSP: [R]e[n]ame'}))
  map('n', '<leader><space>', vim.lsp.buf.hover, vim.tbl_extend('force', opts, {desc = 'LSP: Documentation overlay'}))
end
