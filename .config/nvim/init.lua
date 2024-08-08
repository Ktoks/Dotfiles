require "options"
require "keymaps"
require "Lazy"
require "autocommands"
<<<<<<< HEAD

vim.g.loaded_ruby_provider = 0


if vim.g.neovide then
  vim.o.guifont = "monospace:h18"               -- the font used in graphical neovim applications
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_scroll_animation_far_lines = 0.1

  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false

  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5

  vim.g.neovide_scale_factor = 1.0

  vim.g.neovide_fullscreen = false

  vim.g.transparency = 1.0
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_transparency = 1.0


  -- vim.g.neovide_theme = "dark"

end
=======
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
