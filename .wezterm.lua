-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.webgpu_power_preference = 'HighPerformance'
--
-- config.webgpu_preferred_adapter = {
--   backend = 'Vulcan',
--   device = 8712,
--   device_type = 'DiscreteGpu',
--   driver = 'NVIDIA',
--   driver_info = '55.58.02',
--   name = 'NVIDIA GeForce RTX 3080 Ti',
--   vendor = 4318,
-- }
-- config.front_end = 'WebGpu'

config.front_end = 'OpenGL'

-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.colors = {
  background = 'black',
  tab_bar = {
    inactive_tab_edge = '#111111',
  },
}
config.window_frame = {
  active_titlebar_bg = '#111111',
  inactive_titlebar_bg = '#000000',
}

-- and finally, return the configuration to wezterm
return config-- Pull in the wezterm API
