-- UI Plugins
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Glass panel transparency for statusline (Neovide)
      if vim.g.neovide then
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })
      end

      local function get_filetype_icon()
        local icon, _ = require('nvim-web-devicons').get_icon_by_filetype(vim.bo.ft)
        return icon or ''
      end

      local function get_dir_file()
        local dirname = vim.fn.expand('%:p:h:t')
        local filename = vim.fn.expand('%:t')
        if filename == '' then
          filename = '[No Name]'
        end
        return dirname .. '/' .. filename .. ' ' .. get_filetype_icon()
      end

      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,
          transparent = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            {get_dir_file, cond = function()return vim.bo.ft ~= 'TelescopePrompt' end},
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
            {get_dir_file, cond = function()return vim.bo.ft ~= 'TelescopePrompt' end},
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
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('nvim-tree').setup()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "modern",
      })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {},
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require('colorizer').setup()
    end,
  },
}
