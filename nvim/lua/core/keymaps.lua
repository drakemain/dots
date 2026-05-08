-- Non-plugin keymaps. Plugin-specific bindings live in each plugin's spec under lua/plugins/.
local map = vim.keymap.set

-- General
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true })

-- Tabs
map('n', '<C-t>', ':tabnew<CR>',     { silent = true, noremap = true, desc = 'New Tab' })
map('n', '<A-1>', ':tabmove -<CR>',  { silent = true, noremap = true, desc = 'Tab Move Left' })
map('n', '<A-3>', ':tabmove +<CR>',  { silent = true, noremap = true, desc = 'Tab Move Right' })
map('n', '<A-q>', 'gT',              { silent = true, noremap = true, desc = 'Prev Tab' })
map('n', '<A-e>', 'gt',              { silent = true, noremap = true, desc = 'Next Tab' })

-- Diagnostics (vim builtin — independent of any LSP plugin)
map('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, desc = 'Open Diagnostic Float' })
map('n', '<leader>q', vim.diagnostic.setloclist, { noremap = true, desc = 'Diagnostics to Loclist' })
