-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Gruvbox Dark (Gogh)'
  else
    return 'Builtin Solarized Light'
  end
end

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

config.webgpu_power_preference = 'HighPerformance'
 config.webgpu_preferred_adapter = {
   backend = 'Vulcan',
   device = 7308,
   device_type = 'DiscreteGpu',
   driver = 'NVIDIA',
   driver_info = '580.76.05',
   name = 'NVIDIA GeForce GTX 1050 Ti',
   vendor = 4318,
 }
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
    inactive_tab_edge = '#222222',
  },
}
config.window_frame = {
  active_titlebar_bg = '#151515',
  inactive_titlebar_bg = 'black',
}
config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  }
}
config.keys = {
  {
    key = '|',
    mods = 'SHIFT|CTRL|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  }
}

-- and finally, return the configuration to wezterm
return config-- Pull in the wezterm API
