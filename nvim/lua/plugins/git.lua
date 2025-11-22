-- Git Plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require('gitsigns').setup({})
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gvdiffsplit" },
  },

  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = true,
  },
}
