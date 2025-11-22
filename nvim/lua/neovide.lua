local neovide = {}

local function IncrementNeovideScaleFactor()
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) + 0.1
  print(string.format("GUI Scale: %s", vim.g.neovide_scale_factor))
end

local function DecrementNeovideScaleFactor()
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) - 0.1
  print(string.format("GUI Scale: %s", vim.g.neovide_scale_factor))
end

local function set_keymaps()
    vim.keymap.set('n', '<C-+>', IncrementNeovideScaleFactor, {noremap = true})
    vim.keymap.set('n', '<C-_>', DecrementNeovideScaleFactor, {noremap = true})
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {noremap = true})
end

function neovide.setup()
  if vim.g.neovide then
    vim.o.guifont = "Iosevka Nerd Font Mono:h21"
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1.0

    -- Dark Forest Glassmorphism
    vim.g.neovide_opacity = 0.75
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 6.0
    vim.g.neovide_floating_blur_amount_y = 6.0
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5

    -- Cursor animations
    vim.g.neovide_cursor_vfx_mode = "ripple"
    vim.g.neovide_cursor_animation_length = 0.08
    vim.g.neovide_cursor_trail_size = 0.4
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true

    set_keymaps()
  end
end

return neovide
