local wezterm = require 'wezterm'

config = wezterm.config_builder()
-- config.font = wezterm.font("Iosevka Term")
config.font_size = 11.0
config.window_padding = {
  top = 1,
  left = 1,
  right = 0,
  bottom = 0,
}
config.use_resize_increments = true
config.colors = { foreground = "#ffffff", }
config.force_reverse_video_cursor = true
config.initial_cols = 98
config.background = {
  {
    source = {Color="black"},
    opacity = 0.91,
    height='100%',
    width='100%'
  },
}
config.window_close_confirmation = "NeverPrompt"
config.swallow_mouse_click_on_pane_focus = true
config.window_frame = {
  font_size = 10,
}
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config
