return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gvdiffsplit" },
  keys = {
    { "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git Diff Split" },
  },
}
