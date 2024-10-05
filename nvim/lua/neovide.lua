local neovide = {}

function set_keymaps()
    vim.keymap.set('n', '<C-+>', IncrementNeovideScaleFactor, {noremap = true})
    vim.keymap.set('n', '<C-_>', DecrementNeovideScaleFactor, {noremap = true})
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {noremap = true})
end

function IncrementNeovideScaleFactor()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  print(string.format("GUI Scale: %s", vim.g.neovide_scale_factor))
end

function DecrementNeovideScaleFactor()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  print(string.format("GUI Scale: %s", vim.g.neovide_scale_factor))
end

function neovide.setup()
  if vim.g.neovide then
    vim.o.guifont = "DejaVu Sans Mono:h21"
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 3.0
    vim.g.neovide_floating_blur_amount_y = 1.0

    set_keymaps()
  end
end

return neovide
