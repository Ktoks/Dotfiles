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

-- 1. Remove the OS title bar and merge minimize/maximize/exit into WezTerm's tab bar
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

-- Hide the entire tab line completely if you only have one terminal window open
config.hide_tab_bar_if_only_one_tab = true

-- config.front_end = 'OpenGL'
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

 -- configuration for blackhawk laptop
 -- config.webgpu_preferred_adapter = {
 --   backend = 'Vulcan',
 --   device = 7308,
 --   device_type = 'DiscreteGpu',
 --   driver = 'NVIDIA',
 --   driver_info = '580.76.05',
 --   name = 'NVIDIA GeForce GTX 1050 Ti',
 --   vendor = 4318,
 -- }
config.webgpu_preferred_adapter = {
  backend = 'Vulcan',
  device = 8712,
  device_type = 'DiscreteGpu',
  driver = 'NVIDIA',
  driver_info = '595.71.05',
  name = 'NVIDIA GeForce RTX 3080 Ti',
  vendor = 4318,
}

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
config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = '|',
    mods = 'SHIFT|CTRL|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

config.mouse_bindings = {
  -- Override default un-modified left-click so it finishes selections instead of opening links
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection('ClipboardAndPrimarySelection'),
  },

  -- Bind CTRL + Left-Click to open the hyperlink under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },

  -- Prevent terminal apps (like Helix) from intercepting the initial mouse down when holding CTRL for hyperlinks
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.Nop,
  },
}

return config
