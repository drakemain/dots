-- Editor Enhancement Plugins
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {'nvim-lua/plenary.nvim'},
    cmd = "Telescope",
    config = function()
      require('telescope').setup({})
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require('Comment').setup({
        padding = true,
        sticky = true,
        toggler = {
          line = '<leader>cl',
          block = '<leader>cc',
        }
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "voldikss/vim-floaterm",
    cmd = "FloatermNew",
  },

  -- Dependencies
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "tpope/vim-sleuth" },
}
