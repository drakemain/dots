-- Colorscheme Configuration
return {
  {
    "sainnhe/everforest",
    enabled = false,
  },
  {
    name = "darkforest",
    dir = vim.fn.stdpath("config") .. "/colors",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("darkforest")
    end,
  },
}
