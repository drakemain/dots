local statusline = {}

function GetDirFile()
  local dirname = vim.fn.expand('%:p:h:t')
  local filename = vim.fn.expand('%:t')
  if filename == '' then
    filename = '[No Name]'
  end
  return dirname .. '/' .. filename .. ' ' .. GetFileTypeIcon()
end

function GetFileTypeIcon()
  local icon, _ = require('nvim-web-devicons').get_icon_by_filetype(vim.bo.ft)
  return icon or ''
end

function statusline.setup()
  vim.opt.laststatus = 2

  require('lualine').setup({
    options = {
      theme = 'auto',
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {
        {GetDirFile, cond = function()return vim.bo.ft ~= 'TelescopePrompt' end},
        'branch',
        'diff'
     },
      lualine_c = {
        'diagnostics',
        function() if vim.bo.modified then return '+' else return '' end end
      },
      lualine_x = {},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {
        {GetDirFile, cond = function()return vim.bo.ft ~= 'TelescopePrompt' end},
      },
      lualine_c = {
      'diagnostics',
      function() if vim.bo.modified then return '+' else return '' end end
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
})
end

return statusline
