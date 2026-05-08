return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<C-p>", function() require('telescope.builtin').find_files() end, desc = "Find Files" },
    { "<C-g>", function() require('telescope.builtin').live_grep() end,  desc = "Live Grep" },
  },
  opts = {},
}
