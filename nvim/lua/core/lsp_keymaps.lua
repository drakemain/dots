local M = {}

function M.attach(bufnr)
  local map = function(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { buffer = bufnr, noremap = true, desc = 'LSP: ' .. desc })
  end
  local t = require('telescope.builtin')

  map('<leader>jd', t.lsp_definitions,      '[J]ump to [d]efinition')
  map('<leader>jr', t.lsp_references,       '[J]ump to [r]eferences')
  map('<leader>ji', t.lsp_implementations,  '[J]ump to [i]mplementations')
  map('<leader>gt', t.lsp_type_definitions, '[G]et to [t]ype')
  map('<leader>gs', t.lsp_document_symbols, '[G]et to [s]ymbols')
  map('<leader>rn', vim.lsp.buf.rename,     '[R]e[n]ame')
  map('<leader><space>', vim.lsp.buf.hover, 'Hover docs')
end

return M
